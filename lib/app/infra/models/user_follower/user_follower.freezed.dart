// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_follower.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserFollower _$UserFollowerFromJson(Map<String, dynamic> json) {
  return _UserFollower.fromJson(json);
}

/// @nodoc
mixin _$UserFollower {
  String? get id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get follower_id => throw _privateConstructorUsedError;
  DateTime? get followed_at => throw _privateConstructorUsedError;

  /// Serializes this UserFollower to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserFollower
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserFollowerCopyWith<UserFollower> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFollowerCopyWith<$Res> {
  factory $UserFollowerCopyWith(
          UserFollower value, $Res Function(UserFollower) then) =
      _$UserFollowerCopyWithImpl<$Res, UserFollower>;
  @useResult
  $Res call(
      {String? id,
      String? user_id,
      String? follower_id,
      DateTime? followed_at});
}

/// @nodoc
class _$UserFollowerCopyWithImpl<$Res, $Val extends UserFollower>
    implements $UserFollowerCopyWith<$Res> {
  _$UserFollowerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserFollower
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? follower_id = freezed,
    Object? followed_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      follower_id: freezed == follower_id
          ? _value.follower_id
          : follower_id // ignore: cast_nullable_to_non_nullable
              as String?,
      followed_at: freezed == followed_at
          ? _value.followed_at
          : followed_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserFollowerImplCopyWith<$Res>
    implements $UserFollowerCopyWith<$Res> {
  factory _$$UserFollowerImplCopyWith(
          _$UserFollowerImpl value, $Res Function(_$UserFollowerImpl) then) =
      __$$UserFollowerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? user_id,
      String? follower_id,
      DateTime? followed_at});
}

/// @nodoc
class __$$UserFollowerImplCopyWithImpl<$Res>
    extends _$UserFollowerCopyWithImpl<$Res, _$UserFollowerImpl>
    implements _$$UserFollowerImplCopyWith<$Res> {
  __$$UserFollowerImplCopyWithImpl(
      _$UserFollowerImpl _value, $Res Function(_$UserFollowerImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserFollower
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? follower_id = freezed,
    Object? followed_at = freezed,
  }) {
    return _then(_$UserFollowerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      follower_id: freezed == follower_id
          ? _value.follower_id
          : follower_id // ignore: cast_nullable_to_non_nullable
              as String?,
      followed_at: freezed == followed_at
          ? _value.followed_at
          : followed_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserFollowerImpl implements _UserFollower {
  _$UserFollowerImpl(
      {this.id, this.user_id, this.follower_id, this.followed_at});

  factory _$UserFollowerImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserFollowerImplFromJson(json);

  @override
  final String? id;
  @override
  final String? user_id;
  @override
  final String? follower_id;
  @override
  final DateTime? followed_at;

  @override
  String toString() {
    return 'UserFollower(id: $id, user_id: $user_id, follower_id: $follower_id, followed_at: $followed_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserFollowerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.follower_id, follower_id) ||
                other.follower_id == follower_id) &&
            (identical(other.followed_at, followed_at) ||
                other.followed_at == followed_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, user_id, follower_id, followed_at);

  /// Create a copy of UserFollower
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserFollowerImplCopyWith<_$UserFollowerImpl> get copyWith =>
      __$$UserFollowerImplCopyWithImpl<_$UserFollowerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserFollowerImplToJson(
      this,
    );
  }
}

abstract class _UserFollower implements UserFollower {
  factory _UserFollower(
      {final String? id,
      final String? user_id,
      final String? follower_id,
      final DateTime? followed_at}) = _$UserFollowerImpl;

  factory _UserFollower.fromJson(Map<String, dynamic> json) =
      _$UserFollowerImpl.fromJson;

  @override
  String? get id;
  @override
  String? get user_id;
  @override
  String? get follower_id;
  @override
  DateTime? get followed_at;

  /// Create a copy of UserFollower
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserFollowerImplCopyWith<_$UserFollowerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
