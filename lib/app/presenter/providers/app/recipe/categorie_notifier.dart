import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/presenter/services/recipe/recipe_service.dart';

final categoriesNotifier =
    StateNotifierProvider<CategorieNotifier, List<CategorieModel?>>((ref) {
  return CategorieNotifier();
});

class CategorieNotifier extends StateNotifier<List<CategorieModel?>> {
  CategorieNotifier() : super([]);

  Future<void> loadCategories() async {
    // Aquí se obtiene las categorías
    if (state.isEmpty) {
      final categories = await RecipeService().getCategories();
      state = categories;
    }
  }

  void clearCategorieData() {
    state = [];
  }
}
