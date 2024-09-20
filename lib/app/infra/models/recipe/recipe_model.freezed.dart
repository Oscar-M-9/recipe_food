// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recipe_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) {
  return _RecipeModel.fromJson(json);
}

/// @nodoc
mixin _$RecipeModel {
  String? get id => throw _privateConstructorUsedError;
  String? get user_id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get short_description => throw _privateConstructorUsedError;
  int? get cooking_time => throw _privateConstructorUsedError;
  int? get difficulty => throw _privateConstructorUsedError;
  int? get calories => throw _privateConstructorUsedError;
  int? get servings => throw _privateConstructorUsedError;
  int? get categorie_id => throw _privateConstructorUsedError;
  DateTime? get created_at => throw _privateConstructorUsedError;
  DateTime? get updated_at =>
      throw _privateConstructorUsedError; // Nuevos campos para relaciones
  CategorieModel? get categorie => throw _privateConstructorUsedError;
  List<IngredientModel>? get ingredients => throw _privateConstructorUsedError;
  List<PreparationStepModel>? get steps => throw _privateConstructorUsedError;
  List<RecipeImageModel>? get images => throw _privateConstructorUsedError;
  UserModel? get user => throw _privateConstructorUsedError;
  List<RecipeLikeModel>? get like => throw _privateConstructorUsedError;

  /// Serializes this RecipeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecipeModelCopyWith<RecipeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecipeModelCopyWith<$Res> {
  factory $RecipeModelCopyWith(
          RecipeModel value, $Res Function(RecipeModel) then) =
      _$RecipeModelCopyWithImpl<$Res, RecipeModel>;
  @useResult
  $Res call(
      {String? id,
      String? user_id,
      String? title,
      String? short_description,
      int? cooking_time,
      int? difficulty,
      int? calories,
      int? servings,
      int? categorie_id,
      DateTime? created_at,
      DateTime? updated_at,
      CategorieModel? categorie,
      List<IngredientModel>? ingredients,
      List<PreparationStepModel>? steps,
      List<RecipeImageModel>? images,
      UserModel? user,
      List<RecipeLikeModel>? like});

  $CategorieModelCopyWith<$Res>? get categorie;
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$RecipeModelCopyWithImpl<$Res, $Val extends RecipeModel>
    implements $RecipeModelCopyWith<$Res> {
  _$RecipeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? title = freezed,
    Object? short_description = freezed,
    Object? cooking_time = freezed,
    Object? difficulty = freezed,
    Object? calories = freezed,
    Object? servings = freezed,
    Object? categorie_id = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? categorie = freezed,
    Object? ingredients = freezed,
    Object? steps = freezed,
    Object? images = freezed,
    Object? user = freezed,
    Object? like = freezed,
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
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      short_description: freezed == short_description
          ? _value.short_description
          : short_description // ignore: cast_nullable_to_non_nullable
              as String?,
      cooking_time: freezed == cooking_time
          ? _value.cooking_time
          : cooking_time // ignore: cast_nullable_to_non_nullable
              as int?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: freezed == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int?,
      categorie_id: freezed == categorie_id
          ? _value.categorie_id
          : categorie_id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categorie: freezed == categorie
          ? _value.categorie
          : categorie // ignore: cast_nullable_to_non_nullable
              as CategorieModel?,
      ingredients: freezed == ingredients
          ? _value.ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<IngredientModel>?,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<PreparationStepModel>?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<RecipeImageModel>?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      like: freezed == like
          ? _value.like
          : like // ignore: cast_nullable_to_non_nullable
              as List<RecipeLikeModel>?,
    ) as $Val);
  }

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CategorieModelCopyWith<$Res>? get categorie {
    if (_value.categorie == null) {
      return null;
    }

    return $CategorieModelCopyWith<$Res>(_value.categorie!, (value) {
      return _then(_value.copyWith(categorie: value) as $Val);
    });
  }

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecipeModelImplCopyWith<$Res>
    implements $RecipeModelCopyWith<$Res> {
  factory _$$RecipeModelImplCopyWith(
          _$RecipeModelImpl value, $Res Function(_$RecipeModelImpl) then) =
      __$$RecipeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? user_id,
      String? title,
      String? short_description,
      int? cooking_time,
      int? difficulty,
      int? calories,
      int? servings,
      int? categorie_id,
      DateTime? created_at,
      DateTime? updated_at,
      CategorieModel? categorie,
      List<IngredientModel>? ingredients,
      List<PreparationStepModel>? steps,
      List<RecipeImageModel>? images,
      UserModel? user,
      List<RecipeLikeModel>? like});

  @override
  $CategorieModelCopyWith<$Res>? get categorie;
  @override
  $UserModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$RecipeModelImplCopyWithImpl<$Res>
    extends _$RecipeModelCopyWithImpl<$Res, _$RecipeModelImpl>
    implements _$$RecipeModelImplCopyWith<$Res> {
  __$$RecipeModelImplCopyWithImpl(
      _$RecipeModelImpl _value, $Res Function(_$RecipeModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? user_id = freezed,
    Object? title = freezed,
    Object? short_description = freezed,
    Object? cooking_time = freezed,
    Object? difficulty = freezed,
    Object? calories = freezed,
    Object? servings = freezed,
    Object? categorie_id = freezed,
    Object? created_at = freezed,
    Object? updated_at = freezed,
    Object? categorie = freezed,
    Object? ingredients = freezed,
    Object? steps = freezed,
    Object? images = freezed,
    Object? user = freezed,
    Object? like = freezed,
  }) {
    return _then(_$RecipeModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      user_id: freezed == user_id
          ? _value.user_id
          : user_id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      short_description: freezed == short_description
          ? _value.short_description
          : short_description // ignore: cast_nullable_to_non_nullable
              as String?,
      cooking_time: freezed == cooking_time
          ? _value.cooking_time
          : cooking_time // ignore: cast_nullable_to_non_nullable
              as int?,
      difficulty: freezed == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as int?,
      calories: freezed == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as int?,
      servings: freezed == servings
          ? _value.servings
          : servings // ignore: cast_nullable_to_non_nullable
              as int?,
      categorie_id: freezed == categorie_id
          ? _value.categorie_id
          : categorie_id // ignore: cast_nullable_to_non_nullable
              as int?,
      created_at: freezed == created_at
          ? _value.created_at
          : created_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updated_at: freezed == updated_at
          ? _value.updated_at
          : updated_at // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      categorie: freezed == categorie
          ? _value.categorie
          : categorie // ignore: cast_nullable_to_non_nullable
              as CategorieModel?,
      ingredients: freezed == ingredients
          ? _value._ingredients
          : ingredients // ignore: cast_nullable_to_non_nullable
              as List<IngredientModel>?,
      steps: freezed == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<PreparationStepModel>?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<RecipeImageModel>?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      like: freezed == like
          ? _value._like
          : like // ignore: cast_nullable_to_non_nullable
              as List<RecipeLikeModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecipeModelImpl implements _RecipeModel {
  _$RecipeModelImpl(
      {this.id,
      this.user_id,
      this.title,
      this.short_description,
      this.cooking_time,
      this.difficulty,
      this.calories,
      this.servings,
      this.categorie_id,
      this.created_at,
      this.updated_at,
      this.categorie,
      final List<IngredientModel>? ingredients,
      final List<PreparationStepModel>? steps,
      final List<RecipeImageModel>? images,
      this.user,
      final List<RecipeLikeModel>? like})
      : _ingredients = ingredients,
        _steps = steps,
        _images = images,
        _like = like;

  factory _$RecipeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecipeModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? user_id;
  @override
  final String? title;
  @override
  final String? short_description;
  @override
  final int? cooking_time;
  @override
  final int? difficulty;
  @override
  final int? calories;
  @override
  final int? servings;
  @override
  final int? categorie_id;
  @override
  final DateTime? created_at;
  @override
  final DateTime? updated_at;
// Nuevos campos para relaciones
  @override
  final CategorieModel? categorie;
  final List<IngredientModel>? _ingredients;
  @override
  List<IngredientModel>? get ingredients {
    final value = _ingredients;
    if (value == null) return null;
    if (_ingredients is EqualUnmodifiableListView) return _ingredients;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<PreparationStepModel>? _steps;
  @override
  List<PreparationStepModel>? get steps {
    final value = _steps;
    if (value == null) return null;
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<RecipeImageModel>? _images;
  @override
  List<RecipeImageModel>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final UserModel? user;
  final List<RecipeLikeModel>? _like;
  @override
  List<RecipeLikeModel>? get like {
    final value = _like;
    if (value == null) return null;
    if (_like is EqualUnmodifiableListView) return _like;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'RecipeModel(id: $id, user_id: $user_id, title: $title, short_description: $short_description, cooking_time: $cooking_time, difficulty: $difficulty, calories: $calories, servings: $servings, categorie_id: $categorie_id, created_at: $created_at, updated_at: $updated_at, categorie: $categorie, ingredients: $ingredients, steps: $steps, images: $images, user: $user, like: $like)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecipeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user_id, user_id) || other.user_id == user_id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.short_description, short_description) ||
                other.short_description == short_description) &&
            (identical(other.cooking_time, cooking_time) ||
                other.cooking_time == cooking_time) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.servings, servings) ||
                other.servings == servings) &&
            (identical(other.categorie_id, categorie_id) ||
                other.categorie_id == categorie_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.updated_at, updated_at) ||
                other.updated_at == updated_at) &&
            (identical(other.categorie, categorie) ||
                other.categorie == categorie) &&
            const DeepCollectionEquality()
                .equals(other._ingredients, _ingredients) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.user, user) || other.user == user) &&
            const DeepCollectionEquality().equals(other._like, _like));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      user_id,
      title,
      short_description,
      cooking_time,
      difficulty,
      calories,
      servings,
      categorie_id,
      created_at,
      updated_at,
      categorie,
      const DeepCollectionEquality().hash(_ingredients),
      const DeepCollectionEquality().hash(_steps),
      const DeepCollectionEquality().hash(_images),
      user,
      const DeepCollectionEquality().hash(_like));

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      __$$RecipeModelImplCopyWithImpl<_$RecipeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecipeModelImplToJson(
      this,
    );
  }
}

