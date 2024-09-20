import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/presenter/providers/app/recipe/categorie_notifier.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';

class CategoryDropdownField extends ConsumerStatefulWidget {
  const CategoryDropdownField({super.key});

  @override
  CategoryDropdownFieldState createState() => CategoryDropdownFieldState();
}

class CategoryDropdownFieldState extends ConsumerState<CategoryDropdownField> {
  @override
  void initState() {
    super.initState();
    ref.read(categoriesNotifier.notifier).loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoriesNotifier);
    return FormBuilderDropdown(
      name: 'category',
      decoration: CustomInput.buildInputDecoration(
        context,
        radius: 10,
        hintText: AppLocalizations.of(context)!.textSelectACategory,
        labelText: AppLocalizations.of(context)!.textCategory,
      ),
      items: categories.isNotEmpty
          ? categories
              .map(
                (category) => DropdownMenuItem(
                  value: category?.id,
                  child: Text(
                    category!.name!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              )
              .toList()
          : [],
      validator: FormBuilderValidators.required(),
    );
  }
}
