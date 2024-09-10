// ignore_for_file: dead_code

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:recipe_food/app/ui/shared/widgets/publication_recipe.dart';

@RoutePage()
class FollowingChefsScreen extends StatefulWidget {
  const FollowingChefsScreen({super.key});

  @override
  State<FollowingChefsScreen> createState() => _FollowingChefsScreenState();
}

class _FollowingChefsScreenState extends State<FollowingChefsScreen>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource source = LoadMoreListSource();

  @override
  void dispose() {
    source.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingMoreCustomScrollView(
      showGlowLeading: false,
      cacheExtent: 1000,
      physics: const ClampingScrollPhysics(),
      slivers: [
        LoadingMoreSliverList<int>(
          SliverListConfig<int>(
            itemBuilder: (context, item, index) {
              return PublicationRecipe(
                keyImageHero: "image_following_chefs_$index",
              );
            },
            indicatorBuilder: _buildIndicator,
            sourceList: source,
          ),
        ),
      ],
    );
    // return Builder(
    //   builder: (context) {
    //     // Aquí se devuelve la página activa, con su propio ScrollController
    //     return ScrollConfiguration(
    //       behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
    //       child: CustomScrollView(
    //         key: const PageStorageKey<String>('tab-following-chefs'),
    //         slivers: [
    //           SliverPadding(
    //             padding: const EdgeInsets.all(2.0),
    //             sliver: SliverList(
    //               delegate: SliverChildBuilderDelegate(
    //                 (context, index) => const CardRecipe(),
    //                 childCount: 20,
    //               ),
    //             ),
    //           ),
    //           const SliverToBoxAdapter(
    //             child: SizedBox(height: 90),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  @override
  bool get wantKeepAlive => true;
}

class LoadMoreListSource extends LoadingMoreBase<int> {
  @override
  Future<bool> loadData([bool isloadMoreAction = false]) {
    return Future<bool>.delayed(const Duration(seconds: 1), () {
      for (int i = 0; i < 10; i++) {
        add(0);
      }

      return true;
    });
  }
}

//you can use IndicatorWidget or build yourself widget
//in this demo, we define all status.
Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
  //if your list is sliver list ,you should build sliver indicator for it
  //isSliver=true, when use it in sliver list
  bool isSliver = true;

  Widget widget;
  switch (status) {
    case IndicatorStatus.none:
      widget = Container(
        height: 0.0,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
      );
      break;
    case IndicatorStatus.loadingMoreBusying:
      widget = Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 25.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 15.0),
              height: 15.0,
              width: 15.0,
              child: getIndicator(context),
            ),
            AutoSizeText(
              "Cargando...\n No te preocupes",
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
      // widget = _setbackground(false, widget, 35.0);
      break;
    case IndicatorStatus.fullScreenBusying:
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30.0,
            width: 30.0,
            child: getIndicator(context),
          ),
          const SizedBox(height: 10),
          AutoSizeText(
            "Cargando publicaciones ...\n No te preocupes",
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          )
        ],
      );
      // widget = _setbackground(true, widget, double.infinity);
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: widget,
            )
          ],
        );
      }
      break;
    case IndicatorStatus.error:
      widget = Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom,
        ),
        child: AutoSizeText(
          "¿Parece haber un problema?",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      );
      // widget = _setbackground(false, widget, 35.0);

      // widget = GestureDetector(
      //   onTap: () {
      //     listSourceRepository.errorRefresh();
      //   },
      //   child: widget,
      // );

      break;
    case IndicatorStatus.fullScreenError:
      widget = AutoSizeText(
        "¿Parece haber un problema?",
        style: Theme.of(context).textTheme.bodyMedium,
      );
      // widget = _setbackground(true, widget, double.infinity);
      // widget = GestureDetector(
      //   onTap: () {
      //     listSourceRepository.errorRefresh();
      //   },
      //   child: widget,
      // );
      if (isSliver) {
        widget = SliverFillRemaining(
          child: widget,
        );
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: widget,
            )
          ],
        );
      }
      break;
    case IndicatorStatus.noMoreLoad:
      widget = Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 25,
        ),
        child: AutoSizeText(
          "No hay más... no te demores",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
      // widget = _setbackground(false, widget, 35.0);
      break;
    case IndicatorStatus.empty:
      widget = const EmptyWidget(
        "¡Aquí está vacio!",
      );
      // widget = _setbackground(true, widget, double.infinity);
      if (isSliver) {
        widget = SliverToBoxAdapter(
          child: widget,
        );
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(
              child: widget,
            )
          ],
        );
      }
      break;
  }
  return widget;
}

getIndicator(BuildContext context) {
  return const CircularProgressIndicator();
}
