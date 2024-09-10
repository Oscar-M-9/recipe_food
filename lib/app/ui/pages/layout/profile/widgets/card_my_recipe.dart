import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/utils/format_large_number.dart';
import 'package:recipe_food/gen/assets.gen.dart';

import 'package:recipe_food/app/ui/shared/widgets/glass_morphism.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';

class CardMyRecipe extends StatelessWidget {
  CardMyRecipe({
    super.key,
    this.ingredientsCount = 0,
  }) : assert(ingredientsCount! >= 0);

  final int? ingredientsCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: double.infinity,
      height: 210,
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
                child: Assets.images.onboarding3.image(
                  fit: BoxFit.cover,
                ),
              ),
              const GlassMorphism(
                blur: 0.2,
                opacity: 0.25,
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
                    ),
                    child: Row(
                      children: [
                        Assets.svgs.iconFavoriteFill.svg(
                          height: 20,
                          // ignore: deprecated_member_use_from_same_package
                          color: Colors.pinkAccent,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          formatLargeNumber(12478),
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
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.white.withOpacity(0.9),
                    ),
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: AppColors.visVis600,
                  ),
                ),
              ),
              // informacion de la receta
              Positioned(
                bottom: 12,
                right: 50,
                left: 15,
                child: Column(
                  children: [
                    Text(
                      "How to make Italian Spaghetti at home",
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        _CustomTextInfo(
                          text: "$ingredientsCount ingredients",
                          flex: 2,
                        ),
                        const DividerVertical(
                          marginH: 4,
                        ),
                        const _CustomTextInfo(
                          text: "40 min",
                        ),
                        const DividerVertical(
                          marginH: 4,
                        ),
                        const _CustomTextInfo(
                          text: "easy",
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
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
