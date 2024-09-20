import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/services/recipe/recipe_service.dart';
import 'package:recipe_food/app/ui/pages/layout/profile/widgets/card_my_recipe.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class AllRecipeScreen extends StatefulWidget {
  const AllRecipeScreen({super.key});

  @override
  State<AllRecipeScreen> createState() => _AllRecipeScreenState();
}

class _AllRecipeScreenState extends State<AllRecipeScreen>
    with AutomaticKeepAliveClientMixin {
  final PageStorageKey<String> recipeTabKey =
      const PageStorageKey<String>('tab-all-recipe-profile');
  late RecipeListSource source;

  @override
  void initState() {
    source = RecipeListSource();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    source.dispose();
  }

  // Método para realizar el refresh completo de los datos
  Future<void> _refreshRecipes() async {
    setState(() {
      source = RecipeListSource(); // Reiniciar la fuente de datos
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ExtendedVisibilityDetector(
      uniqueKey: const PageStorageKey<String>('tab-all-recipe-profile'),
      child: RefreshIndicator(
        onRefresh: _refreshRecipes,
        child: LoadingMoreList<RecipeModel>(
          ListConfig<RecipeModel>(
            sourceList: source,
            itemBuilder: (BuildContext c, RecipeModel recipe, int index) {
              return CardMyRecipe(
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
}

class RecipeListSource extends LoadingMoreBase<RecipeModel> {
  final RecipeService recipeService = RecipeService();
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
      var box = await Hive.openBox('user');
      var user = box.get('user') as UserModel;
      final recipes =
          await recipeService.getRecipesByUser(page, pageSize, user.id!);

      // Si no hay recetas, significa que llegamos al final de la lista
      if (recipes.isEmpty) {
        _hasMore = false;
        return false;
      }

      addAll(recipes);

      page++;
      return true;
    } catch (error) {
      if (kDebugMode) debugPrint('Error al cargar recetas: $error');
      return false;
    }
  }
}

// Método para mostrar shimmer mientras se cargan los datos
Widget _buildShimmer() {
  return ListView.builder(
    itemCount: 3,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Shimmer.fromColors(
          baseColor: AppColors.silver700.withOpacity(0.3),
          highlightColor: AppColors.silver400.withOpacity(0.4),
          child: Container(
            height: 210.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      );
    },
  );
}

//you can use IndicatorWidget or build yourself widget
//in this demo, we define all status.

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
        child: AutoSizeText(
          AppLocalizations.of(context)!.textNoMoreToShow,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
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
