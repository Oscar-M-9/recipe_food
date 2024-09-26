// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SavedRecipeModelImpl _$$SavedRecipeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SavedRecipeModelImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: json['user_id'] as String?,
      recipe_id: json['recipe_id'] as String?,
    );

Map<String, dynamic> _$$SavedRecipeModelImplToJson(
        _$SavedRecipeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'recipe_id': instance.recipe_id,
    };
