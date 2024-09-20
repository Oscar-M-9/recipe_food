import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/new_text_field_step.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';

class Step4 extends StatefulWidget {
  const Step4({super.key});

  @override
  State<Step4> createState() => _Step4State();
}

class _Step4State extends State<Step4> {
  final List<Widget> _stepFields = [];

  int _nextStepId = 0;

  // Método para agregar un nuevo paso
  void _addStepField() {
    _nextStepId++;
    final newTextFieldName = "step_detail_$_nextStepId";
    // final newTextFieldImage = "images_${_nextStepId}";
    final newTextFieldKey = ValueKey(_nextStepId);
    setState(() {
      _stepFields.add(
        NewTextFieldStep(
          key: newTextFieldKey,
          stepName: newTextFieldName,
          // imageName: newTextFieldImage,
          onDelete: () {
            setState(() {
              _stepFields.removeWhere(
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.textInstructions,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    FormBuilderTextField(
                      name: 'step_detail',
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: CustomInput.buildInputDecoration(
                        context,
                        hintText: AppLocalizations.of(context)!.textWrite,
                        radius: 5,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Divider(
                  color: AppColors.silver800.withOpacity(0.15),
                ),
              ),
            ],
          ),

          ..._stepFields,
          // * boton para agregar mas instrucciones o pasos de la receta
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _addStepField,
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.textAddInstruction),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
