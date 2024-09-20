// ignore_for_file: dead_code

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shimmer/shimmer.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:recipe_food/gen/assets.gen.dart';

import 'package:recipe_food/app/ui/shared/widgets/publication_recipe.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/services/recipe/recipe_service.dart';

@RoutePage()
class RecipesForYouScreen extends StatefulWidget {
  const RecipesForYouScreen({super.key});

  @override
  State<RecipesForYouScreen> createState() => _RecipesForYouScreenState();
}

class _RecipesForYouScreenState extends State<RecipesForYouScreen>
    with AutomaticKeepAliveClientMixin {
  late final Timer _timer;
  late final CarouselController _carouselController;
  final _itemExtent = 330.0;
  final _autoPlayDuration = const Duration(seconds: 4);
  late RecipeListSource source;
  late UserModel? _user;

  @override
  void initState() {
    _carouselController = CarouselController();

    // Animates to the next item every 4 seconds
    // Usar un post frame callback para asegurarse de que el árbol de widgets esté construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(
        _autoPlayDuration,
        (_) => _animateToNextItem(),
      );
    });
    source = RecipeListSource();
    initBox();
    super.initState();
  }

  void initBox() async {
    var box = await Hive.openBox('user');
    final user = box.get('user') as UserModel;
    setState(() {
      _user = user;
    });
  }

  @override
  void dispose() {
    source.dispose();
    _timer.cancel();
    _carouselController.dispose();
    super.dispose();
  }

  void _animateToNextItem() {
    if (_carouselController.hasClients) {
      final maxOffset = _carouselController.position.maxScrollExtent;
      final currentOffset = _carouselController.offset;

      if (currentOffset >= maxOffset) {
        // Si llegaste al final, vuelve al inicio
        _carouselController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      } else {
        // Avanza al siguiente elemento
        _carouselController.animateTo(
          currentOffset + _itemExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      }
    }
  }

  Future<void> _refreshRecipes() async {
    setState(() {
      source = RecipeListSource(); // Reiniciar la fuente de datos
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: _refreshRecipes,
      child: LoadingMoreCustomScrollView(
        showGlowLeading: false,
        cacheExtent: 1000,
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: CarouselView(
                itemExtent: _itemExtent,
                shrinkExtent: 200,
                padding: const EdgeInsets.all(8.0),
                itemSnapping: true,
                controller: _carouselController,
                children: [
                  Assets.images.onboarding1.image(fit: BoxFit.cover),
                  Assets.images.onboarding2.image(fit: BoxFit.cover),
                  Assets.images.onboarding3.image(fit: BoxFit.cover),
                  Assets.images.onboarding4.image(fit: BoxFit.cover),
                ],
              ),
            ),
          ),
          // * list chefs
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 10)
          //         .copyWith(bottom: 3, top: 12),
          //     child: Align(
          //       alignment: Alignment.centerLeft,
          //       child: Text(
          //         "The Chefs you might like",
          //         style: theme.textTheme.bodyLarge?.copyWith(
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // * list chefs
          // SliverToBoxAdapter(
          //   child: ConstrainedBox(
          //     constraints: const BoxConstraints(
          //       maxHeight: 150,
          //       minHeight: 100,
          //     ),
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: [
          //           ListView.builder(
          //               shrinkWrap: true,
          //               physics: NeverScrollableScrollPhysics(),
          //               scrollDirection: Axis.horizontal,
          //               itemCount: 5,
          //               itemBuilder: (BuildContext context, int index) {
          //                 return Column(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: [
          //                     StoryWidget(
          //                       imageUrl: Assets.images.onboarding3.path,
          //                       // isNew: true,
          //                       addChild: ConstrainedBox(
          //                         constraints: BoxConstraints(
          //                           maxWidth: 80,
          //                         ),
          //                         child: Column(
          //                           mainAxisSize: MainAxisSize.min,
          //                           children: [
          //                             const SizedBox(height: 4),
          //                             Text(
          //                               "chef user num 1",
          //                               style: theme.textTheme.labelLarge
          //                                   ?.copyWith(
          //                                 height: 1.2,
          //                               ),
          //                               textAlign: TextAlign.center,
          //                               maxLines: 2,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                             Text(
          //                               "12k seguidores",
          //                               style: theme.textTheme.labelSmall
          //                                   ?.copyWith(
          //                                 height: 1.2,
          //                               ),
          //                               textAlign: TextAlign.center,
          //                               maxLines: 1,
          //                               overflow: TextOverflow.ellipsis,
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 );
          //               }),
          //           IconButton(
          //             onPressed: () {},
          //             icon: Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 5),
          //               child: Column(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Assets.svgs.moreHorizontal.svg(),
          //                   Text(
          //                     "see more",
          //                     style: theme.textTheme.bodyMedium,
          //                   )
          //                 ],
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // * popular tag
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 4),
          //     child: Column(
          //       // crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         // title del tag y total recipes
          //         Padding(
          //           padding: const EdgeInsets.symmetric(horizontal: 10),
          //           child: Row(
          //             children: [
          //               AutoSizeText(
          //                 "#popularTag",
          //                 style: theme.textTheme.titleMedium?.copyWith(
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //               Spacer(),
          //               AutoSizeText(
          //                 "3,7 recipes",
          //                 style: theme.textTheme.titleSmall?.copyWith(),
          //                 maxLines: 1,
          //                 overflow: TextOverflow.ellipsis,
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(height: 5),
          //         // Vistas de los recipes
          //         ConstrainedBox(
          //           constraints: BoxConstraints(maxHeight: 300),
          //           child: SingleChildScrollView(
          //             scrollDirection: Axis.horizontal,
          //             child: Row(
          //               children: [
          //                 ...List.generate(
          //                   5,
          //                   (index) {
          //                     return Card(
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(20),
          //                       ),
          //                       child: ClipRRect(
          //                         borderRadius: BorderRadius.circular(20),
          //                         child: Stack(
          //                           children: [
          //                             Assets.images.onboarding2.image(
          //                               width: 200,
          //                               fit: BoxFit.cover,
          //                             ),
          //                             // autor de la receta
          //                             Positioned(
          //                               top: 12,
          //                               left: 12,
          //                               child: Container(
          //                                 // width: 120,
          //                                 height: 30,
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       BorderRadius.circular(50),
          //                                   color: theme.cardColor
          //                                       .withOpacity(0.75),
          //                                 ),
          //                                 child: Padding(
          //                                   padding: const EdgeInsets.symmetric(
          //                                       horizontal: 3),
          //                                   child: Row(
          //                                     children: [
          //                                       SizedBox(
          //                                         height: 25,
          //                                         width: 25,
          //                                         child: CircleAvatar(
          //                                           backgroundImage: AssetImage(
          //                                             Assets.images.onboarding2
          //                                                 .path,
          //                                           ),
          //                                         ),
          //                                       ),
          //                                       const SizedBox(width: 5),
          //                                       AutoSizeText(
          //                                         "Katie Armin",
          //                                         style: theme
          //                                             .textTheme.bodySmall
          //                                             ?.copyWith(
          //                                           fontWeight: FontWeight.w600,
          //                                         ),
          //                                       ),
          //                                       const SizedBox(width: 5),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ),
          //                             // informacion de la receta
          //                             Positioned(
          //                               bottom: 0,
          //                               right: 0,
          //                               left: 0,
          //                               child: Container(
          //                                 padding: EdgeInsets.symmetric(
          //                                     vertical: 10),
          //                                 // height: 50,
          //                                 decoration: BoxDecoration(
          //                                   color: theme.cardColor
          //                                       .withOpacity(0.95),
          //                                   borderRadius:
          //                                       BorderRadius.circular(20),
          //                                 ),
          //                                 child: Column(
          //                                   children: [
          //                                     Padding(
          //                                       padding:
          //                                           const EdgeInsets.symmetric(
          //                                               horizontal: 10),
          //                                       child: AutoSizeText(
          //                                         "Almond & Orange Blossom French Crepes",
          //                                         maxLines: 2,
          //                                         style: theme
          //                                             .textTheme.headlineSmall
          //                                             ?.copyWith(
          //                                           fontWeight: FontWeight.w600,
          //                                           height: 1.2,
          //                                         ),
          //                                       ),
          //                                     ),
          //                                     const SizedBox(height: 10),
          //                                     Row(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment
          //                                               .spaceEvenly,
          //                                       children: [
          //                                         IconText(
          //                                           svgPath:
          //                                               Assets.svgs.time.path,
          //                                           text: "30 min",
          //                                         ),
          //                                         const DividerVertical(),
          //                                         IconText(
          //                                           svgPath: Assets
          //                                               .svgs.foodEasy.path,
          //                                           text: "Easy",
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     );
          //                   },
          //                 ),
          //                 IconButton(
          //                   onPressed: () {},
          //                   icon: Padding(
          //                     padding:
          //                         const EdgeInsets.symmetric(horizontal: 5),
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: [
          //                         Assets.svgs.moreHorizontal.svg(),
          //                         Text(
          //                           "see more",
          //                           style: theme.textTheme.bodyMedium,
          //                         )
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          LoadingMoreSliverList<RecipeModel>(
            SliverListConfig<RecipeModel>(
              itemBuilder: (context, recipe, index) {
                return PublicationRecipe(
                  keyImageHero: "image_recipe_for_you_$index",
                  recipe: recipe,
                  user: _user!,
                );
              },
              indicatorBuilder: _buildIndicator,
              sourceList: source,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
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
      final recipes = await recipeService.getRecipes(page, pageSize);

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
    // shrinkWrap: true,
    // physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Shimmer.fromColors(
          baseColor: AppColors.silver700.withOpacity(0.3),
          highlightColor: AppColors.silver400.withOpacity(0.4),
          child: Container(
            height: 280.0,
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
