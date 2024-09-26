import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/infra/models/recipe/ingredients/ingredient_model.dart';
import 'package:recipe_food/app/infra/models/recipe/preparation_steps/preparation_step_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_image/recipe_image_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_like/recipe_like_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/saved_recipe/saved_recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeService {
  final SupabaseClient supabase = SupabaseManager().client;

  // **************** Obtiene todas las categorias *********************
  // Método para obtener todas las categorías de la base de datos
  Future<List<CategorieModel?>> getCategories() async {
    try {
      // Realizamos la consulta para obtener todas las categorías
      final response = await supabase.from('categories').select();

      // Verificamos si hay algún error en la respuesta
      if (response.isEmpty) {
        if (kDebugMode) debugPrint("Error getCategories: No data found");
        return [];
      }

      // Mapeamos la respuesta a una lista de CategorieModel
      List<CategorieModel> categories = (response as List)
          .map((json) => CategorieModel.fromJson(json))
          .toList();

      return categories;
    } catch (e) {
      if (kDebugMode) debugPrint("Error al obtener las categorías: $e");
      return [];
    }
  }

  // ************** Obtiene las recetas por usuario *************************
  // Obtener recetas con todos los datos asociados
  Future<List<RecipeModel>> getRecipes(int page, int pageSize,
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
                '*, categories(*), recipe_images(*), recipe_ingredients(*), recipe_preparation_steps(*), users(*), recipe_likes(*), saved_recipes(*)')
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

  // Obtener recetas con todos los datos asociados al usuario
  Future<List<RecipeModel>> getRecipesByUser(
      int page, int pageSize, String userId,
      {int maxReintentos = 1,
      Duration tiempoEspera = const Duration(seconds: 2)}) async {
    int reintentos = 0;
    List<RecipeModel> recipes = [];

    while (reintentos < maxReintentos) {
      try {
        final response = await supabase
            .from('recipes')
            .select(
                '*, categories(*), recipe_images(*), recipe_ingredients(*), recipe_preparation_steps(*), users(*), recipe_likes(*)')
            .eq('user_id', userId)
            .order('created_at', ascending: false)
            .range(page * pageSize, (page * pageSize) + pageSize - 1);

        // if (response.error != null) {
        //   throw Exception(response.error!.message);
        // }

        for (final recipeData in response) {
          var recipe = RecipeModel.fromJson(recipeData);
          recipe = recipe.copyWith(
            categorie: CategorieModel.fromJson(recipeData['categories']),
            ingredients: (recipeData['recipe_ingredients'] as List)
                .map((ingredient) => IngredientModel.fromJson(ingredient))
                .toList(),
            steps: (recipeData['recipe_preparation_steps'] as List)
                .map((step) => PreparationStepModel.fromJson(step))
                .toList(),
            images: (recipeData['recipe_images'] as List)
                .map((image) => RecipeImageModel.fromJson(image))
                .toList(),
            user: UserModel.fromJson(recipeData['users']),
            like: (recipeData['recipe_likes'] as List)
                .map((image) => RecipeLikeModel.fromJson(image))
                .toList(),
          );
          recipes.add(recipe);
        }

        break;
      } on Exception catch (e) {
        reintentos++;
        if (reintentos >= maxReintentos) {
          rethrow;
        }
        print("Error al obtener las recetas: $e ");
        await Future.delayed(tiempoEspera);
      }
    }

    return recipes;
  }

  // * Likes a la receta publicada

  Future<bool> likeRecipe(String recipeId, String userId) async {
    try {
      await supabase.from('recipe_likes').insert({
        'recipe_id': recipeId,
        'user_id': userId,
      });

      return true;
    } catch (error) {
      // Handle unexpected errors
      debugPrint('Unexpected error liking recipe: $error');
      return false;
    }
  }

  Future<bool> unLikeRecipe(String recipeId, String userId) async {
    try {
      await supabase
          .from('recipe_likes')
          .delete()
          .eq('user_id', userId)
          .eq('recipe_id', recipeId);

      return true;
    } catch (error) {
      // Handle unexpected errors
      debugPrint('Unexpected error liking recipe: $error');
      return false;
    }
  }

  // Future<List<RecipeModel>> getFollowingUsersRecipes(
  //     String currentUserId, int page, int pageSize,
  //     {int maxReintentos = 1,
  //     Duration tiempoEspera = const Duration(seconds: 2)}) async {
  //   int reintentos = 0;
  //   List<RecipeModel> recipes = [];

  //   while (reintentos < maxReintentos) {
  //     try {
  //       final response = await supabase
  //           .from('recipes')
  //           .select(
  //               '*, categories(*), recipe_images(*), recipe_ingredients(*), recipe_preparation_steps(*), users(*) , user_followers(user_id, follower_id)')
  //           .order('created_at', ascending: false)
  //           // .in(
  //           //     'user_id',
  //           //     supabase
  //           //         .from('user_followers')
  //           //         .select('user_id')
  //           //         .eq('follower_id', currentUserId))
  //           .range(page * pageSize, (page * pageSize) + pageSize - 1);
  //       print("response ------- $response");

  //       for (final recipeData in response) {
  //         var recipe = RecipeModel.fromJson(recipeData);
  //         recipe = recipe.copyWith(
  //           categorie: CategorieModel.fromJson(recipeData['categories']),
  //           ingredients: (recipeData['recipe_ingredients'] as List)
  //               .map((ingredient) => IngredientModel.fromJson(ingredient))
  //               .toList(),
  //           steps: (recipeData['recipe_preparation_steps'] as List)
  //               .map((step) => PreparationStepModel.fromJson(step))
  //               .toList(),
  //           images: (recipeData['recipe_images'] as List)
  //               .map((image) => RecipeImageModel.fromJson(image))
  //               .toList(),
  //           user: UserModel.fromJson(recipeData['users']),
  //         );
  //         recipes.add(recipe);
  //       }

  //       break;
  //     } on Exception catch (e) {
  //       reintentos++;
  //       if (reintentos >= maxReintentos) {
  //         rethrow;
  //       }
  //       print("Error al obtener las recetas: $e ");
  //       await Future.delayed(tiempoEspera);
  //     }
  //   }

  //   return recipes;
  // }

  // Future<List<RecipeModel>> getRecipes(
  //     int page, int pageSize, String userId) async {
  //   final response = await supabase
  //       .from('recipes')
  //       .select()
  //       .eq('user_id', userId)
  //       .order('created_at', ascending: false)
  //       .range(page * pageSize, (page * pageSize) + pageSize - 1);

  //   final List<RecipeModel> recipes = [];

  //   for (final recipeData in response) {
  //     var recipe = RecipeModel.fromJson(recipeData);

  //     // Obtener la categoría de la receta
  //     final categorie = await getCategorie(recipe.categorie_id!);
  //     recipe = recipe.copyWith(categorie: categorie);

  //     // Obtener las imágenes de la receta
  //     final images = await getRecipeImages(recipe.id!);
  //     recipe = recipe.copyWith(images: images);

  //     // Obtener los ingredientes de la receta
  //     final ingredients = await getRecipeIngredients(recipe.id!);
  //     recipe = recipe.copyWith(ingredients: ingredients);

  //     // Obtener los pasos de la preparación de la receta
  //     final steps = await getRecipePreparationSteps(recipe.id!);
  //     recipe = recipe.copyWith(steps: steps);

  //     // Obtener al author de la receta
  //     final user = await getRecipeAuthor(recipe.user_id!);
  //     recipe = recipe.copyWith(user: user);

  //     recipes.add(recipe);
  //   }

  //   return recipes;
  // }

  // Obtener categoría
  // Future<CategorieModel?> getCategorie(int categorieId) async {
  //   final response = await supabase
  //       .from('categories')
  //       .select()
  //       .eq('id', categorieId)
  //       .single();

  //   if (response != null) {
  //     return CategorieModel.fromJson(response);
  //   }
  //   return null;
  // }

  // // Obtener imágenes de la receta
  // Future<List<RecipeImageModel>> getRecipeImages(String recipeId) async {
  //   final response =
  //       await supabase.from('recipe_images').select().eq('recipe_id', recipeId);

  //   return response
  //       .map<RecipeImageModel>((image) => RecipeImageModel.fromJson(image))
  //       .toList();
  // }

  // // Obtener ingredientes de la receta
  // Future<List<IngredientModel>> getRecipeIngredients(String recipeId) async {
  //   final response = await supabase
  //       .from('recipe_ingredients')
  //       .select()
  //       .eq('recipe_id', recipeId);

  //   return response
  //       .map<IngredientModel>(
  //           (ingredient) => IngredientModel.fromJson(ingredient))
  //       .toList();
  // }

  // // Obtener pasos de preparación de la receta
  // Future<List<PreparationStepModel>> getRecipePreparationSteps(
  //     String recipeId) async {
  //   final response = await supabase
  //       .from('recipe_preparation_steps')
  //       .select()
  //       .eq('recipe_id', recipeId)
  //       .order('step_number', ascending: true);

  //   return response
  //       .map<PreparationStepModel>(
  //           (step) => PreparationStepModel.fromJson(step))
  //       .toList();
  // }

  // // Obtener al autor de la receta
  // Future<UserModel?> getRecipeAuthor(String userId) async {
  //   final response =
  //       await supabase.from('users').select().eq('id', userId).maybeSingle();

  //   if (response != null) {
  //     return UserModel.fromJson(response);
  //   }
  //   return null;
  // }
}
