import 'package:hive/hive.dart';
import 'package:recipe_food/app/infra/models/others/user_notification.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';

class NotificationService {
  final supabase = SupabaseManager().client;

  // Obtener los likes de la recerta mas el usuario quien dio like
  Future<List<UserNotification>> getRecipesWithLikes() async {
    final box = await Hive.openBox('user');
    final user = box.get('user') as UserModel;

    List<UserNotification> notifications = [];
    final response = await supabase
        .from('recipe_likes')
        .select(
            'recipe_id, user_id, recipes(*), user:user_id(*)') // Obtén toda la información de las recetas y los usuarios que dieron like
        .eq('recipes.user_id',
            user.id!) // Filtra por el creador de la receta (el usuario actual)
        .filter('user_id', 'neq',
            user.id!) // Excluye los likes del creador de la receta
        .limit(10);

    for (var data in response) {
      var notification = UserNotification();
      notification = notification.copyWith(
        user_recipe: user,
        user: UserModel.fromJson(data['user']),
        recipe: RecipeModel.fromJson(data['recipes']),
        type: 'like',
      );
      notifications.add(notification);
    }

    print("response --- $response");

    return notifications;
  }
}
