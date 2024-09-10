import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  AutoSizeGroup autoSizeGroup = AutoSizeGroup();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabs = <String>[
      AppLocalizations.of(context)!.textRecipesForYou,
      AppLocalizations.of(context)!.textFollowingChefs,
      // Puedes agregar más tabs aquí si es necesario
    ];
    final tabNotify = <bool>[
      false,
      true,
      // Puedes agregar más tabs aquí si es necesario
    ];
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double pinnedHeaderHeight =
        //statusBar height
        statusBarHeight +
            //pinned SliverAppBar height in header
            kToolbarHeight;

    return AutoTabsRouter.pageView(
      animatePageTransition: true,
      curve: Curves.bounceInOut,
      routes: const [
        RecipesForYouRoute(),
        FollowingChefsRoute(),
        // AllRecipeRoute(activeIndex: 0),
        // AllFavoriteRoute(activeIndex: 1),
      ],
      builder: (context, child, pageController) {
        final tabsRouter = AutoTabsRouter.of(context);
        // Calcula la posición izquierda del indicador
        double indicatorSize = 15;
        double tabWidth =
            115.00; // MediaQuery.of(context).size.width / tabs.length;
        double indicatorLeft =
            tabWidth * tabsRouter.activeIndex + (tabWidth - indicatorSize) / 2;
        return Scaffold(
          body: ExtendedNestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 4,
                  shadowColor: Theme.of(context).shadowColor.withOpacity(0.6),
                  title: Container(
                    // margin: EdgeInsets.only(top: statusBarHeight),
                    // decoration: BoxDecoration(
                    //   boxShadow: [
                    //     BoxShadow(
                    //       color: Theme.of(context).shadowColor.withOpacity(0.6),
                    //       blurRadius: 3.0,
                    //       offset: const Offset(0.0, 5.0),
                    //     ),
                    //   ],
                    // ),
                    alignment: AlignmentDirectional.center,
                    height: 43,
                    child: Stack(
                      children: [
                        // tab text
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          // decoration: BoxDecoration(
                          //   color: Theme.of(context).cardColor.withOpacity(0.9),
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: _buildTabItems(
                              activeIndex: tabsRouter.activeIndex,
                              tabs: tabs,
                              width: tabWidth,
                              tabNotify: tabNotify,
                              // onTap: tabsRouter.setActiveIndex,
                              onTap: (index) {
                                print(index);
                                tabsRouter.setActiveIndex(index);
                              },
                            ),
                          ),
                        ),
                        // Indicator
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          left: indicatorLeft,
                          bottom: 2,
                          child: Container(
                            width: indicatorSize,
                            height: 4,
                            decoration: BoxDecoration(
                              color: AppColors.visVis500,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            pinnedHeaderSliverHeightBuilder: () {
              return pinnedHeaderHeight;
            },
            onlyOneScrollInBody: true,
            body: child,
            // body: CustomScrollView(
            //   slivers: [
            //     SliverFillRemaining(
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(20),
            //         child: child,
            //       ),
            //     ),
            //   ],
            // ),
            // body: Column(
            //   children: [
            //     // Container(
            //     //   margin: EdgeInsets.only(top: statusBarHeight),
            //     //   decoration: BoxDecoration(
            //     //     boxShadow: [
            //     //       BoxShadow(
            //     //         color: Theme.of(context).shadowColor.withOpacity(0.6),
            //     //         blurRadius: 3.0,
            //     //         offset: const Offset(0.0, 5.0),
            //     //       ),
            //     //     ],
            //     //   ),
            //     //   alignment: AlignmentDirectional.center,
            //     //   height: 43,
            //     //   child: Stack(
            //     //     children: [
            //     //       // tab text
            //     //       Container(
            //     //         padding: const EdgeInsets.symmetric(horizontal: 5),
            //     //         // decoration: BoxDecoration(
            //     //         //   color: Theme.of(context).cardColor.withOpacity(0.9),
            //     //         //   borderRadius: BorderRadius.circular(15),
            //     //         // ),
            //     //         child: Row(
            //     //           mainAxisSize: MainAxisSize.min,
            //     //           mainAxisAlignment: MainAxisAlignment.center,
            //     //           crossAxisAlignment: CrossAxisAlignment.center,
            //     //           children: _buildTabItems(
            //     //             activeIndex: tabsRouter.activeIndex,
            //     //             tabs: tabs,
            //     //             width: tabWidth,
            //     //             tabNotify: tabNotify,
            //     //             // onTap: tabsRouter.setActiveIndex,
            //     //             onTap: (index) {
            //     //               print(index);
            //     //               tabsRouter.setActiveIndex(index);
            //     //             },
            //     //           ),
            //     //         ),
            //     //       ),
            //     //       // Indicator
            //     //       AnimatedPositioned(
            //     //         duration: const Duration(milliseconds: 300),
            //     //         curve: Curves.easeInOut,
            //     //         left: indicatorLeft,
            //     //         bottom: 2,
            //     //         child: Container(
            //     //           width: indicatorSize,
            //     //           height: 4,
            //     //           decoration: BoxDecoration(
            //     //             color: AppColors.visVis500,
            //     //             borderRadius: BorderRadius.circular(10),
            //     //           ),
            //     //         ),
            //     //       ),
            //     //     ],
            //     //   ),
            //     // ),
            //     Expanded(
            //       child: ClipRRect(
            //         borderRadius: BorderRadius.circular(20),
            //         child: child,
            //       ),
            //     ),
            //   ],
            // ),
          ),
        );

        // return SafeArea(
        //   bottom: false,
        //   child: Stack(
        //     children: [
        //       Column(
        //         children: [
        //           // TabBar View (Pages)
        //           Expanded(
        //             child: Padding(
        //               padding: const EdgeInsets.symmetric(horizontal: 5),
        //               child: child,
        //               // child: PageView(
        //               //   controller: _pageController,
        //               //   onPageChanged: (index) {
        //               //     setState(() {
        //               //       _currentIndex = index;
        //               //     });
        //               //   },
        //               //   children: pages,
        //               // ),
        //             ),
        //           ),
        //         ],
        //       ),
        //       Stack(
        //         children: [
        //           Container(
        //             width: double.infinity,
        //             padding: const EdgeInsets.only(bottom: 2),
        //             decoration: BoxDecoration(
        //               color: Theme.of(context)
        //                   .scaffoldBackgroundColor
        //                   .withOpacity(0.8),
        //               boxShadow: [
        //                 BoxShadow(
        //                   color: Theme.of(context).shadowColor.withOpacity(0.6),
        //                   blurRadius: 3.0,
        //                   offset: const Offset(0.0, 1.0),
        //                 ),
        //               ],
        //             ),
        //             alignment: AlignmentDirectional.center,
        //             height: 43,
        //             child: Stack(
        //               children: [
        //                 // tab text
        //                 Container(
        //                   padding: const EdgeInsets.symmetric(horizontal: 5),
        //                   // decoration: BoxDecoration(
        //                   //   color: Theme.of(context).cardColor.withOpacity(0.9),
        //                   //   borderRadius: BorderRadius.circular(15),
        //                   // ),
        //                   child: Row(
        //                     mainAxisSize: MainAxisSize.min,
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     crossAxisAlignment: CrossAxisAlignment.center,
        //                     children: _buildTabItems(
        //                       activeIndex: tabsRouter.activeIndex,
        //                       tabs: tabs,
        //                       width: tabWidth,
        //                       tabNotify: tabNotify,
        //                       // onTap: tabsRouter.setActiveIndex,
        //                       onTap: (index) {
        //                         print(index);
        //                         tabsRouter.setActiveIndex(index);
        //                         pageController.animateToPage(
        //                           index,
        //                           duration: const Duration(
        //                               milliseconds:
        //                                   500), // Cambia la duración aquí
        //                           curve: Curves
        //                               .elasticInOut, // Cambia la curva aquí
        //                         );
        //                       },
        //                     ),
        //                   ),
        //                 ),
        //                 // Indicator
        //                 AnimatedPositioned(
        //                   duration: const Duration(milliseconds: 300),
        //                   curve: Curves.easeInOut,
        //                   left: indicatorLeft,
        //                   bottom: 0,
        //                   child: Container(
        //                     width: indicatorSize,
        //                     height: 4,
        //                     decoration: BoxDecoration(
        //                       color: AppColors.visVis500,
        //                       borderRadius: BorderRadius.circular(10),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           // Positioned(
        //           //   right: 2,
        //           //   top: 0,
        //           //   child: IconButton(
        //           //     onPressed: () {},
        //           //     icon: Assets.svgs.iconSearch.svg(
        //           //       // ignore: deprecated_member_use_from_same_package
        //           //       color: Theme.of(context).iconTheme.color,
        //           //     ),
        //           //   ),
        //           // ),
        //         ],
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  List<Widget> _buildTabItems({
    required List<String> tabs,
    required double width,
    required int activeIndex,
    required List<bool> tabNotify,
    required Function(int) onTap,
  }) {
    final items = <Widget>[];

    for (var i = 0; i < tabs.length; i++) {
      final isActive = i == activeIndex;

      items.add(
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () => onTap(i),
          child: Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: width,
                child: Center(
                  child: AutoSizeText(
                    tabs[i],
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight:
                              isActive ? FontWeight.w800 : FontWeight.w500,
                          color: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .color
                              ?.withOpacity(isActive ? 1.0 : 0.8),
                        ),
                  ),
                ),
              ),
              if (tabNotify[i])
                Positioned(
                  top: 9,
                  right: 1,
                  child: Container(
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppColors.jade400,
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    }
    return items;
  }
}
