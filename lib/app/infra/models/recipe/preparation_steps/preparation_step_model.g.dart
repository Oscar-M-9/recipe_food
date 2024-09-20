// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preparation_step_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PreparationStepModelImpl _$$PreparationStepModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PreparationStepModelImpl(
      id: (json['id'] as num?)?.toInt(),
      recipe_id: json['recipe_id'] as String?,
      step_number: (json['step_number'] as num?)?.toInt(),
      step_detail: json['step_detail'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$PreparationStepModelImplToJson(
        _$PreparationStepModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipe_id': instance.recipe_id,
      'step_number': instance.step_number,
      'step_detail': instance.step_detail,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