abstract class _RecipeModel implements RecipeModel {
  factory _RecipeModel(
      {final String? id,
      final String? user_id,
      final String? title,
      final String? short_description,
      final int? cooking_time,
      final int? difficulty,
      final int? calories,
      final int? servings,
      final int? categorie_id,
      final DateTime? created_at,
      final DateTime? updated_at,
      final CategorieModel? categorie,
      final List<IngredientModel>? ingredients,
      final List<PreparationStepModel>? steps,
      final List<RecipeImageModel>? images,
      final UserModel? user,
      final List<RecipeLikeModel>? like}) = _$RecipeModelImpl;

  factory _RecipeModel.fromJson(Map<String, dynamic> json) =
      _$RecipeModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get user_id;
  @override
  String? get title;
  @override
  String? get short_description;
  @override
  int? get cooking_time;
  @override
  int? get difficulty;
  @override
  int? get calories;
  @override
  int? get servings;
  @override
  int? get categorie_id;
  @override
  DateTime? get created_at;
  @override
  DateTime? get updated_at; // Nuevos campos para relaciones
  @override
  CategorieModel? get categorie;
  @override
  List<IngredientModel>? get ingredients;
  @override
  List<PreparationStepModel>? get steps;
  @override
  List<RecipeImageModel>? get images;
  @override
  UserModel? get user;
  @override
  List<RecipeLikeModel>? get like;

  /// Create a copy of RecipeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecipeModelImplCopyWith<_$RecipeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
