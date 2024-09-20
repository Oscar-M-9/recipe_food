// ignore_for_file: deprecated_member_use_from_same_package

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/category_dropdown_field.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/custom_list_title.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> {
  late final TextEditingController _cookTimeController;
  late final TextEditingController _serveController;

  @override
  void initState() {
    _cookTimeController = TextEditingController(text: "00");
    _serveController = TextEditingController(text: "0");
    super.initState();
  }

  @override
  void dispose() {
    _cookTimeController.dispose();
    _serveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          FormBuilderTextField(
            name: "title",
            keyboardType: TextInputType.text,
            maxLines: 1,
            decoration: CustomInput.buildInputDecoration(
              context,
              hintText: AppLocalizations.of(context)!.textTitle,
              labelText: AppLocalizations.of(context)!.textTitle,
              radius: 8,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(height: 10),
          FormBuilderTextField(
            name: "short_description",
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: CustomInput.buildInputDecoration(
              context,
              hintText: AppLocalizations.of(context)!.textDescription,
              labelText: AppLocalizations.of(context)!.textDescription,
              radius: 8,
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
            ]),
          ),
          const SizedBox(height: 12),
          // !! servers y cook time , dificultad de la receta
          // Servings y Cook Time
          CustomListTitle(
            title: AppLocalizations.of(context)!.textServings,
            subtitle: _serveController.text,
            leading: Assets.svgs.serve.svg(
              height: 20,
              color: theme.iconTheme.color,
            ),
            trailing: FormBuilderTextField(
              name: 'serves',
              onChanged: (value) {
                setState(() {
                  if (value != "") {
                    _serveController.text = value!;
                  } else {
                    _serveController.text = "0";
                  }
                });
              },
              decoration: CustomInput.buildInputDecoration(
                context,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                radius: 5,
              ),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(1),
              ]),
            ),
          ),
          const SizedBox(height: 10),

          CustomListTitle(
            leading: Assets.svgs.timer.svg(
              height: 20,
            ),
            title: AppLocalizations.of(context)!.textCookingTime,
            subtitle: '${_cookTimeController.text} min',
            trailing: FormBuilderTextField(
              name: 'cook_time',
              onChanged: (value) {
                setState(() {
                  if (value != "") {
                    _cookTimeController.text = value!;
                  } else {
                    _cookTimeController.text = "0";
                  }
                });
              },
              decoration: CustomInput.buildInputDecoration(
                context,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                radius: 5,
              ),
              keyboardType: TextInputType.number,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.numeric(),
                FormBuilderValidators.min(1),
              ]),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Text(
                  AppLocalizations.of(context)!.textDifficulty,
                  style: theme.textTheme.titleMedium,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 60),
                  child: FormBuilderChoiceChip<String>(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    selectedColor: AppColors.visVis600.withOpacity(0.35),
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!
                          .textSelectTypeDifficulty,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    name: 'difficulty_choice',
                    initialValue: "1",
                    spacing: 15,
                    runSpacing: 10,
                    options: [
                      FormBuilderChipOption(
                        value: "1",
                        avatar: Assets.svgs.foodEasy.svg(
                          color: AppColors.silver900.withOpacity(0.75),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.textDifficultyEasy,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      FormBuilderChipOption(
                        value: "2",
                        avatar: Assets.svgs.foodMedium.svg(
                          color: AppColors.silver900.withOpacity(0.75),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.textDifficultyMedium,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      FormBuilderChipOption(
                        value: "3",
                        avatar: Assets.svgs.foodHard.svg(
                          color: AppColors.silver900.withOpacity(0.75),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.textDifficultyHard,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                    onChanged: (val) => debugPrint(
                      val.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // !! categoria
          const CategoryDropdownField(),
        ],
      ),
    );
  }
}
