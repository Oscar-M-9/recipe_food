import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';

class DividerVertical extends StatelessWidget {
  const DividerVertical({
    super.key,
    this.height = 18,
    this.width = 1.5,
    this.marginH = 2.0,
  });

  final double height;
  final double width;
  final double marginH;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: marginH),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.silver300,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
