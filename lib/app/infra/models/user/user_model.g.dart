// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      pronouns: fields[2] as String?,
      username: fields[3] as String?,
      phone: fields[4] as String?,
      description: fields[5] as String?,
      email: fields[6] as String?,
      avatar_url: fields[7] as String?,
      authId: fields[8] as String?,
      created_at: fields[9] as DateTime?,
      updated_at: fields[10] as DateTime?,
      terms_and_conditions: fields[11] as bool?,
      status: fields[12] as int?,
      use_rol: fields[13] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.pronouns)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.avatar_url)
      ..writeByte(8)
      ..write(obj.authId)
      ..writeByte(9)
      ..write(obj.created_at)
      ..writeByte(10)
      ..write(obj.updated_at)
      ..writeByte(11)
      ..write(obj.terms_and_conditions)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.use_rol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String?,
      name: json['name'] as String?,
      pronouns: json['pronouns'] as String?,
      username: json['username'] as String?,
      phone: json['phone'] as String?,
      description: json['description'] as String?,
      email: json['email'] as String?,
      avatar_url: json['avatar_url'] as String?,
      authId: json['authId'] as String?,
      created_at: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updated_at: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      terms_and_conditions: json['terms_and_conditions'] as bool? ?? true,
      status: (json['status'] as num?)?.toInt(),
      use_rol: (json['use_rol'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pronouns': instance.pronouns,
      'username': instance.username,
      'phone': instance.phone,
      'description': instance.description,
      'email': instance.email,
      'avatar_url': instance.avatar_url,
      'authId': instance.authId,
      'created_at': instance.created_at?.toIso8601String(),
      'updated_at': instance.updated_at?.toIso8601String(),
      'terms_and_conditions': instance.terms_and_conditions,
      'status': instance.status,
      'use_rol': instance.use_rol,
    };
