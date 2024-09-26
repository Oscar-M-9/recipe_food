// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeModelImpl _$$RecipeModelImplFromJson(Map<String, dynamic> json) =>
    _$RecipeModelImpl(
      id: json['id'] as String?,
      user_id: json['user_id'] as String?,
      title: json['title'] as String?,
      short_description: json['short_description'] as String?,
      cooking_time: (json['cooking_time'] as num?)?.toInt(),
      difficulty: (json['difficulty'] as num?)?.toInt(),
      calories: (json['calories'] as num?)?.toInt(),
      servings: (json['servings'] as num?)?.toInt(),
      categorie_id: (json['categorie_id'] as num?)?.toInt(),
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      categorie: json['categorie'] == null
          ? null
          : CategorieModel.fromJson(json['categorie'] as Map<String, dynamic>),
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => IngredientModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      steps: (json['steps'] as List<dynamic>?)
          ?.map((e) => PreparationStepModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => RecipeImageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      user: json['user'] == null
          ? null
          : UserModel.fromJson(json['user'] as Map<String, dynamic>),
      like: (json['like'] as List<dynamic>?)
          ?.map((e) => RecipeLikeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      saved: json['saved'] == null
          ? null
          : SavedRecipeModel.fromJson(json['saved'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$RecipeModelImplToJson(_$RecipeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'title': instance.title,
      'short_description': instance.short_description,
      'cooking_time': instance.cooking_time,
      'difficulty': instance.difficulty,
      'calories': instance.calories,
      'servings': instance.servings,
      'categorie_id': instance.categorie_id,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'categorie': instance.categorie,
      'ingredients': instance.ingredients,
      'steps': instance.steps,
      'images': instance.images,
      'user': instance.user,
      'like': instance.like,
      'saved': instance.saved,
    };
