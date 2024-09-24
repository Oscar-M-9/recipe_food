import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/infra/models/recipe/categories/categorie_model.dart';
import 'package:recipe_food/app/infra/models/recipe/ingredients/ingredient_model.dart';
import 'package:recipe_food/app/infra/models/recipe/preparation_steps/preparation_step_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_image/recipe_image_model.dart';
import 'package:recipe_food/app/infra/models/recipe/recipe_model.dart';
import 'package:recipe_food/app/presenter/providers/app/profile/user_notifier.dart';
import 'package:recipe_food/app/presenter/services/recipe/add_recipe_service.dart';
import 'package:recipe_food/app/ui/pages/recipe/steps/step_1.dart';
import 'package:recipe_food/app/ui/pages/recipe/steps/step_2.dart';
import 'package:recipe_food/app/ui/pages/recipe/steps/step_3.dart';
import 'package:recipe_food/app/ui/pages/recipe/steps/step_4.dart';

@RoutePage()
class RecipeFormPage extends ConsumerStatefulWidget {
  const RecipeFormPage({super.key});

  @override
  RecipeFormPageState createState() => RecipeFormPageState();
}

class RecipeFormPageState extends ConsumerState<RecipeFormPage> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormBuilderState>();

  void _onStepContinue() {
    if (!_validateCurrentStep()) return;

    if (_currentStep < 3) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _saveRecipe();
    }
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _validateField(
          'images',
          AppLocalizations.of(context)!.textPleaseUploadAtLeastOneImage,
        );
      case 1:
        return _validateField(
              'title',
              AppLocalizations.of(context)!.textCompleteTheTitle,
            ) &&
            _validateField(
              'short_description',
              AppLocalizations.of(context)!.textCompleteTheDescription,
            ) &&
            _validateField('serves', "errorMessage") &&
            _validateField('cook_time', "errorMessage") &&
            _validateField('difficulty_choice', "errorMessage") &&
            _validateField('category', "errorMessage");
      case 2:
        return _validateField('ingredient_name', "errorMessage") &&
            _validateField('ingredient_quantity', "errorMessage") &&
            _validateDynamicFields('ingredient_name_', 'ingredient_quantity_',
                "Añade los ingredientes");
      case 3:
        return _validateField('step_detail', "errorMessage") &&
            _validateDynamicFields(
                'step_detail_', null, 'Completa los pasos de la receta.');
      default:
        return false;
    }
  }

  bool _validateField(String fieldName, String errorMessage) {
    final formState = _formKey.currentState!;
    final isValid = formState.fields[fieldName]?.validate() ?? false;
    // if (!isValid) _showErrorSnackBar(errorMessage);
    return isValid;
  }

  bool _validateDynamicFields(
      String baseName, String? baseQuantity, String errorMessage) {
    final formState = _formKey.currentState!;
    bool allValid = true;

    // Buscar todos los campos que coincidan con la base del nombre
    final dynamicNameFields =
        formState.fields.keys.where((key) => key.startsWith(baseName)).toList();

    final dynamicQuantityFields = baseQuantity != null
        ? formState.fields.keys
            .where((key) => key.startsWith(baseQuantity))
            .toList()
        : [];

    // Si no hay campos dinámicos, puedes decidir si permitir la validación o no
    if (dynamicNameFields.isEmpty && dynamicQuantityFields.isEmpty) {
      // Si es necesario que haya al menos un campo dinámico, muestra el error
      // _showErrorSnackBar(errorMessage);
      return true; // Puedes cambiar esto a `false` si quieres obligar al menos un campo.
    }

    // Validar los campos de nombre dinámicos
    for (var nameField in dynamicNameFields) {
      bool isValidName = formState.fields[nameField]?.validate() ?? false;
      if (!isValidName) {
        allValid = false;
      }
    }

    // Validar los campos de cantidad dinámicos si existen
    if (baseQuantity != null) {
      for (var quantityField in dynamicQuantityFields) {
        bool isValidQuantity =
            formState.fields[quantityField]?.validate() ?? false;
        if (!isValidQuantity) {
          allValid = false;
        }
      }
    }

    return allValid;
  }

  // void _showErrorSnackBar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message)),
  //   );
  // }

  // Método para guardar los datos del formulario
  void _saveRecipe() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;

      // Listas para almacenar ingredientes y pasos válidos
      List<Map<String, dynamic>> ingredientsDynamics = [];
      List<String> steps = [];
      final formState = _formKey.currentState!;
      // Buscar todos los campos que coincidan con la base del nombre
      final dynamicNameFields = formState.fields.keys
          .where((key) => key.startsWith("ingredient_name_"))
          .toList();

      final dynamicQuantityFields = formState.fields.keys
          .where((key) => key.startsWith("ingredient_quantity_"))
          .toList();
      // Iterar sobre los campos de nombre de ingredientes válidos
      for (int i = 0; i < dynamicNameFields.length; i++) {
        final ingredientNameKey = dynamicNameFields[i];
        final ingredientQuantityKey = dynamicQuantityFields[i];

        // Obtener los valores del formulario
        final ingredientName = formState.value[ingredientNameKey];
        final ingredientQuantity = formState.value[ingredientQuantityKey];

        // Agregar el ingrediente a la lista si ambos campos no están vacíos
        if (ingredientName != null &&
            ingredientName != '' &&
            ingredientQuantity != null &&
            ingredientQuantity != '') {
          ingredientsDynamics.add({
            'name': ingredientName,
            'quantity': ingredientQuantity,
          });
        }
      }
      // Buscar todos los campos que coincidan con la base del nombre de los pasos
      final dynamicStepFields = formState.fields.keys
          .where((key) => key.startsWith("step_detail_"))
          .toList();

      // Iterar sobre los campos de pasos válidos
      for (var stepField in dynamicStepFields) {
        // Obtener el valor del formulario
        final stepDetail = formState.value[stepField];

        // Agregar el paso a la lista si no está vacío
        if (stepDetail != null && stepDetail != '') {
          steps.add(stepDetail);
        }
      }

      final user = ref.watch(userProvider);
      final recipe = RecipeModel(
        calories: null,
        categorie_id: formData['category'],
        cooking_time: int.parse(formData['cook_time']),
        difficulty: int.parse(formData['difficulty_choice']),
        servings: int.parse(formData['serves']),
        short_description: formData['short_description'],
        title: formData['title'],
        user_id: user!.id,
      );
      final categorie = CategorieModel(
        id: formData['category'],
      );
      // Ingredientes
      List<IngredientModel> ingredient = [];
      ingredient.add(IngredientModel(
        name: formData['ingredient_name'],
        quantity: formData['ingredient_quantity'],
      ));
      if (ingredientsDynamics.isNotEmpty) {
        ingredientsDynamics.map((item) {
          return ingredient.add(IngredientModel(
            name: item['name'],
            quantity: item['quantity'],
          ));
        });
      }
      // Pasos de preparacion
      List<PreparationStepModel> preparationSteps = [];
      preparationSteps.add(PreparationStepModel(
        step_detail: formData['step_detail'],
        step_number: 1,
      ));
      // en el modelo PreparationStepModel tambien quiero guardar el numero de paso siguiente
      if (steps.isNotEmpty) {
        steps.asMap().forEach((index, value) {
          preparationSteps.add(PreparationStepModel(
            step_detail: value,
            step_number: index + 2,
          ));
        });
      }
      // imagenes de la receta
      final imagesForm = formData['images'];
      List<RecipeImageModel> images = [];

      for (var image in imagesForm) {
        images.add(RecipeImageModel(
          image_url: image.path,
        ));
      }

      AddRecipeService().addRecipe(
        images: images,
        recipe: recipe,
        categorie: categorie,
        ingredients: ingredient,
        steps: preparationSteps,
      );
      // Retroceder a la pantalla anterior
      if (mounted) Navigator.pop(context);
    } else {
      if (kDebugMode) debugPrint('Form validation failed');
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.textCreateRecipe,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: KeyboardDismissOnTap(
        child: FormBuilder(
          key: _formKey,
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: _onStepContinue,
            onStepCancel: _onStepCancel,
            steps: [
              // Paso 1: Subir imagen
              Step(
                title: Text(AppLocalizations.of(context)!.textRecipeImages),
                content: const Step1(),
                isActive: _currentStep >= 0,
              ),

              // Paso 2: Título y Descripción
              Step(
                title: Text(AppLocalizations.of(context)!.textRecipeDetails),
                content: const Step2(),
                isActive: _currentStep >= 1,
              ),

              // Paso 3: Ingredientes
              Step(
                title: Text(AppLocalizations.of(context)!.textIngredients),
                content: const Step3(),
                isActive: _currentStep >= 2,
              ),

              // Paso 4: Pasos
              Step(
                title: Text(
                  AppLocalizations.of(context)!.textStepsToPrepareTheRecipe,
                ),
                content: const Step4(),
                isActive: _currentStep >= 3,
              ),
            ],
            controlsBuilder:
                (BuildContext context, ControlsDetails controlsDetails) {
              // En el último paso mostramos el botón de Guardar
              final isLastStep = _currentStep == 3;

              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Muestra "Continuar" si no es el último paso
                    if (!isLastStep)
                      _CustomButtonContinue(
                        onPressed: controlsDetails.onStepContinue,
                        text: AppLocalizations.of(context)!.labelContinue,
                      ),
                    // Muestra "Guardar" en el último paso
                    if (isLastStep)
                      _CustomButtonContinue(
                        onPressed: controlsDetails.onStepContinue,
                        text: AppLocalizations.of(context)!.textSaveRecipe,
                      ),
                    // Muestra "Cancelar" si no es el primer paso
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: controlsDetails.onStepCancel,
                        child: Text(
                          AppLocalizations.of(context)!.textBack,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CustomButtonContinue extends StatelessWidget {
  const _CustomButtonContinue({
    required this.onPressed,
    required this.text,
  });

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MaterialButton(
      color: AppColors.jade500,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 10,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
