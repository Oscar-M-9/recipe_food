import 'dart:io';

import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/infra/models/recipe/ingredients/ingredient_model.dart';
import 'package:recipe_food/app/infra/models/recipe/preparation_steps/preparation_step_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_image/recipe_image_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/presenter/controllers/notification/notification_controller.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

class AddRecipeService {
  // final WidgetRef ref;

  // AddRecipeService(this.ref);

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
    const int notificationId = 0;
    int progress = 0;
    // 3 for recipe, image URLs, and general data
    int totalSteps = images.length + ingredients.length + steps.length + 3;

    // Inicializa la notificación
    final messagingService = NotificationController.instance;

    try {
      // Mostrar la notificación de progreso
      messagingService.showProgressNotification(
          notificationId, progress, totalSteps);

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
        messagingService.updateProgressNotification(
            notificationId, progress, totalSteps);
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
      messagingService.updateProgressNotification(
          notificationId, progress, totalSteps);

      // Step 3: Insertar ingredientes
      for (final ingredient in ingredients) {
        await supabase.from('recipe_ingredients').insert({
          'recipe_id': recipeId,
          'name': ingredient.name,
          'quantity': ingredient.quantity,
        });
        // Actualizar progreso tras cada ingrediente insertado
        progress++;
        messagingService.updateProgressNotification(
            notificationId, progress, totalSteps);
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
        messagingService.updateProgressNotification(
            notificationId, progress, totalSteps);
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
      messagingService.updateProgressNotification(
          notificationId, progress, totalSteps);

      // Cancelar la notificación cuando todo el proceso haya terminado
      await messagingService.cancelNotification(notificationId);
      // Notificación final exitosa
      await messagingService.showCompletionNotification(notificationId, true);
    } catch (e) {
      if (kDebugMode) debugPrint('Error: $e');

      await messagingService.cancelNotification(notificationId);
      // Notificación de error
      await messagingService.showCompletionNotification(notificationId, false);
    }
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
}
