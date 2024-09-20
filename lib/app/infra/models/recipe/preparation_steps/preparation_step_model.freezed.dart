// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preparation_step_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PreparationStepModel _$PreparationStepModelFromJson(Map<String, dynamic> json) {
  return _PreparationStepModel.fromJson(json);
}

/// @nodoc
mixin _$PreparationStepModel {
  int? get id => throw _privateConstructorUsedError;
  String? get recipe_id => throw _privateConstructorUsedError;
  int? get step_number => throw _privateConstructorUsedError;
  String? get step_detail => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;

  /// Serializes this PreparationStepModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PreparationStepModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PreparationStepModelCopyWith<PreparationStepModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreparationStepModelCopyWith<$Res> {
  factory $PreparationStepModelCopyWith(PreparationStepModel value,
          $Res Function(PreparationStepModel) then) =
      _$PreparationStepModelCopyWithImpl<$Res, PreparationStepModel>;
  @useResult
  $Res call(
      {int? id,
      String? recipe_id,
      int? step_number,
      String? step_detail,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class _$PreparationStepModelCopyWithImpl<$Res,
        $Val extends PreparationStepModel>
    implements $PreparationStepModelCopyWith<$Res> {
  _$PreparationStepModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PreparationStepModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? recipe_id = freezed,
    Object? step_number = freezed,
    Object? step_detail = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe_id: freezed == recipe_id
          ? _value.recipe_id
          : recipe_id // ignore: cast_nullable_to_non_nullable
              as String?,
      step_number: freezed == step_number
          ? _value.step_number
          : step_number // ignore: cast_nullable_to_non_nullable
              as int?,
      step_detail: freezed == step_detail
          ? _value.step_detail
          : step_detail // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PreparationStepModelImplCopyWith<$Res>
    implements $PreparationStepModelCopyWith<$Res> {
  factory _$$PreparationStepModelImplCopyWith(_$PreparationStepModelImpl value,
          $Res Function(_$PreparationStepModelImpl) then) =
      __$$PreparationStepModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? recipe_id,
      int? step_number,
      String? step_detail,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class __$$PreparationStepModelImplCopyWithImpl<$Res>
    extends _$PreparationStepModelCopyWithImpl<$Res, _$PreparationStepModelImpl>
    implements _$$PreparationStepModelImplCopyWith<$Res> {
  __$$PreparationStepModelImplCopyWithImpl(_$PreparationStepModelImpl _value,
      $Res Function(_$PreparationStepModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PreparationStepModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? recipe_id = freezed,
    Object? step_number = freezed,
    Object? step_detail = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$PreparationStepModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe_id: freezed == recipe_id
          ? _value.recipe_id
          : recipe_id // ignore: cast_nullable_to_non_nullable
              as String?,
      step_number: freezed == step_number
          ? _value.step_number
          : step_number // ignore: cast_nullable_to_non_nullable
              as int?,
      step_detail: freezed == step_detail
          ? _value.step_detail
          : step_detail // ignore: cast_nullable_to_non_nullable
              as String?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PreparationStepModelImpl implements _PreparationStepModel {
  _$PreparationStepModelImpl(
      {this.id,
      this.recipe_id,
      this.step_number,
      this.step_detail,
      this.created_at,
      this.updated_at});

  factory _$PreparationStepModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PreparationStepModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? recipe_id;
  @override
  final int? step_number;
  @override
  final String? step_detail;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;

  @override
  String toString() {
    return 'PreparationStepModel(id: $id, recipe_id: $recipe_id, step_number: $step_number, step_detail: $step_detail, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PreparationStepModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recipe_id, recipe_id) ||
                other.recipe_id == recipe_id) &&
            (identical(other.step_number, step_number) ||
                other.step_number == step_number) &&
            (identical(other.step_detail, step_detail) ||
                other.step_detail == step_detail) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, recipe_id, step_number,
      step_detail, created_at, updated_at);

  /// Create a copy of PreparationStepModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PreparationStepModelImplCopyWith<_$PreparationStepModelImpl>
      get copyWith =>
          __$$PreparationStepModelImplCopyWithImpl<_$PreparationStepModelImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PreparationStepModelImplToJson(
      this,
    );
  }
}

abstract class _PreparationStepModel implements PreparationStepModel {
  factory _PreparationStepModel(
      {final int? id,
      final String? recipe_id,
      final int? step_number,
      final String? step_detail,
      final DateTime? created_at,
      final DateTime? updated_at}) = _$PreparationStepModelImpl;

  factory _PreparationStepModel.fromJson(Map<String, dynamic> json) =
      _$PreparationStepModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get recipe_id;
  @override
  int? get step_number;
  @override
  String? get step_detail;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;

  /// Create a copy of PreparationStepModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PreparationStepModelImplCopyWith<_$PreparationStepModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
