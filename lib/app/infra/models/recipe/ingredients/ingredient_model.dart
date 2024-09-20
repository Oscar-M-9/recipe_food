// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ingredient_model.freezed.dart';
part 'ingredient_model.g.dart';

@freezed
abstract class IngredientModel with _$IngredientModel {
  factory IngredientModel({
    int? id,
    String? recipe_id,
    String? name,
    String? quantity,
    DateTime? created_at,
    DateTime? updated_at,
  }) = _IngredientModel;
  factory IngredientModel.fromJson(Map<String, dynamic> json) =>
      _$IngredientModelFromJson(json);
}
