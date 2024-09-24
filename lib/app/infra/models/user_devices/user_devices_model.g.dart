// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_devices_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDevicesModelImpl _$$UserDevicesModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserDevicesModelImpl(
      id: (json['id'] as num?)?.toInt(),
      user_id: json['user_id'] as String?,
      fcm_token: json['fcm_token'] as String?,
      device_name: json['device_name'] as String?,
      device_os: json['device_os'] as String?,
      last_login: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
      is_valid: json['is_valid'] as bool? ?? true,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$UserDevicesModelImplToJson(
        _$UserDevicesModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'fcm_token': instance.fcm_token,
      'device_name': instance.device_name,
      'device_os': instance.device_os,
      'last_login': instance.last_login?.toIso8601String(),
      'is_valid': instance.is_valid,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
    };
