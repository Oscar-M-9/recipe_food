import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:recipe_food/app/config/utils/format_large_number.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/divider_vertical.dart';
import 'package:recipe_food/app/ui/pages/layout/home/widgets/icon_text.dart';
import 'package:recipe_food/app/ui/shared/widgets/glass_morphism.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class CardRecipe extends StatelessWidget {
  const CardRecipe({
    super.key,
    this.favoriteCount = 0,
  });
  final int? favoriteCount;

  @override
  Widget build(BuildContext context) {
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      /// send your request here
      // final bool success= await sendRequest();

      /// if failed, you can do nothing
      // return success? !isLiked:isLiked;

      return !isLiked;
    }

    final theme = Theme.of(context);
    return Card(
      shadowColor: theme.shadowColor,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        // width: 400,
        height: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.55, 0.95],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image(
                    image: AssetImage(Assets.images.onboarding3.path),
                    fit: BoxFit.cover,
                  ),
                  // child: CachedNetworkImage(
                  //   progressIndicatorBuilder: (context, url, progress) =>
                  //       Center(
                  //     child: CircularProgressIndicator(
                  //       value: progress.progress,
                  //     ),
                  //   ),
                  //   imageUrl:
                  //       'https://images.unsplash.com/photo-1532264523420-881a47db012d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9',
                  // ),
                ),
              ),
              // author
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  // width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: theme.cardColor.withOpacity(0.75),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: 25,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              Assets.images.onboarding2.path,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        AutoSizeText(
                          "Katie Armin",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                ),
              ),
              // like and favorite
              Positioned(
                top: 12,
                right: 12,
                child: Column(
                  children: [
                    LikeButton(
                      onTap: onLikeButtonTapped,
                      size: 20,
                      circleColor: CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.home,
                          color:
                              isLiked ? Colors.deepPurpleAccent : Colors.grey,
                          size: 20,
                        );
                      },
                      likeCount: 665,
                      countBuilder: (int? count, bool isLiked, String text) {
                        var color =
                            isLiked ? Colors.deepPurpleAccent : Colors.grey;
                        Widget result;
                        if (count == 0) {
                          result = Text(
                            "love",
                            style: TextStyle(color: color),
                          );
                        } else
                          result = Text(
                            text,
                            style: TextStyle(color: color),
                          );
                        return result;
                      },
                    ),
                    // like
                    const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 3),
                    GlassMorphism(
                      blur: 9,
                      opacity: 0.8,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 1,
                          horizontal: 4,
                        ),
                        child: Text(
                          "2,3K",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // favorite
                    const Icon(
                      Icons.bookmark_rounded,
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 3),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 5),
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        formatLargeNumber(favoriteCount!),
                        // "1,3K",
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: AutoSizeText(
                        "Almond & Orange Blossom French Crepes",
                        maxLines: 2,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: theme.cardColor.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
