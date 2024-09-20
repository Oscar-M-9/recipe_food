// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserFollowerImpl _$$UserFollowerImplFromJson(Map<String, dynamic> json) =>
    _$UserFollowerImpl(
      id: json['id'] as String?,
      user_id: json['user_id'] as String?,
      follower_id: json['follower_id'] as String?,
      followed_at: json['followed_at'] == null
          ? null
          : DateTime.parse(json['followed_at'] as String),
    );

Map<String, dynamic> _$$UserFollowerImplToJson(_$UserFollowerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'follower_id': instance.follower_id,
      'followed_at': instance.followed_at?.toIso8601String(),
    };
