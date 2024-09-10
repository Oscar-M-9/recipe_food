import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';

class CustomInput {
  static InputDecoration buildInputDecoration(
    BuildContext context, {
    String hintText = "",
    String? labelText,
    double radius = 20,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return InputDecoration(
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      hintText: hintText,
      labelText: labelText,
      hintStyle: Theme.of(context).textTheme.bodyMedium,
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          width: 1.0,
          color: AppColors.silver400,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          width: 1.0,
          color: AppColors.silver400,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          width: 1.0,
          color: AppColors.visVis500,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(
          width: 1.0,
          color: AppColors.radicalRed500,
        ),
      ),
    );
  }

  static InputDecoration searchInputDecoration(
    BuildContext context, {
    required String hint,
  }) {
    return InputDecoration(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      hintText: hint,
      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.silver600,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 0,
        horizontal: 5,
      ),
    );
  }

  static InputDecoration searchExtendInputDecoration(BuildContext context,
      {required String hintText, Widget? prefixIcon, Widget? suffixIcon}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      hintText: hintText,
      hintStyle: Theme.of(context).textTheme.bodyMedium,
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
    );
  }
}
