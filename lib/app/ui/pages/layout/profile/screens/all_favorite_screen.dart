import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class AllFavoriteScreen extends StatefulWidget {
  const AllFavoriteScreen({
    super.key,
    // required this.scrollController,
    // required this.activeIndex,
  });

  // final ScrollController scrollController;
  // final int activeIndex;

  @override
  State<AllFavoriteScreen> createState() => _AllFavoriteScreenState();
}

class _AllFavoriteScreenState extends State<AllFavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  // PageStorageKey<String> favoritesTabKey =
  //     const PageStorageKey<String>('favoritesTab');
  // late final LoadMoreListSource source = LoadMoreListSource();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);

    return GlowNotificationWidget(
      showGlowLeading: false,
      ExtendedVisibilityDetector(
        uniqueKey: const PageStorageKey<String>('tab-all-favorite-profile'),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.add_rounded),
              title: Text(
                "Nueva coleccion",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              ),
              onTap: () {},
              splashColor: AppColors.visVis500.withOpacity(0.2),
              hoverColor: AppColors.visVis500.withOpacity(0.2),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: StaggeredGrid.count(
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
                children: [
                  ...List.generate(
                    20,
                    (index) {
                      final collectionPrivate = [4, 5, 8, 2, 3];
                      final isPrivate =
                          collectionPrivate.any((element) => element == index);
                      return Card(
                        elevation: 4,
                        shadowColor:
                            Theme.of(context).shadowColor.withOpacity(0.5),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black,
                                      Colors.transparent,
                                    ],
                                    stops: [0.55, 0.9],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: Assets.images.onboarding1.image(
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 5,
                                right: 10,
                                left: 10,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "Sweet $index",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              height: 1,
                                            ),
                                      ),
                                    ),
                                    if (isPrivate)
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // const SizedBox(height: 90),
                ],
              ),
            ),
          ],
        ),
        // child: LoadingMoreList<int>(
        //   ListConfig<int>(
        //     sourceList: source,
        //     itemBuilder: (BuildContext c, int item, int index) {
        //       return CardMyRecipe(
        //         ingredientsCount: index,
        //       );
        //     },
        //     indicatorBuilder: _buildIndicator,
        //   ),
        // ),
      ),
    );
    // return SafeArea(
    //   top: false,
    //   bottom: false,
    //   child: Builder(
    //     builder: (context) {
    //       return CustomScrollView(
    //         key: PageStorageKey<String>('tab-${widget.activeIndex}'),
    //         // controller: widget.scrollController,
    //         slivers: [
    //           // SliverFillRemaining(
    //           //   child: AutoTabsRouter.tabBar(),
    //           // ),
    //           SliverToBoxAdapter(
    //             child: Column(
    //               children: [
    //                 ListTile(
    //                   leading: const Icon(Icons.add_rounded),
    //                   title: Text(
    //                     "Nueva coleccion",
    //                     style: theme.textTheme.titleMedium?.copyWith(
    //                       fontWeight: FontWeight.w600,
    //                     ),
    //                   ),
    //                   trailing: const Icon(
    //                     Icons.arrow_forward_ios_rounded,
    //                     size: 20,
    //                   ),
    //                   onTap: () {},
    //                   splashColor: AppColors.visVis500.withOpacity(0.2),
    //                   hoverColor: AppColors.visVis500.withOpacity(0.2),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.all(5.0),
    //                   child: StaggeredGrid.count(
    //                     mainAxisSpacing: 5,
    //                     crossAxisSpacing: 5,
    //                     crossAxisCount: 2,
    //                     children: [
    //                       ...List.generate(
    //                         20,
    //                         (index) {
    //                           final collectionPrivate = [4, 5, 8, 2, 3];
    //                           final isPrivate = collectionPrivate
    //                               .any((element) => element == index);
    //                           return Card(
    //                             elevation: 4,
    //                             shadowColor: Theme.of(context)
    //                                 .shadowColor
    //                                 .withOpacity(0.5),
    //                             color: Colors.black,
    //                             shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.circular(10),
    //                             ),
    //                             child: ClipRRect(
    //                               borderRadius: BorderRadius.circular(10),
    //                               child: Stack(
    //                                 children: [
    //                                   ShaderMask(
    //                                     shaderCallback: (Rect bounds) {
    //                                       return const LinearGradient(
    //                                         begin: Alignment.topCenter,
    //                                         end: Alignment.bottomCenter,
    //                                         colors: [
    //                                           Colors.black,
    //                                           Colors.transparent,
    //                                         ],
    //                                         stops: [0.55, 0.9],
    //                                       ).createShader(bounds);
    //                                     },
    //                                     blendMode: BlendMode.dstIn,
    //                                     child: Assets.images.onboarding1.image(
    //                                       height: 150,
    //                                       width: double.infinity,
    //                                       fit: BoxFit.cover,
    //                                     ),
    //                                   ),
    //                                   Positioned(
    //                                     bottom: 5,
    //                                     right: 10,
    //                                     left: 10,
    //                                     child: Row(
    //                                       children: [
    //                                         Expanded(
    //                                           child: Text(
    //                                             "Sweet heloo heloo helooe helo",
    //                                             overflow: TextOverflow.ellipsis,
    //                                             maxLines: 2,
    //                                             style: Theme.of(context)
    //                                                 .textTheme
    //                                                 .titleMedium
    //                                                 ?.copyWith(
    //                                                   color: Colors.white,
    //                                                   fontWeight:
    //                                                       FontWeight.bold,
    //                                                   height: 1,
    //                                                 ),
    //                                           ),
    //                                         ),
    //                                         if (isPrivate)
    //                                           Icon(
    //                                             Icons.lock_outline_rounded,
    //                                             color: Colors.white,
    //                                             size: 20,
    //                                           )
    //                                       ],
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                       const SizedBox(height: 90),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           // SliverPadding(
    //           //   padding: EdgeInsets.all(8.0),
    //           //   sliver: SliverGrid(
    //           //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //           //       crossAxisCount: 2,
    //           //       childAspectRatio: 0.75,
    //           //       crossAxisSpacing: 8.0,
    //           //       mainAxisSpacing: 8.0,
    //           //     ),
    //           //     delegate: SliverChildBuilderDelegate(
    //           //       (context, index) => _buildFavoriteCard(index),
    //           //       childCount: 20,
    //           //     ),
    //           //   ),
    //           // ),
    //         ],
    //       );
    //     },
    //   ),
    // );
  }

  // // Construye una tarjeta de favorito
  // Widget _buildFavoriteCard(int index) {
  //   return Card(
  //     elevation: 4,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Expanded(
  //           child: Image.asset(
  //             Assets.images.onboarding2.path,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text(
  //             'Favorite ${index + 1}',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  bool get wantKeepAlive => true;
}

