import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/new_text_field_ingredient.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';

class Step3 extends StatefulWidget {
  const Step3({super.key});

  @override
  State<Step3> createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  final List<Widget> _ingredientFields = [];
  int _nextIngredientId = 0;

  // Método para agregar un nuevo campo de ingrediente
  void _addIngredientField() {
    _nextIngredientId++;
    final newTextFieldKey = ValueKey(_nextIngredientId);
    setState(() {
      _ingredientFields.add(
        NewTextFieldIngredient(
          key: newTextFieldKey,
          ingredientName: "ingredient_name_$_nextIngredientId",
          ingredientQuantity: "ingredient_quantity_$_nextIngredientId",
          onDelete: () {
            setState(() {
              _ingredientFields.removeWhere(
                (element) => element.key == newTextFieldKey,
              );
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          //* Mostrar campos dinámicos para los ingredientes

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Campo para el nombre del ingrediente
              Expanded(
                child: FormBuilderTextField(
                  name: 'ingredient_name',
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
                  name: 'ingredient_quantity',
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
            ],
          ),

          ..._ingredientFields,

          const SizedBox(height: 5),
          //* Botón para agregar un nuevo campo en los ingredientes
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _addIngredientField,
              icon: const Icon(Icons.add),
              label: Text(
                AppLocalizations.of(context)!.textAddIngredient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
