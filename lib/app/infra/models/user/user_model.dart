// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 1)
abstract class UserModel with _$UserModel {
  factory UserModel({
    @HiveField(0) String? id,
    @HiveField(1) String? name,
    @HiveField(2) String? pronouns,
    @HiveField(3) String? username,
    @HiveField(4) String? phone,
    @HiveField(5) String? description,
    @HiveField(6) String? email,
    @HiveField(7) String? avatar_url,
    @HiveField(8) String? authId,
    @HiveField(9) DateTime? created_at,
    @HiveField(10) DateTime? updated_at,
    @HiveField(11) @Default(true) bool? terms_and_conditions,
    @HiveField(12) int? status,
    @HiveField(13) int? use_rol,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
