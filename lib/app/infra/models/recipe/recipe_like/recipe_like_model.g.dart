// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_like_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecipeLikeModelImpl _$$RecipeLikeModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RecipeLikeModelImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: json['user_id'] as String?,
      recipe_id: json['recipe_id'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$RecipeLikeModelImplToJson(
        _$RecipeLikeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'recipe_id': instance.recipe_id,
      'created_at': instance.created_at?.toIso8601String(),
    };
