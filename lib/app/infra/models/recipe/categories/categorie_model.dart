// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'categorie_model.freezed.dart';
part 'categorie_model.g.dart';

@freezed
abstract class CategorieModel with _$CategorieModel {
  factory CategorieModel({
    int? id,
    String? name,
    String? description,
    DateTime? created_at,
    DateTime? updated_at,
  }) = _CategorieModel;
  factory CategorieModel.fromJson(Map<String, dynamic> json) =>
      _$CategorieModelFromJson(json);
}
