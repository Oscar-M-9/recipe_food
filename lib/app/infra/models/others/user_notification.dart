// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';

part 'user_notification.freezed.dart';
part 'user_notification.g.dart';

@freezed
abstract class UserNotification with _$UserNotification {
  factory UserNotification({
    UserModel? user,
    RecipeModel? recipe,
    UserModel? user_recipe,
    String? type,
  }) = _UserNotification;
  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      _$UserNotificationFromJson(json);
}
