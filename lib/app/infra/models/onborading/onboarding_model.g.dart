// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OnboardingModelImpl _$$OnboardingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OnboardingModelImpl(
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      skip: json['skip'] as bool? ?? true,
    );

Map<String, dynamic> _$$OnboardingModelImplToJson(
        _$OnboardingModelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'skip': instance.skip,
    };
