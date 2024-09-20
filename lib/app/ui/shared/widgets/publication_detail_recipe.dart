import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/utils/utils.dart';
import 'package:recipe_food/app/infra/models/others/user_stats.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/presenter/services/profile/profile_service.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class PublicationDetailRecipe extends StatefulWidget {
  const PublicationDetailRecipe({
    super.key,
    required this.keyImageHero,
    required this.recipe,
    this.isAuthor = true,
  });

  final String keyImageHero;
  final RecipeModel recipe;
  final bool isAuthor;

  @override
  State<PublicationDetailRecipe> createState() =>
      _PublicationDetailRecipeState();
}

class _PublicationDetailRecipeState extends State<PublicationDetailRecipe> {
  UserStats? _userStats;
  final profileService = ProfileService();

  @override
  void initState() {
    getUserFollowers();
    super.initState();
  }

  void getUserFollowers() async {
    final userStats =
        await profileService.getUserStats(widget.recipe.user!.id!);
    setState(() {
      _userStats = userStats;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              // !! titulo
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.recipe.title ??
                      AppLocalizations.of(context)!.textTitle,
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // *!! imagen
              Hero(
                tag: widget.keyImageHero,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minHeight: 150,
                    maxHeight: 300,
                  ),
                  child: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: widget.recipe.images != null &&
                                widget.recipe.images!.isNotEmpty
                            ? widget.recipe.images!.map((e) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl: e.image_url!,
                                      fit: BoxFit.contain,
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                );
                              }).toList()
                            : [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Assets.images.placeholderImage
                                      .image(fit: BoxFit.cover),
                                ),
                              ],
                      ),
                    ),
                  ),
                  // child: ClipRRect(
                  //   borderRadius: BorderRadius.circular(15),
                  //   child: widget.recipe.images!.isNotEmpty
                  //       ? CachedNetworkImage(
                  //           imageUrl: widget.recipe.images!.first.image_url!,
                  //           fit: BoxFit.cover,
                  //           progressIndicatorBuilder:
                  //               (context, url, downloadProgress) => Center(
                  //             child: SizedBox(
                  //               width: 40,
                  //               height: 40,
                  //               child: CircularProgressIndicator(
                  //                 value: downloadProgress.progress,
                  //               ),
                  //             ),
                  //           ),
                  //           errorWidget: (context, url, error) => const Center(
                  //             child: SizedBox(
                  //               width: 40,
                  //               height: 40,
                  //               child: Icon(
                  //                 Icons.error,
                  //                 color: Colors.red,
                  //               ),
                  //             ),
                  //           ),
                  //         )
                  //       : Assets.images.placeholderImage.image(
                  //           fit: BoxFit.cover,
                  //         ),
                  // ),
                ),
              ),

              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Divider(
                  color: AppColors.silver950.withOpacity(0.2),
                ),
              ),
              // !! Creador
              if (widget.isAuthor)
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: widget.recipe.user?.avatar_url != null
                        ? CachedNetworkImageProvider(
                            widget.recipe.user!.avatar_url!)
                        : Assets.images.blankProfilePicture.provider(),
                    radius: 25,
                  ),
                  title: Text(
                    widget.recipe.user?.name ?? "-----",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    "${AppUtils.formatLargeNumber(_userStats?.followersCount ?? 0)} ${AppLocalizations.of(context)!.textFollowers}",
                    style: textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.textFollow,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 15),
              // !! Dificultad de la receta
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.textDifficulty,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    AppUtils.getDifficultyText(
                        context, widget.recipe.difficulty),
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.silver950.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Divider(
                  color: AppColors.silver950.withOpacity(0.2),
                ),
              ),
              // !! lista de los ingredientes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.textIngredients,
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${widget.recipe.ingredients?.length ?? 0} items",
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.silver950.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // *lista de los ingredientes
              ...List.generate(
                widget.recipe.ingredients!.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.silver900.withOpacity(0.05),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            child: Assets.svgs.ingredients.svg(
                              height: 40,
                              width: 40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              widget.recipe.ingredients![index].name ?? "----",
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 60),
                            child: Text(
                              widget.recipe.ingredients![index].quantity ??
                                  "00",
                              style: textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.silver950.withOpacity(0.5),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                child: Divider(
                  color: AppColors.silver950.withOpacity(0.2),
                ),
              ),
              // !! Pasos de la receta
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.textSteps,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...List.generate(
                widget.recipe.steps!.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${AppLocalizations.of(context)!.textStep} ${widget.recipe.steps![index].step_number}",
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          widget.recipe.steps![index].step_detail ?? "----",
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
