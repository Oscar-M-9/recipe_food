import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class NewTextFieldIngredient extends StatelessWidget {
  const NewTextFieldIngredient({
    super.key,
    this.onDelete,
    required this.ingredientName,
    required this.ingredientQuantity,
  });

  final String ingredientName;
  final String ingredientQuantity;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Campo para el nombre del ingrediente
          Expanded(
            child: FormBuilderTextField(
              name: ingredientName,
              decoration: CustomInput.buildInputDecoration(
                context,
                hintText: AppLocalizations.of(context)!.textIngredientName,
                radius: 10,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
              ]),
            ),
          ),
          const SizedBox(width: 10),
          // Campo para la cantidad del ingrediente
          Expanded(
            child: FormBuilderTextField(
              name: ingredientQuantity,
              decoration: CustomInput.buildInputDecoration(
                context,
                hintText: AppLocalizations.of(context)!.textQuantity,
                radius: 10,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
              ),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(1),
              ]),
            ),
          ),
          // Botón para eliminar el campo
          IconButton(
            icon: Assets.svgs.removeSquare.svg(
              height: 20,
              // ignore: deprecated_member_use_from_same_package
              color: theme.iconTheme.color,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
