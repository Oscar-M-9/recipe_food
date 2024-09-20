// ignore_for_file: deprecated_member_use_from_same_package

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/utils/utils.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/services/recipe/recipe_service.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/icon_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/expandable_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/publication_detail_recipe.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class PublicationRecipe extends StatelessWidget {
  const PublicationRecipe({
    super.key,
    required this.keyImageHero,
    required this.recipe,
    required this.user,
  });
  final String keyImageHero;
  final RecipeModel recipe;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      final recipeService = RecipeService();
      var box = await Hive.openBox('user');
      var user = box.get('user') as UserModel;

      /// send your request here
      if (!isLiked) {
        await recipeService.likeRecipe(recipe.id!, user.id!);
      } else {
        await recipeService.unLikeRecipe(recipe.id!, user.id!);
      }

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
                backgroundImage: recipe.user?.avatar_url != null
                    ? CachedNetworkImageProvider(recipe.user!.avatar_url!)
                    : Assets.images.blankProfilePicture.provider(),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      recipe.user?.name ?? "-----",
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
                icon: const Icon(Icons.more_vert_rounded),
              ),
            ],
          ),

          const SizedBox(height: 8),
          // imagen y titulo de la receta
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PublicationDetailRecipe(
                    keyImageHero: keyImageHero,
                    recipe: recipe,
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
                    constraints: const BoxConstraints(minHeight: 200),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: recipe.images!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: recipe.images!.first.image_url!,
                              fit: BoxFit.contain,
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
                              errorWidget: (context, url, error) =>
                                  const Center(
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
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              recipe.title ?? "-----",
                              maxLines: 2,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                height: 1.15,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconText(
                              svgPath: Assets.svgs.time.path,
                              text: "${recipe.cooking_time ?? 00} min",
                            ),
                            const DividerVertical(),
                            IconText(
                              svgPath: AppUtils.getDifficultySvgPath(
                                  recipe.difficulty),
                              text: AppUtils.getDifficultyText(
                                  context, recipe.difficulty),
                            ),

                            const DividerVertical(),
                            IconText(
                              svgPath: Assets.svgs.serveAlt.path,
                              text: "${recipe.servings ?? 00}",
                            ),
                            // IconText(
                            //   svgPath: Assets.svgs.fire.path,
                            //   text: "320 Cal",
                            // ),
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
          Align(
            alignment: Alignment.centerLeft,
            child: ExpandableText(
              text: recipe.short_description ?? "",
              trimLength: (MediaQuery.of(context).size.width * 0.6).toInt(),
            ),
          ),
          const SizedBox(height: 15),
          // like , comment , share and save options
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // like -> me gustas
              LikeButton(
                // size: 40.0,
                likeCount: recipe.like?.length ?? 0,
                key: GlobalKey<LikeButtonState>(),
                isLiked: recipe.like
                        ?.map(
                          (e) => e.user_id,
                        )
                        .contains(user.id!) ??
                    false,
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
                        color:
                            isLiked ? Colors.pinkAccent : theme.iconTheme.color,
                      ),
                    );
                  } else {
                    return Center(
                      child: Assets.svgs.iconFavorite.svg(
                        height: 24,
                        color:
                            isLiked ? Colors.pinkAccent : theme.iconTheme.color,
                      ),
                    );
                  }
                },
                countBuilder: (int? count, bool isLiked, String text) {
                  final Color? color =
                      isLiked ? Colors.pinkAccent : theme.iconTheme.color;
                  Widget result;
                  if (count == 0) {
                    result = Text(
                      AppLocalizations.of(context)!.textLike,
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
