// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_image_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeImageModel _$RecipeImageModelFromJson(Map<String, dynamic> json) {
  return _RecipeImage.fromJson(json);
}

/// @nodoc
mixin _$RecipeImageModel {
  int? get id => throw _privateConstructorUsedError;
  String? get recipe_id => throw _privateConstructorUsedError;
  String? get image_url => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at => throw _privateConstructorUsedError;

  /// Serializes this RecipeImageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeImageModelCopyWith<RecipeImageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeImageModelCopyWith<$Res> {
  factory $RecipeImageModelCopyWith(
          RecipeImageModel value, $Res Function(RecipeImageModel) then) =
      _$RecipeImageModelCopyWithImpl<$Res, RecipeImageModel>;
  @useResult
  $Res call(
      {int? id,
      String? recipe_id,
      String? image_url,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class _$RecipeImageModelCopyWithImpl<$Res, $Val extends RecipeImageModel>
    implements $RecipeImageModelCopyWith<$Res> {
  _$RecipeImageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? recipe_id = freezed,
    Object? image_url = freezed,
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
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
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
abstract class _$$RecipeImageImplCopyWith<$Res>
    implements $RecipeImageModelCopyWith<$Res> {
  factory _$$RecipeImageImplCopyWith(
          _$RecipeImageImpl value, $Res Function(_$RecipeImageImpl) then) =
      __$$RecipeImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? recipe_id,
      String? image_url,
      DateTime? created_at,
      DateTime? updated_at});
}

/// @nodoc
class __$$RecipeImageImplCopyWithImpl<$Res>
    extends _$RecipeImageModelCopyWithImpl<$Res, _$RecipeImageImpl>
    implements _$$RecipeImageImplCopyWith<$Res> {
  __$$RecipeImageImplCopyWithImpl(
      _$RecipeImageImpl _value, $Res Function(_$RecipeImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeImageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? recipe_id = freezed,
    Object? image_url = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
  }) {
    return _then(_$RecipeImageImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      recipe_id: freezed == recipe_id
          ? _value.recipe_id
          : recipe_id // ignore: cast_nullable_to_non_nullable
              as String?,
      image_url: freezed == image_url
          ? _value.image_url
          : image_url // ignore: cast_nullable_to_non_nullable
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
class _$RecipeImageImpl implements _RecipeImage {
  _$RecipeImageImpl(
      {this.id,
      this.recipe_id,
      this.image_url,
      this.created_at,
      this.updated_at});

  factory _$RecipeImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeImageImplFromJson(json);

  @override
  final int? id;
  @override
  final String? recipe_id;
  @override
  final String? image_url;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;

  @override
  String toString() {
    return 'RecipeImageModel(id: $id, recipe_id: $recipe_id, image_url: $image_url, created_at: $created_at, updated_at: $updated_at)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.recipe_id, recipe_id) ||
                other.recipe_id == recipe_id) &&
            (identical(other.image_url, image_url) ||
                other.image_url == image_url) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, recipe_id, image_url, created_at, updated_at);

  /// Create a copy of RecipeImageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeImageImplCopyWith<_$RecipeImageImpl> get copyWith =>
      __$$RecipeImageImplCopyWithImpl<_$RecipeImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeImageImplToJson(
      this,
    );
  }
}

abstract class _RecipeImage implements RecipeImageModel {
  factory _RecipeImage(
      {final int? id,
      final String? recipe_id,
      final String? image_url,
      final DateTime? created_at,
      final DateTime? updated_at}) = _$RecipeImageImpl;

  factory _RecipeImage.fromJson(Map<String, dynamic> json) =
      _$RecipeImageImpl.fromJson;

  @override
  int? get id;
  @override
  String? get recipe_id;
  @override
  String? get image_url;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at;

  /// Create a copy of RecipeImageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeImageImplCopyWith<_$RecipeImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
