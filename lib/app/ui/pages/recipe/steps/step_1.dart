import 'package:flutter/material.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';

class Step1 extends StatelessWidget {
  const Step1({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          FormBuilderFilePicker(
            name: "images",
            decoration: CustomInput.buildInputDecoration(
              context,
              labelText: AppLocalizations.of(context)!.textRecipeImages,
              radius: 10,
              fillColor: AppColors.silver400.withOpacity(0.1),
            ),
            maxFiles: 5,
            previewImages: true,
            allowMultiple: true,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.maxLength(5),
              FormBuilderValidators.minLength(1),
              FormBuilderValidators.required(),
            ]),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onChanged: (val) => debugPrint(val.toString()),
            typeSelectors: [
              TypeSelector(
                type: FileType.image,
                selector: Row(
                  children: <Widget>[
                    const Icon(Icons.add_circle),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        AppLocalizations.of(context)!.textAddImages,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            customTypeViewerBuilder: (children) => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: children,
            ),
            onFileLoading: (val) {
              debugPrint(val.toString());
            },
            customFileViewerBuilder: null,
          ),
        ],
      ),
    );
  }
}
