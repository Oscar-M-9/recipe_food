import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/infra/models/others/user_stats.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient supabase = SupabaseManager().client;

  Future<UserModel?> getUserData() async {
    try {
      final user = supabase.auth.currentUser;

      // Si no hay un usuario autenticado, retornamos null inmediatamente
      if (user == null) return null;

      // Hacemos la consulta a Supabase para obtener los datos del usuario
      final response = await supabase
          .from('users')
          .select('*')
          .eq('auth_id', user.id)
          .maybeSingle();

      // Si la respuesta contiene datos válidos, retornamos el modelo
      if (response != null && response.isNotEmpty) {
        var box = await Hive.openBox('user');
        final user = UserModel.fromJson(response);
        box.put('user', user);
        return user;
      } else {
        // Si no hay datos, retornamos null
        return null;
      }
    } catch (e) {
      // Si ocurre un error, lo manejamos o lo registramos
      if (kDebugMode) debugPrint("Error - datos del usuario: $e");
      return null;
    }
  }

  // * Get user stats
  Future<UserStats> getUserStats(String userId) async {
    try {
      final response =
          await supabase.rpc('get_user_stats', params: {'p_user_id': userId});
      return UserStats(
        followersCount: response[0]['followers_count'] as int?,
        followingCount: response[0]['following_count'] as int?,
        recipesCount: response[0]['recipes_count'] as int?,
      );
    } catch (e) {
      if (kDebugMode) debugPrint("Error - estadísticas user: $e");

      return UserStats();
    }
  }

  //* Followers
  // Future<int> getFollowersCount(String userId) async {
  //   try {
  //     final response = await supabase
  //         .from('user_followers')
  //         .select()
  //         .eq('follower_id', userId)
  //         .count();

  //     return response.count;
  //   } catch (e) {
  //     print("Error al obtener la cantidad de seguidores: $e");
  //     return 0;
  //   }
  // }

  // Future<int> getFollowingCount(String userId) async {
  //   try {
  //     final response = await supabase
  //         .from('user_followers')
  //         .select()
  //         .eq('user_id', userId)
  //         .count();

  //     return response.count;
  //   } catch (e) {
  //     print("Error al obtener la cantidad de seguidos: $e");
  //     return 0;
  //   }
  // }

  // // * Recipes
  // Future<int> getRecipesCount(String userId) async {
  //   try {
  //     final response =
  //         await supabase.from('recipes').select().eq('user_id', userId).count();
  //     return response.count;
  //   } catch (e) {
  //     print("Error al obtener la cantidad de recetas: $e");
  //     return 0;
  //   }
  // }

  // Future<int> getFavoritesCount() async {
  //   try {
  //     final String userId = supabase.auth.currentUser!.id;
  //     final response = await supabase
  //         .from('favorites')
  //         .select('count(*)')
  //         .eq('user_id', userId)
  //         .single();

  //     return response['count'];
  //   } catch (e) {
  //     print("Error al obtener la cantidad de favoritos: $e");
  //     return 0;
  //   }
  // }
}
