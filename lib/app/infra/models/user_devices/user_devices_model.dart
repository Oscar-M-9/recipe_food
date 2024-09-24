// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_devices_model.freezed.dart';
part 'user_devices_model.g.dart';

@freezed
abstract class UserDevicesModel with _$UserDevicesModel {
  factory UserDevicesModel({
    int? id,
    String? user_id,
    String? fcm_token,
    String? device_name,
    String? device_os,
    DateTime? last_login,
    @Default(true) bool? is_valid,
    DateTime? created_at,
    DateTime? updated_at,
  }) = _UserDevicesModel;
  factory UserDevicesModel.fromJson(Map<String, dynamic> json) =>
      _$UserDevicesModelFromJson(json);
}