// class LoadMoreListSource extends LoadingMoreBase<int> {
//   @override
//   Future<bool> loadData([bool isloadMoreAction = false]) {
//     return Future<bool>.delayed(const Duration(seconds: 1), () {
//       for (int i = 0; i < 10; i++) {
//         add(0);
//       }

//       return true;
//     });
//   }
// }

// //you can use IndicatorWidget or build yourself widget
// //in this demo, we define all status.
// Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
//   //if your list is sliver list ,you should build sliver indicator for it
//   //isSliver=true, when use it in sliver list
//   bool isSliver = false;

//   Widget widget;
//   switch (status) {
//     case IndicatorStatus.none:
//       widget = Container(
//         height: 0.0,
//         margin: EdgeInsets.only(
//           bottom: MediaQuery.of(context).padding.bottom,
//         ),
//       );
//       break;
//     case IndicatorStatus.loadingMoreBusying:
//       widget = Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).padding.bottom + 25.0,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.only(right: 15.0),
//               height: 15.0,
//               width: 15.0,
//               child: getIndicator(context),
//             ),
//             AutoSizeText(
//               "Cargando...\n No te preocupes",
//               style: Theme.of(context).textTheme.bodySmall,
//               textAlign: TextAlign.center,
//             )
//           ],
//         ),
//       );
//       // widget = _setbackground(false, widget, 35.0);
//       break;
//     case IndicatorStatus.fullScreenBusying:
//       widget = Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(
//             height: 30.0,
//             width: 30.0,
//             child: getIndicator(context),
//           ),
//           const SizedBox(height: 10),
//           AutoSizeText(
//             "Cargando publicaciones ...\n No te preocupes",
//             style: Theme.of(context).textTheme.bodyMedium,
//             textAlign: TextAlign.center,
//           )
//         ],
//       );
//       // widget = _setbackground(true, widget, double.infinity);
//       // ignore: dead_code
//       if (isSliver) {
//         widget = SliverFillRemaining(
//           child: widget,
//         );
//       } else {
//         widget = CustomScrollView(
//           slivers: <Widget>[
//             SliverFillRemaining(
//               child: widget,
//             )
//           ],
//         );
//       }
//       break;
//     case IndicatorStatus.error:
//       widget = Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).padding.bottom,
//         ),
//         child: AutoSizeText(
//           "¿Parece haber un problema?",
//           style: Theme.of(context).textTheme.bodySmall,
//         ),
//       );
//       // widget = _setbackground(false, widget, 35.0);

//       // widget = GestureDetector(
//       //   onTap: () {
//       //     listSourceRepository.errorRefresh();
//       //   },
//       //   child: widget,
//       // );

//       break;
//     case IndicatorStatus.fullScreenError:
//       widget = AutoSizeText(
//         "¿Parece haber un problema?",
//         style: Theme.of(context).textTheme.bodyMedium,
//       );
//       // widget = _setbackground(true, widget, double.infinity);
//       // widget = GestureDetector(
//       //   onTap: () {
//       //     listSourceRepository.errorRefresh();
//       //   },
//       //   child: widget,
//       // );
//       // ignore: dead_code
//       if (isSliver) {
//         widget = SliverFillRemaining(
//           child: widget,
//         );
//       } else {
//         widget = CustomScrollView(
//           slivers: <Widget>[
//             SliverFillRemaining(
//               child: widget,
//             )
//           ],
//         );
//       }
//       break;
//     case IndicatorStatus.noMoreLoad:
//       widget = Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).padding.bottom,
//         ),
//         child: AutoSizeText(
//           "No hay más... no te demores",
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
//       );
//       // widget = _setbackground(false, widget, 35.0);
//       break;
//     case IndicatorStatus.empty:
//       widget = const EmptyWidget(
//         "¡Aquí está vacio!",
//       );
//       // widget = _setbackground(true, widget, double.infinity);
//       // ignore: dead_code
//       if (isSliver) {
//         widget = SliverToBoxAdapter(
//           child: widget,
//         );
//       } else {
//         widget = CustomScrollView(
//           slivers: <Widget>[
//             SliverFillRemaining(
//               child: widget,
//             )
//           ],
//         );
//       }
//       break;
//   }
//   return widget;
// }

// getIndicator(BuildContext context) {
//   return const CircularProgressIndicator();
// }
