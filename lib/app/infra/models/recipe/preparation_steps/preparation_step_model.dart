// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'preparation_step_model.freezed.dart';
part 'preparation_step_model.g.dart';

@freezed
abstract class PreparationStepModel with _$PreparationStepModel {
  factory PreparationStepModel({
    int? id,
    String? recipe_id,
    int? step_number,
    String? step_detail,
    DateTime? created_at,
    DateTime? updated_at,
  }) = _PreparationStepModel;
  factory PreparationStepModel.fromJson(Map<String, dynamic> json) =>
      _$PreparationStepModelFromJson(json);
}
