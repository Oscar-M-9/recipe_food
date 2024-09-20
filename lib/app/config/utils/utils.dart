import 'package:flutter/material.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class AppUtils {
  // Definiendo una función para obtener el path del SVG basado en la dificultad
  static String getDifficultySvgPath(int? difficulty) {
    switch (difficulty) {
      case 1:
        return Assets.svgs.foodEasy.path;
      case 2:
        return Assets.svgs.foodMedium.path;
      case 3:
        return Assets.svgs.foodHard.path;
      default:
        return Assets.svgs.foodEasy
            .path; // Retorna este path si no hay dificultad definida o si es otro valor
    }
  }

  // Definiendo una función para obtener el texto localizado basado en la dificultad
  static String getDifficultyText(BuildContext context, int? difficulty) {
    switch (difficulty) {
      case 1:
        return AppLocalizations.of(context)!.textDifficultyEasy;
      case 2:
        return AppLocalizations.of(context)!.textDifficultyMedium;
      case 3:
        return AppLocalizations.of(context)!.textDifficultyHard;
      default:
        return ""; // Retorna cadena vacía si no hay dificultad definida o si es otro valor
    }
  }

  static String formatLargeNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      // Aquí verificamos si el decimal es diferente de cero
      double decimalPart =
          (number / 1000) - ((number / 1000).truncateToDouble());
      if (decimalPart != 0) {
        return '${(number / 1000).toStringAsFixed(1)}k';
      } else {
        return '${(number / 1000).toStringAsFixed(0)}k';
      }
    } else {
      return number.toString();
    }
  }
}
