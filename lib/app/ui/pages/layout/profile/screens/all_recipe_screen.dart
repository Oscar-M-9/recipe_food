import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/card_my_recipe.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({
    super.key,
    // required this.scrollController,
    // required this.activeIndex,
  });

  // final ScrollController scrollController;
  // final int activeIndex;

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen> {
  // final PageStorageKey<String> recipeTabKey =
  //     const PageStorageKey<String>('recipeTab');
  late final LoadMoreListSource source = LoadMoreListSource();

  @override
  Widget build(BuildContext context) {
    return ExtendedVisibilityDetector(
      uniqueKey: const PageStorageKey<String>('tab-all-recipe-profile'),
      child: LoadingMoreList<int>(
        ListConfig<int>(
          sourceList: source,
          itemBuilder: (BuildContext c, int item, int index) {
            return CardMyRecipe(
              ingredientsCount: index,
            );
          },
          indicatorBuilder: _buildIndicator,
        ),
      ),
    );
  }
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
  bool isSliver = false;

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
      // ignore: dead_code
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
      // ignore: dead_code
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
          bottom: MediaQuery.of(context).padding.bottom,
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
      // ignore: dead_code
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
