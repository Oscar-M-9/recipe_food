// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_like_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeLikeModel _$RecipeLikeModelFromJson(Map<String, dynamic> json) {
  return _RecipeLikeModel.fromJson(json);
}

/// @nodoc
mixin _$RecipeLikeModel {
  int? get id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get recipe_id => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;

  /// Serializes this RecipeLikeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeLikeModelCopyWith<RecipeLikeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeLikeModelCopyWith<$Res> {
  factory $RecipeLikeModelCopyWith(
          RecipeLikeModel value, $Res Function(RecipeLikeModel) then) =
      _$RecipeLikeModelCopyWithImpl<$Res, RecipeLikeModel>;
  @useResult
  $Res call(
      {int? id, String? user_id, String? recipe_id, DateTime? created_at});
}

/// @nodoc
class _$RecipeLikeModelCopyWithImpl<$Res, $Val extends RecipeLikeModel>
    implements $RecipeLikeModelCopyWith<$Res> {
  _$RecipeLikeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? recipe_id = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      recipe_id: freezed == recipe_id
          ? _value.recipe_id
          : recipe_id // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecipeLikeModelImplCopyWith<$Res>
    implements $RecipeLikeModelCopyWith<$Res> {
  factory _$$RecipeLikeModelImplCopyWith(_$RecipeLikeModelImpl value,
          $Res Function(_$RecipeLikeModelImpl) then) =
      __$$RecipeLikeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id, String? user_id, String? recipe_id, DateTime? created_at});
}

/// @nodoc
class __$$RecipeLikeModelImplCopyWithImpl<$Res>
    extends _$RecipeLikeModelCopyWithImpl<$Res, _$RecipeLikeModelImpl>
    implements _$$RecipeLikeModelImplCopyWith<$Res> {
  __$$RecipeLikeModelImplCopyWithImpl(
      _$RecipeLikeModelImpl _value, $Res Function(_$RecipeLikeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? recipe_id = freezed,
    Object? created_at = freezed,
  }) {
    return _then(_$RecipeLikeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      recipe_id: freezed == recipe_id
          ? _value.recipe_id
          : recipe_id // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeLikeModelImpl implements _RecipeLikeModel {
  _$RecipeLikeModelImpl(
      {this.id, this.user_id, this.recipe_id, this.created_at});

  factory _$RecipeLikeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeLikeModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? user_id;
  @override
  final String? recipe_id;
  @override
  final DateTime? created_at;

  @override
  String toString() {
    return 'RecipeLikeModel(id: $id, user_id: $user_id, recipe_id: $recipe_id, created_at: $created_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeLikeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.recipe_id, recipe_id) ||
                other.recipe_id == recipe_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, user_id, recipe_id, created_at);

  /// Create a copy of RecipeLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeLikeModelImplCopyWith<_$RecipeLikeModelImpl> get copyWith =>
      __$$RecipeLikeModelImplCopyWithImpl<_$RecipeLikeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeLikeModelImplToJson(
      this,
    );
  }
}

abstract class _RecipeLikeModel implements RecipeLikeModel {
  factory _RecipeLikeModel(
      {final int? id,
      final String? user_id,
      final String? recipe_id,
      final DateTime? created_at}) = _$RecipeLikeModelImpl;

  factory _RecipeLikeModel.fromJson(Map<String, dynamic> json) =
      _$RecipeLikeModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get user_id;
  @override
  String? get recipe_id;
  @override
  DateTime? get created_at;

  /// Create a copy of RecipeLikeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeLikeModelImplCopyWith<_$RecipeLikeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
