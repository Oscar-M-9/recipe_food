import 'package:flutter/material.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class CustomToast extends StatelessWidget {
  const CustomToast({
    super.key,
    required this.text,
    this.color = Colors.black,
    this.textColor = Colors.white,
  });

  final String text;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color.withOpacity(0.9),
          border: Border.all(
            color: color,
            width: 2,
          )),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Assets.images.iconFoodLogo.image(
              height: 25,
              width: 25,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 200),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
