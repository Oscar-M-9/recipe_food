import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/infra/models/others/user_stats.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/services/profile/profile_service.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/feed_stats.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class ProfileAvatar extends ConsumerStatefulWidget {
  const ProfileAvatar({
    super.key,
    this.user,
  });

  final UserModel? user;

  @override
  ProfileAvatarState createState() => ProfileAvatarState();
}

class ProfileAvatarState extends ConsumerState<ProfileAvatar> {
  final profileService = ProfileService();
  UserStats? _userStats;
  // int followerCount = 0;
  // int followingCount = 0;
  // int recipeCount = 0;

  @override
  void initState() {
    getUserFollowers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getUserFollowers() async {
    var box = await Hive.openBox('user');
    var user = box.get('user') as UserModel;

    final userStats = await profileService.getUserStats(user.id!);
    setState(() {
      _userStats = userStats;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const maxWidth = 400.0;
    // final textTheme = Theme.of(context).textTheme;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 5),
        child: Row(
          children: [
            // Avatar del usuario
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 42,
                          backgroundImage: widget.user?.avatar_url != null
                              ? CachedNetworkImageProvider(
                                  widget.user!.avatar_url!)
                              : Assets.images.blankProfilePicture.provider(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // cuenta de las estadisdicas del usuario
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeedStats(
                          text: AppLocalizations.of(context)!.textRecipes,
                          number: _userStats?.recipesCount ?? 0,
                        ),
                        const DividerVertical(height: 25),
                        FeedStats(
                          text: AppLocalizations.of(context)!.textFollowing,
                          number: _userStats?.followingCount ?? 0,
                        ),
                        const DividerVertical(height: 25),
                        FeedStats(
                          text: AppLocalizations.of(context)!.textFollowers,
                          number: _userStats?.followersCount ?? 0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
