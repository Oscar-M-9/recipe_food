// ignore_for_file: deprecated_member_use_from_same_package

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/icon_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/expandable_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/publication_detail_recipe.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class PublicationRecipe extends StatelessWidget {
  const PublicationRecipe({
    super.key,
    required this.keyImageHero,
  });
  final String keyImageHero;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      /// send your request here
      // final bool success= await sendRequest();

      /// if failed, you can do nothing
      // return success? !isLiked:isLiked;

      return !isLiked;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: Assets.images.onboarding3.provider(),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "By Roberta Anny",
                      style: theme.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // AutoSizeText(
                    //   "By Roberta Anny",
                    //   style: theme.textTheme.bodySmall,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  // opcion guardar y denunciar como en instagram
                },
                icon: Icon(Icons.more_vert_rounded),
              ),
            ],
          ),
          // // titulo de la receta
          // const SizedBox(height: 2),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     "How to make french toast",
          //     style: theme.textTheme.titleMedium?.copyWith(
          //       fontWeight: FontWeight.w600,
          //       height: 1.12,
          //     ),
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),

          const SizedBox(height: 8),
          // imagen y titulo de la receta
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PublicationDetailRecipe(
                    keyImageHero: keyImageHero,
                  ),
                ),
              );
            },
            child: Stack(
              children: [
                // imagen de la receta
                Hero(
                  tag: keyImageHero,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 150),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Assets.images.onboarding1.image(
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    //  titulo de la receta  ademas info necesario
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          child: AutoSizeText(
                            "Almond & Orange Blossom French Crepes",
                            maxLines: 2,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.15,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconText(
                              svgPath: Assets.svgs.time.path,
                              text: "30 min",
                            ),
                            const DividerVertical(),
                            IconText(
                              svgPath: Assets.svgs.foodEasy.path,
                              text: "Easy",
                            ),
                            const DividerVertical(),
                            IconText(
                              svgPath: Assets.svgs.fire.path,
                              text: "320 Cal",
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // alguna descripcion
          const SizedBox(height: 6),
          const Align(
            alignment: Alignment.centerLeft,
            child: ExpandableText(
              text:
                  'Este es un texto muy largo que se mostrará en forma resumida inicialmente. Si el usuario hace clic en "Ver más", se mostrará todo el contenido.',
              trimLength: 50,
            ),
          ),
          const SizedBox(height: 10),
          // like , comment , share and save options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // like -> me gustas
              LikeButton(
                // size: 40.0,
                likeCount: 999,
                key: GlobalKey<LikeButtonState>(),
                isLiked: false,
                // postFrameCallback: (LikeButtonState state) {
                //   state.controller?.forward();
                // },
                circleColor: const CircleColor(
                  start: Colors.pinkAccent,
                  end: Colors.pink,
                ),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Colors.pinkAccent,
                  dotSecondaryColor: Colors.pink,
                ),
                likeBuilder: (bool isLiked) {
                  if (isLiked) {
                    return Center(
                      child: Assets.svgs.iconFavoriteFill.svg(
                        height: 24,
                        color: isLiked ? Colors.pinkAccent : Colors.grey,
                      ),
                    );
                  } else {
                    return Center(
                      child: Assets.svgs.iconFavorite.svg(
                        height: 24,
                        color: isLiked ? Colors.pinkAccent : Colors.grey,
                      ),
                    );
                  }
                },
                countBuilder: (int? count, bool isLiked, String text) {
                  final ColorSwatch<int> color =
                      isLiked ? Colors.pinkAccent : Colors.grey;
                  Widget result;
                  if (count == 0) {
                    result = Text(
                      'love',
                      style: TextStyle(color: color),
                    );
                  } else {
                    result = Text(
                      count! >= 1000
                          ? '${(count / 1000.0).toStringAsFixed(1)}k'
                          : text,
                      style: TextStyle(color: color),
                    );
                  }
                  return result;
                },
                likeCountAnimationType: 999 < 1000
                    ? LikeCountAnimationType.part
                    : LikeCountAnimationType.none,
                likeCountPadding: const EdgeInsets.only(left: 2.0),
                onTap: onLikeButtonTapped,
              ),
              // like
              // Assets.svgs.iconFavorite.svg(height: 20),
              // const SizedBox(width: 2),
              // Text(
              //   "14,2k",
              //   style: theme.textTheme.titleMedium,
              // ),
              const SizedBox(width: 8),
              // // comentarios
              // Assets.svgs.commentAltLines.svg(height: 28),
              // const SizedBox(width: 2),
              // Text(
              //   "118",
              //   style: theme.textTheme.titleMedium,
              // ),
              // const SizedBox(width: 10),
              // // compartidos
              // Assets.svgs.share.svg(height: 20),
              // const SizedBox(width: 5),
              // Text(
              //   "100",
              //   style: theme.textTheme.titleMedium,
              // ),
              const Spacer(),
              // guardar
              Assets.svgs.bookmark.svg(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
