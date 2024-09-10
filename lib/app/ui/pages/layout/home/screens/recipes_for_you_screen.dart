// ignore_for_file: dead_code

import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';

import 'package:recipe_food/app/ui/pages/layout/home/widgets/card_recipe.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/icon_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/story.dart';
import 'package:recipe_food/app/ui/shared/widgets/publication_recipe.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class RecipesForYouScreen extends StatefulWidget {
  const RecipesForYouScreen({super.key});

  @override
  State<RecipesForYouScreen> createState() => _RecipesForYouScreenState();
}

class _RecipesForYouScreenState extends State<RecipesForYouScreen>
    with AutomaticKeepAliveClientMixin {
  late final LoadMoreListSource source = LoadMoreListSource();
  late final Timer _timer;
  late final CarouselController _carouselController;
  final _itemExtent = 330.0;
  final _autoPlayDuration = const Duration(seconds: 4);

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
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);
    return LoadingMoreCustomScrollView(
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
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10)
                .copyWith(bottom: 3, top: 12),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "The Chefs you might like",
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        // list chefs
        SliverToBoxAdapter(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 150,
              minHeight: 100,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            StoryWidget(
                              imageUrl: Assets.images.onboarding3.path,
                              // isNew: true,
                              addChild: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: 80,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      "chef user num 1",
                                      style:
                                          theme.textTheme.labelLarge?.copyWith(
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "12k seguidores",
                                      style:
                                          theme.textTheme.labelSmall?.copyWith(
                                        height: 1.2,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                  IconButton(
                    onPressed: () {},
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Assets.svgs.moreHorizontal.svg(),
                          Text(
                            "see more",
                            style: theme.textTheme.bodyMedium,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        // popular tag
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // title del tag y total recipes
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      AutoSizeText(
                        "#popularTag",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      AutoSizeText(
                        "3,7 recipes",
                        style: theme.textTheme.titleSmall?.copyWith(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                // Vistas de los recipes
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  children: [
                                    Assets.images.onboarding2.image(
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                    // autor de la receta
                                    Positioned(
                                      top: 12,
                                      left: 12,
                                      child: Container(
                                        // width: 120,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color:
                                              theme.cardColor.withOpacity(0.75),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 3),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 25,
                                                width: 25,
                                                child: CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                    Assets.images.onboarding2
                                                        .path,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                              AutoSizeText(
                                                "Katie Armin",
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    // informacion de la receta
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        // height: 50,
                                        decoration: BoxDecoration(
                                          color:
                                              theme.cardColor.withOpacity(0.95),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: AutoSizeText(
                                                "Almond & Orange Blossom French Crepes",
                                                maxLines: 2,
                                                style: theme
                                                    .textTheme.headlineSmall
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.2,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconText(
                                                  svgPath:
                                                      Assets.svgs.time.path,
                                                  text: "30 min",
                                                ),
                                                const DividerVertical(),
                                                IconText(
                                                  svgPath:
                                                      Assets.svgs.foodEasy.path,
                                                  text: "Easy",
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Assets.svgs.moreHorizontal.svg(),
                                Text(
                                  "see more",
                                  style: theme.textTheme.bodyMedium,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        LoadingMoreSliverList<int>(
          SliverListConfig<int>(
            itemBuilder: (context, item, index) {
              return PublicationRecipe(
                keyImageHero: "image_recipe_for_you_$index",
              );
            },
            indicatorBuilder: _buildIndicator,
            sourceList: source,
          ),
        ),
      ],
    );
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
      widget = ListView(
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



// return Builder(
    //   builder: (context) {
    //     // Aquí se devuelve la página activa, con su propio ScrollController
    //     return ScrollConfiguration(
    //       behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
    //       child: CustomScrollView(
    //         key: const PageStorageKey<String>('tab-recipe-for-you'),
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