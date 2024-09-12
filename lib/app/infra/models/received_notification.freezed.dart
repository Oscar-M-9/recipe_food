// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'received_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReceivedNotificationModel _$ReceivedNotificationModelFromJson(
    Map<String, dynamic> json) {
  return _RecivedNotificationModel.fromJson(json);
}

/// @nodoc
mixin _$ReceivedNotificationModel {
  int get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  String? get payload => throw _privateConstructorUsedError;

  /// Serializes this ReceivedNotificationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReceivedNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReceivedNotificationModelCopyWith<ReceivedNotificationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceivedNotificationModelCopyWith<$Res> {
  factory $ReceivedNotificationModelCopyWith(ReceivedNotificationModel value,
          $Res Function(ReceivedNotificationModel) then) =
      _$ReceivedNotificationModelCopyWithImpl<$Res, ReceivedNotificationModel>;
  @useResult
  $Res call({int id, String? title, String? body, String? payload});
}

/// @nodoc
class _$ReceivedNotificationModelCopyWithImpl<$Res,
        $Val extends ReceivedNotificationModel>
    implements $ReceivedNotificationModelCopyWith<$Res> {
  _$ReceivedNotificationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReceivedNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? body = freezed,
    Object? payload = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecivedNotificationModelImplCopyWith<$Res>
    implements $ReceivedNotificationModelCopyWith<$Res> {
  factory _$$RecivedNotificationModelImplCopyWith(
          _$RecivedNotificationModelImpl value,
          $Res Function(_$RecivedNotificationModelImpl) then) =
      __$$RecivedNotificationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String? title, String? body, String? payload});
}

/// @nodoc
class __$$RecivedNotificationModelImplCopyWithImpl<$Res>
    extends _$ReceivedNotificationModelCopyWithImpl<$Res,
        _$RecivedNotificationModelImpl>
    implements _$$RecivedNotificationModelImplCopyWith<$Res> {
  __$$RecivedNotificationModelImplCopyWithImpl(
      _$RecivedNotificationModelImpl _value,
      $Res Function(_$RecivedNotificationModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReceivedNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = freezed,
    Object? body = freezed,
    Object? payload = freezed,
  }) {
    return _then(_$RecivedNotificationModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      payload: freezed == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecivedNotificationModelImpl implements _RecivedNotificationModel {
  _$RecivedNotificationModelImpl(
      {required this.id, this.title, this.body, this.payload});

  factory _$RecivedNotificationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecivedNotificationModelImplFromJson(json);

  @override
  final int id;
  @override
  final String? title;
  @override
  final String? body;
  @override
  final String? payload;

  @override
  String toString() {
    return 'ReceivedNotificationModel(id: $id, title: $title, body: $body, payload: $payload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecivedNotificationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.payload, payload) || other.payload == payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, payload);

  /// Create a copy of ReceivedNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecivedNotificationModelImplCopyWith<_$RecivedNotificationModelImpl>
      get copyWith => __$$RecivedNotificationModelImplCopyWithImpl<
          _$RecivedNotificationModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecivedNotificationModelImplToJson(
      this,
    );
  }
}

abstract class _RecivedNotificationModel implements ReceivedNotificationModel {
  factory _RecivedNotificationModel(
      {required final int id,
      final String? title,
      final String? body,
      final String? payload}) = _$RecivedNotificationModelImpl;

  factory _RecivedNotificationModel.fromJson(Map<String, dynamic> json) =
      _$RecivedNotificationModelImpl.fromJson;

  @override
  int get id;
  @override
  String? get title;
  @override
  String? get body;
  @override
  String? get payload;

  /// Create a copy of ReceivedNotificationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecivedNotificationModelImplCopyWith<_$RecivedNotificationModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
