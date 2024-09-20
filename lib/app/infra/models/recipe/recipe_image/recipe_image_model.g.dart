// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeImageImpl _$$RecipeImageImplFromJson(Map<String, dynamic> json) =>
    _$RecipeImageImpl(
      id: (json['id'] as num?)?.toInt(),
      recipe_id: json['recipe_id'] as String?,
      image_url: json['image_url'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$RecipeImageImplToJson(_$RecipeImageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipe_id': instance.recipe_id,
      'image_url': instance.image_url,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
