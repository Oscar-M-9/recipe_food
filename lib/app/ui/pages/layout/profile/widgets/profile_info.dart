import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/profile_button.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const maxWidth = 300.0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 5),
          // Text(
          //   'Carol Gilliam',
          //   style: textTheme.titleLarge?.copyWith(
          //     fontWeight: FontWeight.w800,
          //     height: 1.2,
          //   ),
          //   // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          // ),
          // Text(
          //   '@carol_gilliam',
          //   // style: TextStyle(color: Colors.grey[600], fontSize: 16),
          //   style: textTheme.titleMedium?.copyWith(
          //     color: AppColors.silver700,
          //     fontWeight: FontWeight.w600,
          //     // height: 1.2,
          //   ),
          // ),
          Row(
            children: [
              Text(
                'Carol Gilliam ',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
          Text(
            'Active and happy mom of three sons. The best recipes for you and your family every day 🥑🌮',
            // textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.silver800,
            ),
            // style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          // ConstrainedBox(
          //   constraints: const BoxConstraints(
          //     maxWidth: maxWidth,
          //   ),
          //   child: const Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       FeedStats(
          //         text: "Recipes",
          //         number: 580,
          //       ),
          //       DividerVertical(
          //         height: 25,
          //       ),
          //       FeedStats(
          //         text: "Following",
          //         number: 8900,
          //       ),
          //       DividerVertical(
          //         height: 25,
          //       ),
          //       FeedStats(
          //         text: "Followers",
          //         number: 109000,
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxWidth),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: ProfileButton(
                      onPressed: () {},
                      text: 'Edit profile',
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: ProfileButton(
                      onPressed: () {},
                      text: 'Share profile',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
