import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/utils/utils.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/ui/shared/widgets/publication_detail_recipe.dart';
import 'package:recipe_food/gen/assets.gen.dart';

import 'package:recipe_food/app/ui/shared/widgets/glass_morphism.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';

class CardMyFavorite extends StatelessWidget {
  CardMyFavorite({
    super.key,
    this.index = 0,
    required this.recipe,
  }) : assert(index! >= 0);

  final int? index;
  final RecipeModel recipe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PublicationDetailRecipe(
                keyImageHero: "image_my_favorite_$index",
                recipe: recipe,
                isAuthor: false,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 6,
          shadowColor: theme.shadowColor.withOpacity(0.6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                // imagen de fondo
                SizedBox.expand(
                  child: Hero(
                    tag: "image_my_favorite_$index",
                    child: recipe.images!.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: recipe.images!.first.image_url!,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        : Assets.images.placeholderImage.image(
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const GlassMorphism(
                  blur: 0.3,
                  opacity: 0.15,
                  color: Colors.black,
                  child: SizedBox.expand(),
                ),
                // calificacion de la receta
                Positioned(
                  top: 8,
                  left: 8,
                  child: GlassMorphism(
                    blur: 1.5,
                    opacity: 0.4,
                    color: AppColors.silver950,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ).copyWith(right: 10),
                      child: Row(
                        children: [
                          Assets.svgs.iconFavoriteFill.svg(
                            height: 20,
                            // ignore: deprecated_member_use_from_same_package
                            color: Colors.pinkAccent,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            AppUtils.formatLargeNumber(
                                recipe.like?.length ?? 0),
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          // const Icon(
                          //   Icons.star_border_rounded,
                          //   color: Colors.white,
                          //   size: 20,
                          // ),
                          // const SizedBox(width: 2),
                          // Text(
                          //   "5,0",
                          //   style: theme.textTheme.titleSmall?.copyWith(
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.white,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                // opciones de la receta
                // Positioned(
                //   top: 8,
                //   right: 8,
                //   child: IconButton(
                //     style: ButtonStyle(
                //       backgroundColor: WidgetStatePropertyAll(
                //         Colors.white.withOpacity(0.9),
                //       ),
                //     ),
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.more_horiz_rounded,
                //       color: AppColors.visVis600,
                //     ),
                //   ),
                // ),
                // informacion de la receta
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: GlassMorphism(
                    blur: 1.5,
                    opacity: 0.4,
                    color: AppColors.silver900,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 12,
                        right: 10,
                        left: 10,
                        top: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.title ??
                                AppLocalizations.of(context)!.textRecipe,
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          // Row(
                          //   children: [
                          //     _CustomTextInfo(
                          //       text:
                          //           "${recipe.ingredients?.length ?? 0} ${AppLocalizations.of(context)!.textIngredients}",
                          //       flex: 2,
                          //     ),
                          //     const DividerVertical(marginH: 4),
                          //     _CustomTextInfo(
                          //       text: "${recipe.cooking_time ?? 00} min",
                          //     ),
                          //     if (recipe.difficulty != null) ...[
                          //       const DividerVertical(marginH: 4),
                          //       _CustomTextInfo(
                          //         text: AppUtils.getDifficultyText(
                          //             context, recipe.difficulty),
                          //       ),
                          //     ],
                          //   ],
                          // )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomTextInfo extends StatelessWidget {
  const _CustomTextInfo({
    required this.text,
    // ignore: unused_element
    this.flex = 1,
  });

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Flexible(
      flex: flex,
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
