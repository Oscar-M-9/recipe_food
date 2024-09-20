// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipe_like_model.freezed.dart';
part 'recipe_like_model.g.dart';

@freezed
abstract class RecipeLikeModel with _$RecipeLikeModel {
  factory RecipeLikeModel({
    int? id,
    String? user_id,
    String? recipe_id,
    DateTime? created_at,
  }) = _RecipeLikeModel;
  factory RecipeLikeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeLikeModelFromJson(json);
}
