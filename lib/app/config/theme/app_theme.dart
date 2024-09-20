import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/app_colors.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme() {
    return ThemeData(
      fontFamily: "Quicksand",
      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
      ),
      colorScheme: const ColorScheme.light(
        brightness: Brightness.light,
        primary: AppColors.visVis500,
        // onSurface: Colors.green,
      ),
      useMaterial3: true,
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.visVis400;
            }
            return Colors.transparent;
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        side: const BorderSide(
          color: AppColors.silver400,
          width: 1.5,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppColors.visVis500,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.visVis500,
        unselectedItemColor: AppColors.silver500,
      ),
      shadowColor: AppColors.silver100,
      cardColor: Colors.white,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: Colors.transparent,
        color: AppColors.visVis400,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: Colors.white,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      fontFamily: "Quicksand",
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xF50C0C0C),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.black,
      ),
      colorScheme: const ColorScheme.dark(
        // seedColor: AppColors.visVis700,
        primary: AppColors.visVis500,
        brightness: Brightness.dark,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.visVis400;
            }
            return Colors.transparent;
          },
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        side: const BorderSide(
          color: AppColors.silver400,
          width: 1.5,
        ),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppColors.visVis500,
          ),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color.fromARGB(255, 35, 35, 35),
        selectedItemColor: AppColors.visVis500,
        unselectedItemColor: AppColors.silver200,
      ),
      shadowColor: AppColors.silver900,
      cardColor: AppColors.silver950,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        circularTrackColor: Colors.transparent,
        color: AppColors.visVis500,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        fillColor: AppColors.silver950,
      ),
    );
  }
}
