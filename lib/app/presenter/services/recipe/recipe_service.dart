import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/infra/models/recipe/ingredients/ingredient_model.dart';
import 'package:recipe_food/app/infra/models/recipe/preparation_steps/preparation_step_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_image/recipe_image_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_like/recipe_like_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/controllers/notification_manager.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class RecipeService {
  final SupabaseClient supabase = SupabaseManager().client;

  // ************* Agrega una nueva receta *******************
  // Método para agregar una receta con imágenes, ingredientes y pasos
  Future<void> addRecipe({
    required RecipeModel recipe,
    required CategorieModel categorie,
    required List<IngredientModel> ingredients,
    required List<PreparationStepModel> steps,
    required List<RecipeImageModel> images,
  }) async {
    const int notificationId = 1;
    int progress = 0;
    int totalSteps = images.length +
        ingredients.length +
        steps.length +
        3; // 3 for recipe, image URLs, and general data

    try {
      // Mostrar la notificación de progreso
      _showProgressNotification(notificationId, progress, totalSteps);

      // Step 1: Subir imágenes y obtener las URLs
      final imageUrls = <String>[];
      for (final image in images) {
        final file = File(image.image_url!);
        final fileName = path.basename(file.path);
        final imageUrl = await uploadImage(
          file,
          // 'recipes/${DateTime.now().millisecondsSinceEpoch}/${image.name}',
          'recipes/${recipe.user_id}/$fileName',
        );
        if (imageUrl != null) {
          imageUrls.add(imageUrl);
        }
        // Actualizar progreso tras cada imagen subida
        progress++;
        _updateProgressNotification(notificationId, progress, totalSteps);
      }

      // Step 2: Insertar los datos de la receta en la tabla 'recipes'
      final recipeResponse = await supabase.from('recipes').insert({
        'user_id': recipe.user_id,
        'title': recipe.title,
        'short_description': recipe.short_description,
        'cooking_time': recipe.cooking_time,
        'difficulty': recipe.difficulty,
        'calories': recipe.calories,
        'servings': recipe.servings,
        'categorie_id': recipe.categorie_id,
      }).select();
      final recipeId = recipeResponse[0]['id'];

      // Actualizar progreso tras insertar la receta
      progress++;
      _updateProgressNotification(notificationId, progress, totalSteps);

      // Step 3: Insertar ingredientes
      for (final ingredient in ingredients) {
        await supabase.from('recipe_ingredients').insert({
          'recipe_id': recipeId,
          'name': ingredient.name,
          'quantity': ingredient.quantity,
        });
        // Actualizar progreso tras cada ingrediente insertado
        progress++;
        _updateProgressNotification(notificationId, progress, totalSteps);
      }

      // Step 4: Insertar los pasos
      for (final step in steps) {
        await supabase.from('recipe_preparation_steps').insert({
          'recipe_id': recipeId,
          'step_number': step.step_number,
          'step_detail': step.step_detail,
        });
        // Actualizar progreso tras cada paso insertado
        progress++;
        _updateProgressNotification(notificationId, progress, totalSteps);
      }

      // Step 5: Insertar las URLs de las imágenes
      for (final imageUrl in imageUrls) {
        await supabase.from('recipe_images').insert({
          'recipe_id': recipeId,
          'image_url': imageUrl,
        });
      }
      // Actualizar progreso tras insertar URLs de imágenes
      progress++;
      _updateProgressNotification(notificationId, progress, totalSteps);

      // Cancelar la notificación cuando todo el proceso haya terminado
      await flutterLocalNotificationsPlugin.cancel(notificationId);
      // Notificación final exitosa
      await _showCompletionNotification(notificationId, true);
    } catch (e) {
      if (kDebugMode) debugPrint('Error: $e');

      await flutterLocalNotificationsPlugin.cancel(notificationId);
      // Notificación de error
      await _showCompletionNotification(notificationId, false);
    }
  }

  // Función para mostrar notificación de finalización
  Future<void> _showCompletionNotification(int id, bool success) async {
    String title = success ? 'Subida Completa' : 'Error en la Subida';
    String body = success
        ? 'La receta se ha subido exitosamente.'
        : 'Ocurrió un error al subir la receta.';

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'completion_channel',
      'Completion Notification',
      channelDescription: 'Notifica cuando la tarea ha finalizado.',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'drawable/ic_notification',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'recipe_completion',
    );
  }

  // Función para mostrar la notificación inicial
  void _showProgressNotification(int id, int progress, int maxProgress) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_channel',
      'Progress Notification',
      channelDescription: 'Shows the progress of an ongoing task.',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      indeterminate: false,
      icon: 'drawable/ic_notification',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      'Subiendo receta',
      'Progreso: 0%',
      platformChannelSpecifics,
      payload: 'recipe_upload',
    );
  }

// Función para actualizar la notificación de progreso
  void _updateProgressNotification(
      int id, int progress, int maxProgress) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_channel',
      'Progress Notification',
      channelDescription: 'Shows the progress of an ongoing task.',
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      indeterminate: false,
      icon: 'drawable/ic_notification',
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      id,
      'Subiendo receta',
      'Progreso: ${(progress / maxProgress * 100).toStringAsFixed(0)}%',
      platformChannelSpecifics,
      payload: 'recipe_upload',
    );
  }

  // funcion que sube la imagen a supabase y me retorna una url
  Future<String?> uploadImage(File file, String path) async {
    try {
      // Obtén la extensión del archivo
      final fileExtension = file.path.split('.').last;
      // Usa la función getMimeType para obtener el tipo MIME correcto
      final mimeType = getMimeType(fileExtension);

      final storage = supabase.storage.from('image_recipe');
      await storage.upload(
        path, // The path in the storage bucket where the file will be stored
        file, // The file to be uploaded
        fileOptions: FileOptions(
          upsert: true,
          contentType: mimeType,
        ),
      );

      // Return the URL of the uploaded image
      return storage.getPublicUrl(path);
    } catch (e) {
      if (kDebugMode) debugPrint('Error - uploadImage: $e');
      return null;
    }
  }

  String getMimeType(String fileExtension) {
    switch (fileExtension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      default:
        throw Exception('Unsupported file extension');
    }
  }

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

    while (reintentos < maxReintentos) {
      try {
        final response = await supabase
            .from('recipes')
            .select(
                '*, categories(*), recipe_images(*), recipe_ingredients(*), recipe_preparation_steps(*), users(*), recipe_likes(*)')
            .order('created_at', ascending: false)
            .range(page * pageSize, (page * pageSize) + pageSize - 1);

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
