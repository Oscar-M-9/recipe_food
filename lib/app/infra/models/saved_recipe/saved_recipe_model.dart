// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_recipe_model.freezed.dart';
part 'saved_recipe_model.g.dart';

@freezed
abstract class SavedRecipeModel with _$SavedRecipeModel {
  factory SavedRecipeModel({
    int? id,
    String? user_id,
    String? recipe_id,
  }) = _SavedRecipeModel;
  factory SavedRecipeModel.fromJson(Map<String, dynamic> json) =>
      _$SavedRecipeModelFromJson(json);
}
