import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/pages/profile_setting_page.dart';
import 'package:recipe_food/gen/assets.gen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/presenter/providers/app/profile_tabs_provider.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/profile_avatar.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/profile_info.dart';

@RoutePage()
class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfilePage> {
  final PageStorageBucket _bucket = PageStorageBucket();
  final ScrollController _nestedScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _nestedScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AutoTabsRouter.tabBar(
      routes: const [
        AllRecipeRoute(),
        AllFavoriteRoute(),
      ],
      builder: (context, child, tabController) {
        final tabsRouter = context.tabsRouter;
        tabController.addListener(
          () {
            ref.read(indexTabs.notifier).state = tabsRouter.activeIndex;
          },
        );
        // print('Active Index2: ${tabsRouter.activeIndex}');

        final double statusBarHeight = MediaQuery.of(context).padding.top;
        final double pinnedHeaderHeight =
            //statusBar height
            statusBarHeight +
                //pinned SliverAppBar height in header
                kToolbarHeight;

        return Scaffold(
          body: ExtendedNestedScrollView(
            controller: _nestedScrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  title: Text(
                    '@carol_gilliam',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.silver900,
                      fontWeight: FontWeight.w600,
                      // height: 1.2,
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Stack(
                    //     children: [
                    //       Assets.svgs.notification.svg(
                    //         color: theme.iconTheme.color,
                    //         height: 22,
                    //         width: 22,
                    //       ),
                    //       Positioned(
                    //         top: 4,
                    //         right: 2.5,
                    //         child: Container(
                    //           width: 6,
                    //           height: 6,
                    //           decoration: const BoxDecoration(
                    //             color: AppColors.jade400,
                    //             shape: BoxShape.circle,
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileSettingPage(),
                          ),
                        );
                      },
                      icon: Assets.svgs.menu.svg(
                        color: theme.iconTheme.color,
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ],
                ),
                const SliverToBoxAdapter(child: ProfileAvatar()),
                const SliverToBoxAdapter(child: ProfileInfo()),
                // PinnedHeaderSliver(
                //   child: Container(
                //     margin:
                //         const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //     decoration: BoxDecoration(
                //       color: theme.cardColor.withOpacity(0.95),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //     child: TabBar(
                //       controller: tabController,
                //       dividerColor: Colors.transparent,
                //       indicatorSize: TabBarIndicatorSize.label,
                //       // indicatorColor: AppColors.visVis500,
                //       indicatorPadding: const EdgeInsetsDirectional.only(
                //         top: 38.5,
                //         bottom: 5,
                //         start: 35,
                //         end: 35,
                //       ),
                //       indicator: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         gradient: const LinearGradient(
                //           colors: [
                //             AppColors.visVis500,
                //             AppColors.visVis400,
                //             AppColors.visVis300,
                //             AppColors.jade300,
                //             AppColors.jade400,
                //             AppColors.jade500,
                //           ],
                //         ),
                //       ),
                //       tabs: [
                //         Tab(
                //           // text: 'Recipes',
                //           // icon: Assets.svgs.menu2.svg(
                //           //   height: 20,
                //           // ),
                //           child: _buildTabItem(
                //             text: "Recipes",
                //             icon: Assets.svgs.menu2,
                //           ),
                //         ),
                //         Tab(
                //           // text: 'Favorites',
                //           child: _buildTabItem(
                //             text: "Favorites",
                //             icon: Assets.svgs.iconFavorite,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // )
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return pinnedHeaderHeight;
            },
            onlyOneScrollInBody: true,
            body: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    controller: tabController,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.label,
                    // indicatorColor: AppColors.visVis500,
                    indicatorPadding: const EdgeInsetsDirectional.only(
                      top: 38.5,
                      bottom: 5,
                      start: 35,
                      end: 35,
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          AppColors.visVis500,
                          AppColors.visVis400,
                          AppColors.visVis300,
                          AppColors.jade300,
                          AppColors.jade400,
                          AppColors.jade500,
                        ],
                      ),
                    ),
                    tabs: [
                      Tab(
                        // text: 'Recipes',
                        // icon: Assets.svgs.menu2.svg(
                        //   height: 20,
                        // ),
                        child: _buildTabItem(
                          text: "Recipes",
                          icon: Assets.svgs.menu2,
                        ),
                      ),
                      Tab(
                        // text: 'Favorites',
                        child: _buildTabItem(
                          text: "Colecciones",
                          icon: Assets.svgs.bookmark,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageStorage(
                    bucket: _bucket,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(28),
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabItem({
    required String text,
    required SvgGenImage icon,
  }) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon.svg(
                    height: 15,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    child: AutoSizeText(
                      text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
