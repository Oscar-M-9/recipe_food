import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // const Color newMessageColor = AppColors.visVis400;

    return Scaffold(
      body: LoadingMoreCustomScrollView(
        slivers: [
          SliverAppBar.medium(
            flexibleSpace: FlexibleSpaceBar(
              title: Text(AppLocalizations.of(context)!.labelNotifications),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            sliver: SliverList.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsetsDirectional.symmetric(
                    horizontal: 15,
                  ).copyWith(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.silver950.withOpacity(0.035),
                  ),
                  child: Row(
                    children: [
                      Assets.svgs.notification2.svg(),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Recipe!",
                              style: textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Far far away, behind the word mountains, far from the countries",
                              style: textTheme.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
