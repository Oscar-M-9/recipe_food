// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SavedRecipeModel _$SavedRecipeModelFromJson(Map<String, dynamic> json) {
  return _SavedRecipeModel.fromJson(json);
}

/// @nodoc
mixin _$SavedRecipeModel {
  int? get id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get recipe_id => throw _privateConstructorUsedError;

  /// Serializes this SavedRecipeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SavedRecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SavedRecipeModelCopyWith<SavedRecipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SavedRecipeModelCopyWith<$Res> {
  factory $SavedRecipeModelCopyWith(
          SavedRecipeModel value, $Res Function(SavedRecipeModel) then) =
      _$SavedRecipeModelCopyWithImpl<$Res, SavedRecipeModel>;
  @useResult
  $Res call({int? id, String? user_id, String? recipe_id});
}

/// @nodoc
class _$SavedRecipeModelCopyWithImpl<$Res, $Val extends SavedRecipeModel>
    implements $SavedRecipeModelCopyWith<$Res> {
  _$SavedRecipeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SavedRecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? recipe_id = freezed,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SavedRecipeModelImplCopyWith<$Res>
    implements $SavedRecipeModelCopyWith<$Res> {
  factory _$$SavedRecipeModelImplCopyWith(_$SavedRecipeModelImpl value,
          $Res Function(_$SavedRecipeModelImpl) then) =
      __$$SavedRecipeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? user_id, String? recipe_id});
}

/// @nodoc
class __$$SavedRecipeModelImplCopyWithImpl<$Res>
    extends _$SavedRecipeModelCopyWithImpl<$Res, _$SavedRecipeModelImpl>
    implements _$$SavedRecipeModelImplCopyWith<$Res> {
  __$$SavedRecipeModelImplCopyWithImpl(_$SavedRecipeModelImpl _value,
      $Res Function(_$SavedRecipeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SavedRecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? recipe_id = freezed,
  }) {
    return _then(_$SavedRecipeModelImpl(
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SavedRecipeModelImpl implements _SavedRecipeModel {
  _$SavedRecipeModelImpl({this.id, this.user_id, this.recipe_id});

  factory _$SavedRecipeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SavedRecipeModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? user_id;
  @override
  final String? recipe_id;

  @override
  String toString() {
    return 'SavedRecipeModel(id: $id, user_id: $user_id, recipe_id: $recipe_id)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SavedRecipeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.recipe_id, recipe_id) ||
                other.recipe_id == recipe_id));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, user_id, recipe_id);

  /// Create a copy of SavedRecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SavedRecipeModelImplCopyWith<_$SavedRecipeModelImpl> get copyWith =>
      __$$SavedRecipeModelImplCopyWithImpl<_$SavedRecipeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SavedRecipeModelImplToJson(
      this,
    );
  }
}

abstract class _SavedRecipeModel implements SavedRecipeModel {
  factory _SavedRecipeModel(
      {final int? id,
      final String? user_id,
      final String? recipe_id}) = _$SavedRecipeModelImpl;

  factory _SavedRecipeModel.fromJson(Map<String, dynamic> json) =
      _$SavedRecipeModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get user_id;
  @override
  String? get recipe_id;

  /// Create a copy of SavedRecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SavedRecipeModelImplCopyWith<_$SavedRecipeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
