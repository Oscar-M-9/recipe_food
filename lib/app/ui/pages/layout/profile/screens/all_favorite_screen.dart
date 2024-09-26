import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/presenter/services/saved_recipe/saved_recipe_service.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/card_my_favorite.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class AllFavoriteScreen extends StatefulWidget {
  const AllFavoriteScreen({
    super.key,
  });

  @override
  State<AllFavoriteScreen> createState() => _AllFavoriteScreenState();
}

class _AllFavoriteScreenState extends State<AllFavoriteScreen>
    with AutomaticKeepAliveClientMixin {
  late CollectionListSource source;
  final savedRecipeService = SavedRecipeService();

  @override
  void initState() {
    source = CollectionListSource();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    source.dispose();
  }

  Future<void> _refreshCollections() async {
    setState(() {
      source = CollectionListSource();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ExtendedVisibilityDetector(
      uniqueKey: const PageStorageKey<String>('tab-all-favorite-profile'),
      child: RefreshIndicator(
        onRefresh: _refreshCollections,
        child: LoadingMoreList<RecipeModel>(
          ListConfig<RecipeModel>(
            sourceList: source,
            extendedListDelegate:
                const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext ctx, RecipeModel recipe, int index) {
              return CardMyFavorite(
                index: index,
                recipe: recipe,
              );
            },
            indicatorBuilder: _buildIndicator,
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CollectionListSource extends LoadingMoreBase<RecipeModel> {
  final SavedRecipeService savedRecipeService = SavedRecipeService();
  int page = 0;
  final int pageSize = 5;
  bool _hasMore = true;

  @override
  bool get hasMore => _hasMore;

  @override
  // ignore: avoid_renaming_method_parameters
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    if (!hasMore) return false;

    try {
      final recipes = await savedRecipeService.gerSavedRecipes(page, pageSize);

      if (recipes.isEmpty) {
        _hasMore = false;
        return false;
      }

      addAll(recipes);

      page++;
      return true;
    } catch (e) {
      debugPrint("Error al cargar las colecciones $e");
      return false;
    }
  }
}

// Método para mostrar shimmer mientras se cargan los datos
Widget _buildShimmer() {
  return StaggeredGrid.count(
    mainAxisSpacing: 5,
    crossAxisSpacing: 5,
    crossAxisCount: 2,
    children: List.generate(
      6,
      (index) {
        return Shimmer.fromColors(
          baseColor: AppColors.silver700.withOpacity(0.3),
          highlightColor: AppColors.silver400.withOpacity(0.4),
          child: Container(
            height: 200.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        );
      },
    ),
  );
}

Widget _buildIndicator(BuildContext context, IndicatorStatus status) {
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
              height: 25.0,
              width: 25.0,
              child: getPlaceholder(),
            ),
            // AutoSizeText(
            //   "Cargando...\n No te preocupes",
            //   style: Theme.of(context).textTheme.bodySmall,
            //   textAlign: TextAlign.center,
            // )
          ],
        ),
      );
      break;

    case IndicatorStatus.fullScreenBusying:
      widget = _buildShimmer();
      // Si es Sliver o no, lo envolvemos en un SliverFillRemaining
      widget = SliverFillRemaining(child: widget);

      // Si no es un Sliver, lo envolvemos en un CustomScrollView
      // ignore: dead_code
      if (!isSliver) {
        widget = CustomScrollView(
          slivers: [widget],
        );
      }
      break;

    case IndicatorStatus.error:
      widget = Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 25,
          top: 10,
        ),
        // child: AutoSizeText(
        //   AppLocalizations.of(context)!.textNoMoreToShow,
        //   style: Theme.of(context).textTheme.bodySmall,
        //   textAlign: TextAlign.center,
        // ),
      );
      break;

    case IndicatorStatus.fullScreenError:
      widget = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.radicalRed400,
          ),
          const SizedBox(height: 15),
          AutoSizeText(
            AppLocalizations.of(context)!.textNoData,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      );
      // Si es Sliver o no, lo envolvemos en un SliverFillRemaining
      widget = SliverFillRemaining(child: widget);

      // Si no es un Sliver, lo envolvemos en un CustomScrollView
      // ignore: dead_code
      if (!isSliver) {
        widget = CustomScrollView(
          slivers: [widget],
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
      break;

    case IndicatorStatus.empty:
      widget = EmptyWidget(AppLocalizations.of(context)!.textEmptyHere);
      // ignore: dead_code
      if (isSliver) {
        widget = SliverToBoxAdapter(child: widget);
        // ignore: dead_code
      } else {
        widget = CustomScrollView(
          slivers: <Widget>[
            SliverFillRemaining(child: widget),
          ],
        );
      }
      break;
  }
  return widget;
}

Widget getPlaceholder() {
  return const CircularProgressIndicator();
}
