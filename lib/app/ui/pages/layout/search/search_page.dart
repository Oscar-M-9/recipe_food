import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/icon_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/story.dart';
import 'package:recipe_food/app/ui/shared/widgets/expandable_text.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/app/ui/shared/widgets/publication_recipe.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  late final Timer _timer;
  late final CarouselController _carouselController;
  final _itemExtent = 330.0;
  final _autoPlayDuration = const Duration(seconds: 4);

  double paddingBottom = 0.0;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _carouselController = CarouselController();

    // Animates to the next item every 4 seconds
    // Usar un post frame callback para asegurarse de que el árbol de widgets esté construido
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(
        _autoPlayDuration,
        (_) => _animateToNextItem(),
      );
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
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
    final theme = Theme.of(context);

    return Scaffold(
      body: ExtendedNestedScrollView(
        pinnedHeaderSliverHeightBuilder: () {
          return MediaQuery.of(context).padding.top;
        },
        onlyOneScrollInBody: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 20,
                  right: 10,
                  left: 10,
                ),
                child: Text(
                  AppLocalizations.of(context)!.labelSearch,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            PinnedHeaderSliver(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10,
                  bottom: 10,
                  right: 10,
                  left: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: _isFocused
                          ? AppColors.visVis400.withOpacity(
                              0.3) // Color de la sombra cuando está en foco
                          : AppColors.silver700.withOpacity(
                              0.2), // Color de la sombra cuando no está en foco
                      blurRadius: 8.0,
                      offset: Offset(0, 4),
                    ),
                  ],
                  border: Border.all(
                    color:
                        _isFocused ? AppColors.visVis400 : AppColors.silver700,
                    width: _isFocused ? 1.5 : 1.0,
                  ),
                ),
                child: TextFormField(
                  focusNode: _focusNode,
                  decoration: CustomInput.searchExtendInputDecoration(
                    context,
                    hintText:
                        AppLocalizations.of(context)!.textSearchRecipeOrChef,
                    prefixIcon: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      child: Assets.svgs.iconSearch.svg(
                        // ignore: deprecated_member_use_from_same_package
                        color: theme.iconTheme.color?.withOpacity(0.7),
                      ),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: Assets.svgs.settings04.svg(
                        height: 20,
                        width: 20,
                        // ignore: deprecated_member_use_from_same_package
                        color: theme.iconTheme.color?.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ];
        },
        body: CustomScrollView(
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
            SliverToBoxAdapter(child: const SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).copyWith(bottom: 3, top: 12),
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
                                          style: theme.textTheme.labelLarge
                                              ?.copyWith(
                                            height: 1.2,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "12k seguidores",
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
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
                                              color: theme.cardColor
                                                  .withOpacity(0.75),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          AssetImage(
                                                        Assets.images
                                                            .onboarding2.path,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 5),
                                                  AutoSizeText(
                                                    "Katie Armin",
                                                    style: theme
                                                        .textTheme.bodySmall
                                                        ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            // height: 50,
                                            decoration: BoxDecoration(
                                              color: theme.cardColor
                                                  .withOpacity(0.95),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: AutoSizeText(
                                                    "Almond & Orange Blossom French Crepes",
                                                    maxLines: 2,
                                                    style: theme
                                                        .textTheme.headlineSmall
                                                        ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.2,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    IconText(
                                                      svgPath:
                                                          Assets.svgs.time.path,
                                                      text: "30 min",
                                                    ),
                                                    const DividerVertical(),
                                                    IconText(
                                                      svgPath: Assets
                                                          .svgs.foodEasy.path,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
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
            //* recipes
            // title recetas
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Recetas",
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  // publicaciones de la receta
                ],
              ),
            ),
            // publicaciones de la receta
            SliverList.builder(
              itemBuilder: (context, index) {
                return PublicationRecipe(
                  keyImageHero: "image_search_$index",
                );
              },
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 90),
            )
          ],
        ),
      ),
    );
  }
}
