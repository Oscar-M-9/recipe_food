import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/gen/assets.gen.dart';

class NewTextFieldStep extends StatelessWidget {
  const NewTextFieldStep({
    super.key,
    this.onDelete,
    // required this.imageName,
    required this.stepName,
  });

  // final String imageName;
  final VoidCallback? onDelete;
  final String stepName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      // key: ValueKey("step-$fieldId"),
      children: [
        Row(
          children: [
            Text(
              'Instrucción',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: Assets.svgs.removeSquare.svg(
                height: 20,
                color: theme.iconTheme.color,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              FormBuilderTextField(
                name: stepName,
                maxLines: null,
                keyboardType: TextInputType.text,
                decoration: CustomInput.buildInputDecoration(
                  context,
                  hintText: "Escribir",
                  radius: 5,
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              // const SizedBox(height: 15),
              // FormBuilderFilePicker(
              //   name: imageName,
              //   decoration: CustomInput.buildInputDecoration(
              //     context,
              //     labelText: "Imagenes (opcional)",
              //   ),
              //   maxFiles: 3,
              //   previewImages: true,
              //   onChanged: (val) => print(val),
              //   typeSelectors: const [
              //     TypeSelector(
              //       type: FileType.image,
              //       selector: Row(
              //         children: <Widget>[
              //           Icon(Icons.add_circle),
              //           Padding(
              //             padding: EdgeInsets.only(left: 8.0),
              //             child: Text("Add documents"),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              //   onFileLoading: (val) {
              //     print(val);
              //   },
              // ),
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
    );
  }
}
