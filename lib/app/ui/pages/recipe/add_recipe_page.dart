import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';

import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/custom_list_title.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/new_text_field_ingredient.dart';
import 'package:recipe_food/app/ui/pages/recipe/widgets/new_text_field_step.dart';
import 'package:recipe_food/app/ui/shared/inputs/custom_input.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  // Lista para controlar los campos dinámicos
  final List<Widget> _ingredientFields = [];
  final List<Widget> _stepFields = [];
  // Para asegurar que cada campo tiene un identificador único
  int _nextIngredientId = 0;
  int _nextStepId = 1;

  String savedValue = '';
  // Map<int, List<XFile>> _stepImages = {};

  // Método para agregar un nuevo campo de ingrediente
  void _addIngredientField() {
    final newTextFieldName = "ingredient_name_${_nextIngredientId++}";
    final newTextFieldQuantity = "ingredient_quantity_${_nextIngredientId++}";
    final newTextFieldKey = ValueKey(_nextIngredientId);
    setState(() {
      _ingredientFields.add(
        NewTextFieldIngredient(
          key: newTextFieldKey,
          ingredientName: newTextFieldName,
          ingredientQuantity: newTextFieldQuantity,
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

  // Método para agregar un nuevo paso
  void _addStepField() {
    final newTextFieldName = "step_detail_${_nextStepId++}";
    // final newTextFieldImage = "images_${_nextStepId++}";
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

  // Método para guardar los datos del formulario
  void _saveForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      print('Form data: $formData'); // Aquí se imprimen los datos
    } else {
      print('Form validation failed');
    }
  }

  late final TextEditingController _cookTimeController;
  late final TextEditingController _serveController;

  @override
  void initState() {
    _cookTimeController = TextEditingController(text: "00");
    _serveController = TextEditingController(text: "0");
    savedValue = _formKey.currentState?.value.toString() ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _cookTimeController.dispose();
    _serveController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: KeyboardDismissOnTap(
        child: ExtendedNestedScrollView(
          pinnedHeaderSliverHeightBuilder: () =>
              MediaQuery.of(context).padding.top + kToolbarHeight,
          onlyOneScrollInBody: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar.medium(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Create Recipe"),
                ),
              )
            ];
          },
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: FormBuilder(
                  key: _formKey,
                  // IMPORTANT to remove all references from dynamic field when delete
                  clearValueOnUnregister: true,
                  onChanged: () {
                    _formKey.currentState!.save();
                    debugPrint(_formKey.currentState!.value.toString());
                  },
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                  autovalidateMode: AutovalidateMode.disabled,
                  skipDisabled: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        // !! imagen de la receta
                        Stack(
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                minHeight: 200,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.silver500.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Assets.images.placeholderImage.image(
                                    width: 70,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 2,
                              right: 2,
                              child: IconButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(theme.cardColor),
                                ),
                                icon: Assets.svgs.edit2.svg(
                                  width: 20,
                                  color: AppColors.visVis500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        //!! titulo y detallle descripcion de la receta
                        FormBuilderTextField(
                          name: "title",
                          keyboardType: TextInputType.text,
                          maxLines: 1,
                          decoration: CustomInput.buildInputDecoration(
                            context,
                            hintText: "Titulo",
                            radius: 8,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                          ]),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: CustomInput.buildInputDecoration(
                            context,
                            hintText: "Descripcion",
                            radius: 8,
                          ),
                          validator: FormBuilderValidators.compose([]),
                        ),
                        const SizedBox(height: 12),
                        // !! servers y cook time , dificultad de la receta
                        // Servings y Cook Time
                        CustomListTitle(
                          title: 'Serves',
                          subtitle: _serveController.text,
                          leading: Assets.svgs.serve.svg(
                            height: 20,
                            color: theme.iconTheme.color,
                          ),
                          trailing: FormBuilderTextField(
                            name: 'Serves',
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
                          title: 'Cook time',
                          subtitle: '${_cookTimeController.text} min',
                          trailing: FormBuilderTextField(
                            name: 'Cook time',
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
                                "Dificultad",
                                style: theme.textTheme.titleMedium,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width - 60),
                                child: FormBuilderChoiceChip<String>(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    labelText:
                                        'seleccione el tipo de dificutad de la receta ',
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                  ),
                                  name: 'difficulty_choice',
                                  initialValue: 'Facil',
                                  spacing: 15,
                                  runSpacing: 10,
                                  options: [
                                    FormBuilderChipOption(
                                      value: 'Facil',
                                      avatar: Assets.svgs.foodEasy.svg(
                                        color: AppColors.silver900
                                            .withOpacity(0.75),
                                      ),
                                    ),
                                    FormBuilderChipOption(
                                      value: 'medio',
                                      avatar: Assets.svgs.foodMedium.svg(
                                        color: AppColors.silver900
                                            .withOpacity(0.75),
                                      ),
                                    ),
                                    FormBuilderChipOption(
                                      value: 'dificil',
                                      avatar: Assets.svgs.foodHard.svg(
                                        color: AppColors.silver900
                                            .withOpacity(0.75),
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

                        // !! Ingredientes de la receta
                        // Ingredientes
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ingredients',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

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
                                  hintText: "Ingredient Name",
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
                                  hintText: "Quantity",
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
                              'Add Ingredient',
                            ),
                          ),
                        ),

                        // !! Pasos(Instrucciones) de la receta
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pasos",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Intruccion',
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: [
                                  FormBuilderTextField(
                                    name: 'step_detail',
                                    maxLines: null,
                                    keyboardType: TextInputType.text,
                                    decoration:
                                        CustomInput.buildInputDecoration(
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
                                  //   name: "images",
                                  //   decoration:
                                  //       CustomInput.buildInputDecoration(
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
                                  //             padding:
                                  //                 EdgeInsets.only(left: 8.0),
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
                        ),

                        ..._stepFields,
                        // * boton para agregar mas instrucciones o pasos de la receta
                        const SizedBox(height: 5),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton.icon(
                            onPressed: _addStepField,
                            icon: Icon(Icons.add),
                            label: Text('Agregar intruccion'),
                          ),
                        ),
                        SizedBox(height: 20),

                        // !! Boton de guardar el formmulario de la nueva receta
                        ElevatedButton(
                          onPressed: _saveForm,
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: Text(
                            'PUBLICAR RECETA',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
