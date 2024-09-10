import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_model.freezed.dart';
part 'onboarding_model.g.dart';

@freezed
abstract class OnboardingModel with _$OnboardingModel {
  factory OnboardingModel({
    required String title,
    required String description,
    required String image,
    @Default(true) bool skip,
  }) = _OnboardingModel;
  factory OnboardingModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingModelFromJson(json);
}
