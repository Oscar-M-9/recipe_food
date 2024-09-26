import 'package:hive/hive.dart';
import 'package:recipe_food/app/infra/models/collection/collection_model.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/infra/models/recipe/ingredients/ingredient_model.dart';
import 'package:recipe_food/app/infra/models/recipe/preparation_steps/preparation_step_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_image/recipe_image_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_like/recipe_like_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/saved_recipe/saved_recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';

class SavedRecipeService {
  final supabase = SupabaseManager().client;

  // Registrar la colección
  Future<void> insert(String recipeId, String userId) async {
    await supabase.from('saved_recipes').insert({
      'user_id': userId,
      'recipe_id': recipeId,
    });
  }

  Future<void> delete(String recipeId, String userId) async {
    await supabase
        .from('saved_recipes')
        .delete()
        .eq('user_id', userId)
        .eq('recipe_id', recipeId);
  }

  // Verificar si ya está registrado
  // Future<String?> isRegistered(String name) async {
  //   final box = await Hive.openBox('user');
  //   final user = box.get('user') as UserModel;

  //   // Usamos trim() para asegurarnos de que la verificación sea precisa
  //   final trimmedName = name.trim();

  //   final res = await supabase
  //       .from('saved_recipes')
  //       .select()
  //       .eq('name', trimmedName)
  //       .eq('user_id', user.id!);

  //   if (res.isNotEmpty) {
  //     return "Nombre ya registrado";
  //   }
  //   return null;
  // }

  // Obtener todas las colecciones
  Future<List<RecipeModel>> gerSavedRecipes(int page, int pageSize,
      {int maxReintentos = 1,
      Duration tiempoEspera = const Duration(seconds: 2)}) async {
    int reintentos = 0;
    List<RecipeModel> recipes = [];

    final box = await Hive.openBox('user');
    final user = box.get('user') as UserModel;

    while (reintentos < maxReintentos) {
      try {
        final response = await supabase
            .from('recipes')
            .select(
                '*, categories(*), recipe_images(*), recipe_ingredients(*), recipe_preparation_steps(*), users(*), recipe_likes(*), saved_recipes!inner(user_id)')
            .eq('saved_recipes.user_id', user.id!)
            .order('created_at', ascending: false)
            .range(page * pageSize, (page * pageSize) + pageSize - 1);

        // Verificar que la respuesta sea una lista
        if (response.isEmpty) {
          print('No se encontraron recetas.');
          break;
        }

        // Procesar cada receta de la lista
        for (final recipeData in response as List<dynamic>) {
          // Validar y extraer los datos si no son nulos
          var recipe = RecipeModel.fromJson(recipeData as Map<String, dynamic>);

          recipe = recipe.copyWith(
            categorie: recipeData['categories'] != null
                ? CategorieModel.fromJson(recipeData['categories'])
                : null,
            ingredients: recipeData['recipe_ingredients'] != null
                ? (recipeData['recipe_ingredients'] as List)
                    .map((ingredient) => IngredientModel.fromJson(ingredient))
                    .toList()
                : [],
            steps: recipeData['recipe_preparation_steps'] != null
                ? (recipeData['recipe_preparation_steps'] as List)
                    .map((step) => PreparationStepModel.fromJson(step))
                    .toList()
                : [],
            images: recipeData['recipe_images'] != null
                ? (recipeData['recipe_images'] as List)
                    .map((image) => RecipeImageModel.fromJson(image))
                    .toList()
                : [],
            user: recipeData['users'] != null
                ? UserModel.fromJson(recipeData['users'])
                : null,
            like: recipeData['recipe_likes'] != null
                ? (recipeData['recipe_likes'] as List)
                    .map((like) => RecipeLikeModel.fromJson(like))
                    .toList()
                : [],
            saved: recipeData['saved_recipes'] != null
                ? (recipeData['saved_recipes'] as List)
                        .any((element) => element['user_id'] == user.id)
                    ? SavedRecipeModel.fromJson((recipeData['saved_recipes']
                            as List)
                        .firstWhere((element) => element['user_id'] == user.id))
                    : null
                : null,
          );

          recipes.add(recipe);
        }

        break; // Salir del bucle si la operación es exitosa
      } on Exception catch (e) {
        reintentos++;
        if (reintentos >= maxReintentos) {
          rethrow; // Lanza la excepción si alcanzas el número máximo de reintentos
        }
        print("Error al obtener las recetas: $e");
        await Future.delayed(tiempoEspera); // Espera antes de reintentar
      }
    }

    return recipes;
  }
}
