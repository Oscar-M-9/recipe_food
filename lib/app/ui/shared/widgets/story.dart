import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';

class StoryWidget extends StatelessWidget {
  // final String username;
  final String imageUrl;
  final bool isNew;
  final bool isViewed;
  final bool isLive;
  final bool isOnline;
  final bool isCreate;
  // final TextStyle? styleUsername;
  final Widget? addChild;

  const StoryWidget({
    super.key,
    // required this.username,
    required this.imageUrl,
    this.isNew = false,
    this.isViewed = false,
    this.isLive = false,
    this.isOnline = false,
    this.isCreate = false,
    this.addChild,
    // this.styleUsername,
  });

  @override
  Widget build(BuildContext context) {
    List<Color> borderColors;
    final theme = Theme.of(context);

    if (isLive) {
      borderColors = [
        AppColors.radicalRed600,
        AppColors.radicalRed500,
        AppColors.radicalRed400,
        AppColors.radicalRed400,
        AppColors.radicalRed500,
        AppColors.radicalRed600,
      ];
    } else if (isNew) {
      borderColors = [
        AppColors.visVis500,
        AppColors.visVis300,
        AppColors.jade300,
        AppColors.jade600,
      ];
    } else if (isViewed) {
      borderColors = [
        AppColors.silver500,
        AppColors.silver400,
        AppColors.silver300,
        AppColors.silver300,
        AppColors.silver400,
        AppColors.silver500,
      ];
    } else {
      borderColors = [
        Colors.transparent,
        Colors.transparent,
      ];
    }

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: isViewed
                    ? const EdgeInsets.all(1.5)
                    : const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: borderColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.scaffoldBackgroundColor,
                      width: 2.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(imageUrl),
                  ),
                ),
              ),
              if (isLive)
                Positioned(
                  bottom: 0,
                  left: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      color: AppColors.radicalRed500,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AutoSizeText(
                      'LIVE',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      // style: TextStyle(
                      //   color: Colors.white,
                      //   fontSize: 10,
                      //   fontWeight: FontWeight.bold,
                      // ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              if (isOnline && !isLive)
                Positioned(
                  bottom: 2,
                  right: 8,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: AppColors.jade400,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        )),
                  ),
                ),
              if (isCreate)
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.jade500,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.scaffoldBackgroundColor,
                        width: 2.0,
                      ),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
            ],
          ),
          // const SizedBox(height: 4),
          // ConstrainedBox(
          //   constraints: BoxConstraints(
          //     maxWidth: 75,
          //   ),
          //   child: Text(
          //     username,
          //     style: styleUsername ??
          //         theme.textTheme.labelSmall?.apply(
          //           fontSizeFactor: 1.1,
          //         ),
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
          if (addChild != null) addChild!,
        ],
      ),
    );
  }
}
