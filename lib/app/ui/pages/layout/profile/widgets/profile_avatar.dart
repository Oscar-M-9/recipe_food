import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/feed_stats.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
  });

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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.visVis500,
                            AppColors.visVis300,
                            AppColors.jade300,
                            AppColors.jade600,
                            // Colors.purple,
                            // Colors.blue,
                            // Colors.green,
                            // Colors.yellow,
                            // Colors.orange,
                            // Colors.red,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: theme.scaffoldBackgroundColor,
                            shape: BoxShape.circle),
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: Assets.images.onboarding1.provider(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 13,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.jade500,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.scaffoldBackgroundColor,
                            width: 3,
                          ),
                        ),
                        child: const Icon(
                          Icons.add_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FeedStats(
                          text: "Recipes",
                          number: 580,
                        ),
                        DividerVertical(
                          height: 25,
                        ),
                        FeedStats(
                          text: "Following",
                          number: 8900,
                        ),
                        DividerVertical(
                          height: 25,
                        ),
                        FeedStats(
                          text: "Followers",
                          number: 109000,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Expanded(
            //   flex: 2,
            //   child: Container(
            //     color: Colors.pink.withOpacity(0.44),
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             'Carol Gilliam',
            //             style: theme.textTheme.titleLarge?.copyWith(
            //               fontWeight: FontWeight.w800,
            //               height: 1.2,
            //             ),
            //             // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            //           ),
            //           Text(
            //             '@carol_gilliam',
            //             // style: TextStyle(color: Colors.grey[600], fontSize: 16),
            //             style: theme.textTheme.titleMedium?.copyWith(
            //               color: AppColors.silver700,
            //               fontWeight: FontWeight.w600,
            //               height: 1.2,
            //             ),
            //           ),
            //           const SizedBox(height: 10),
            //           Text(
            //             'Active and happy mom of three sons. The best recipes for you and your family every day 🥑🌮',
            //             textAlign: TextAlign.center,
            //             style: textTheme.bodyMedium?.copyWith(
            //               color: AppColors.silver800,
            //             ),
            //             // style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
