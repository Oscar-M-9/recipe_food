
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_stats.freezed.dart';
part 'user_stats.g.dart';

@freezed
abstract class UserStats with _$UserStats {
   factory UserStats({
    @Default(0) int? followersCount,
    @Default(0) int? followingCount,
    @Default(0) int? recipesCount,
   }) = _UserStats;
   factory UserStats.fromJson(Map<String, dynamic> json) => _$UserStatsFromJson(json);
}