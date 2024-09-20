// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/infra/models/recipe/ingredients/ingredient_model.dart';
import 'package:recipe_food/app/infra/models/recipe/preparation_steps/preparation_step_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_image/recipe_image_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_like/recipe_like_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';

part 'recipe_model.freezed.dart';
part 'recipe_model.g.dart';

@freezed
abstract class RecipeModel with _$RecipeModel {
  factory RecipeModel({
    String? id,
    String? user_id,
    String? title,
    String? short_description,
    int? cooking_time,
    int? difficulty,
    int? calories,
    int? servings,
    int? categorie_id,
    DateTime? created_at,
    DateTime? updated_at,
    // Nuevos campos para relaciones
    CategorieModel? categorie,
    List<IngredientModel>? ingredients,
    List<PreparationStepModel>? steps,
    List<RecipeImageModel>? images,
    UserModel? user,
    List<RecipeLikeModel>? like,
  }) = _RecipeModel;
  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
}
