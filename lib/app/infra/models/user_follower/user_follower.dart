// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_follower.freezed.dart';
part 'user_follower.g.dart';

@freezed
abstract class UserFollower with _$UserFollower {
  factory UserFollower({
    String? id,
    String? user_id,
    String? follower_id,
    DateTime? followed_at,
  }) = _UserFollower;

  factory UserFollower.fromJson(Map<String, dynamic> json) =>
      _$UserFollowerFromJson(json);
}
