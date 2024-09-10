import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/presenter/controllers/connectivity_controller.dart';
import 'package:recipe_food/app/presenter/services/auth/auth_service.dart';
import 'package:recipe_food/app/ui/shared/widgets/custom_toast.dart';
import 'package:recipe_food/app/ui/shared/widgets/text_field_custom.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;
  final _authService = AuthService();
  final String _nameNameUser = "name_user";
  final String _nameEmail = "email";
  final String _namePassword = "password";
  final String _nameAcceptTerms = "accept-terms";
  bool _isLoading = false;

  late FToast fToast;

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  // Método para guardar los datos del formulario
  void _saveForm() async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);

    bool isConnected = await connectivityNotifier.isConnected;
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      if (!isConnected && mounted) {
        _showToast(
            text: AppLocalizations.of(context)!.textNoInternetConnection);
      } else {
        setState(() {
          _isLoading = true;
        });
        final formData = _formKey.currentState!.value;
        print('Form data: $formData'); // Aquí se imprimen los datos
        final String email = formData[_nameEmail];
        final String password = formData[_namePassword];
        final String nameUser = formData[_nameNameUser];
        final bool acceptTerms = formData[_nameAcceptTerms];
        final bool isEmailTaken = await _authService.isEmailTaken(email);
        print("🛺 $isEmailTaken");
        setState(() {
          _isLoading = false;
        });
        if (isEmailTaken) {
          // mostar una alerta de correo existe
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.radicalRed500,
                content: Text(
                  AppLocalizations.of(context)!.textAlreadyHaveAccountSignIn,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            );
          }
        } else {
          await _authService.signUpWithEmail(
            email,
            password,
            nameUser,
            acceptTerms,
          );
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.jade500,
                content: Text(
                  AppLocalizations.of(context)!.textAlreadyHaveAccountSignIn,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            );
            context.router.pushAndPopUntil(
              const LayoutRoute(),
              predicate: (route) => false,
            );
          }
        }
      }
    }
  }

  _showToast({required String text}) {
    Widget toast = CustomToast(text: text);

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Container(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 450,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
                  child: Column(
                    children: [
                      Assets.svgs.recipeBook.svg(
                        height: 150,
                      ),
                      const SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                            text:
                                AppLocalizations.of(context)!.labelStartedInfo,
                            style: textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: AppLocalizations.of(context)!.titleApp,
                                style: textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.visVis500,
                                ),
                              ),
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      TextFieldCustom(
                        name: _nameNameUser,
                        hintText: AppLocalizations.of(context)!.labelFullName,
                        prefixIcon: Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Assets.svgs.iconProfile.svg(width: 25),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.username(
                            allowSpace: true,
                          ),
                          // FormBuilderValidators.match(
                          //   RegExp(
                          //     r'^[a-zA-ZáéíóúÁÉÍÓÚ0-9]+$',
                          //   ),
                          // ),
                        ]),
                      ),
                      const SizedBox(height: 15),
                      TextFieldCustom(
                        name: _nameEmail,
                        hintText:
                            AppLocalizations.of(context)?.labelEmailAddress,
                        prefixIcon: Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Assets.svgs.email.svg(width: 25),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                        ]),
                      ),
                      const SizedBox(height: 15),
                      TextFieldCustom(
                        name: _namePassword,
                        obscureText: _obscureText,
                        hintText: AppLocalizations.of(context)?.labelPassword,
                        prefixIcon: Container(
                          width: 40,
                          alignment: Alignment.center,
                          child: Assets.svgs.password.svg(width: 25),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: _obscureText
                              ? Assets.svgs.eye.svg(
                                  height: 25,
                                )
                              : Assets.svgs.eyeClosed.svg(
                                  height: 25,
                                ),
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.password(),
                        ]),
                      ),
                      FormBuilderCheckbox(
                        name: _nameAcceptTerms,
                        title: Text(
                          AppLocalizations.of(context)!.labelAcceptTerms,
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.visVis600,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.isTrue(
                            errorText: AppLocalizations.of(context)!
                                .textYouAcceptTerms,
                          ),
                        ]),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveForm,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _isLoading
                                  ? Container(
                                      height: 22,
                                      width: 22,
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      child: const CircularProgressIndicator(
                                        backgroundColor: AppColors.silver100,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const SizedBox(),
                              Text(
                                AppLocalizations.of(context)!.labelContinue,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.labelAlreadyAccount,
                            style: textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () {
                              context.router.replace(const SignInRoute());
                            },
                            child: Text(
                              AppLocalizations.of(context)!.labelSignIn,
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.visVis500,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
