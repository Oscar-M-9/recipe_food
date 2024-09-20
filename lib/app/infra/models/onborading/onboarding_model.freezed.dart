// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OnboardingModel _$OnboardingModelFromJson(Map<String, dynamic> json) {
  return _OnboardingModel.fromJson(json);
}

/// @nodoc
mixin _$OnboardingModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;
  bool get skip => throw _privateConstructorUsedError;

  /// Serializes this OnboardingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingModelCopyWith<OnboardingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingModelCopyWith<$Res> {
  factory $OnboardingModelCopyWith(
          OnboardingModel value, $Res Function(OnboardingModel) then) =
      _$OnboardingModelCopyWithImpl<$Res, OnboardingModel>;
  @useResult
  $Res call({String title, String description, String image, bool skip});
}

/// @nodoc
class _$OnboardingModelCopyWithImpl<$Res, $Val extends OnboardingModel>
    implements $OnboardingModelCopyWith<$Res> {
  _$OnboardingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? image = null,
    Object? skip = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      skip: null == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingModelImplCopyWith<$Res>
    implements $OnboardingModelCopyWith<$Res> {
  factory _$$OnboardingModelImplCopyWith(_$OnboardingModelImpl value,
          $Res Function(_$OnboardingModelImpl) then) =
      __$$OnboardingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String description, String image, bool skip});
}

/// @nodoc
class __$$OnboardingModelImplCopyWithImpl<$Res>
    extends _$OnboardingModelCopyWithImpl<$Res, _$OnboardingModelImpl>
    implements _$$OnboardingModelImplCopyWith<$Res> {
  __$$OnboardingModelImplCopyWithImpl(
      _$OnboardingModelImpl _value, $Res Function(_$OnboardingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? image = null,
    Object? skip = null,
  }) {
    return _then(_$OnboardingModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
      skip: null == skip
          ? _value.skip
          : skip // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnboardingModelImpl implements _OnboardingModel {
  _$OnboardingModelImpl(
      {required this.title,
      required this.description,
      required this.image,
      this.skip = true});

  factory _$OnboardingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnboardingModelImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  final String image;
  @override
  @JsonKey()
  final bool skip;

  @override
  String toString() {
    return 'OnboardingModel(title: $title, description: $description, image: $image, skip: $skip)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.skip, skip) || other.skip == skip));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, description, image, skip);

  /// Create a copy of OnboardingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingModelImplCopyWith<_$OnboardingModelImpl> get copyWith =>
      __$$OnboardingModelImplCopyWithImpl<_$OnboardingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnboardingModelImplToJson(
      this,
    );
  }
}

abstract class _OnboardingModel implements OnboardingModel {
  factory _OnboardingModel(
      {required final String title,
      required final String description,
      required final String image,
      final bool skip}) = _$OnboardingModelImpl;

  factory _OnboardingModel.fromJson(Map<String, dynamic> json) =
      _$OnboardingModelImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  String get image;
  @override
  bool get skip;

  /// Create a copy of OnboardingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingModelImplCopyWith<_$OnboardingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
