import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/presenter/services/auth/auth_service.dart';
import 'package:recipe_food/app/ui/shared/widgets/text_field_custom.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;

  // Método para guardar los datos del formulario
  void _saveForm() {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final formData = _formKey.currentState!.value;
      print('Form data: $formData'); // Aquí se imprimen los datos
    } else {
      print('Form validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    // const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final authService = AuthService();

    return Scaffold(
      body: KeyboardDismissOnTap(
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 35),
                child: Column(
                  children: [
                    Assets.svgs.recipeBook.svg(
                      height: 200,
                    ),
                    const SizedBox(height: 10),
                    RichText(
                      text: TextSpan(
                          text: AppLocalizations.of(context)!.labelStartedInfo,
                          style: textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: "Recetas Deliciosas",
                              style: textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.visVis500,
                              ),
                            ),
                          ]),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    const SizedBox(height: 15),
                    TextFieldCustom(
                      name: "auth_email",
                      hintText: AppLocalizations.of(context)!.labelEmailAddress,
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
                      name: "auth_password",
                      obscureText: _obscureText,
                      hintText: AppLocalizations.of(context)!.labelPassword,
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Inicio de sesion
                          // final secureToken = secureStorage.write(
                          //     key: 'accessToken', value: "token-1245demojajajja");
                          // print("🚛 $secureToken");
                          // context.router.pushAndPopUntil(
                          //   const LayoutRoute(),
                          //   predicate: (_) => false,
                          // );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.labelSignIn,
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      children: [
                        const Positioned(
                          top: 2,
                          right: 0,
                          left: 0,
                          child: Divider(
                            color: AppColors.silver300,
                          ),
                        ),
                        Center(
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              AppLocalizations.of(context)!.labelOrContinueWith,
                              style: textTheme.bodyMedium,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            print("google");
                            await authService.signInWithGoogle();
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Assets.svgs.google.svg(
                                height: 25,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "Google",
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        // OutlinedButton(
                        //   onPressed: () {},
                        //   child: Row(
                        //     mainAxisSize: MainAxisSize.min,
                        //     children: [
                        //       Assets.svgs.facebook.svg(
                        //         height: 25,
                        //       ),
                        //       const SizedBox(width: 5),
                        //       Text(
                        //         "Facebook",
                        //         style: textTheme.bodyMedium,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.labelDontAccount,
                          style: textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            context.router.replace(const SignUpRoute());
                          },
                          child: Text(
                            AppLocalizations.of(context)!.labelSignUp,
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
    );
  }
}
