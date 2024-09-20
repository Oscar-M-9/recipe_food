// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_image_model.freezed.dart';
part 'recipe_image_model.g.dart';

@freezed
abstract class RecipeImageModel with _$RecipeImageModel {
  factory RecipeImageModel({
    int? id,
    String? recipe_id,
    String? image_url,
    DateTime? created_at,
    DateTime? updated_at,
  }) = _RecipeImage;
  factory RecipeImageModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeImageModelFromJson(json);
}
