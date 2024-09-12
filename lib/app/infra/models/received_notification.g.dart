// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'received_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecivedNotificationModelImpl _$$RecivedNotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$RecivedNotificationModelImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String?,
      body: json['body'] as String?,
      payload: json['payload'] as String?,
    );

Map<String, dynamic> _$$RecivedNotificationModelImplToJson(
        _$RecivedNotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'payload': instance.payload,
    };
