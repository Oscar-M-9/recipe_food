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
class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  SignInPageState createState() => SignInPageState();
}

class SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _obscureText = true;
  final _authService = AuthService();
  final String _nameEmail = "auth_email";
  final String _namePassword = "auth_password";
  bool _isLoading = false;
  bool _isLoadingGoogle = false;

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.radicalRed500,
            content: Text(
              AppLocalizations.of(context)!.textNoInternetConnection,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        );
        // _showToast(
        //     text: AppLocalizations.of(context)!.textNoInternetConnection);
      } else {
        setState(() {
          _isLoading = true;
        });
        final formData = _formKey.currentState!.value;
        final String email = formData[_nameEmail];
        final String password = formData[_namePassword];
        final response = await _authService.signInWithEmail(email, password);
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          if (response != null) {
            context.router.replaceAll([const LayoutRoute()]);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.radicalRed500,
                content: Text(
                  AppLocalizations.of(context)!.textErrorLogging,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
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

  void _signInGoogle() async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);

    bool isConnected = await connectivityNotifier.isConnected;
    if (!isConnected && mounted) {
      // _showToast(text: AppLocalizations.of(context)!.textNoInternetConnection);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.radicalRed500,
          content: Text(
            AppLocalizations.of(context)!.textNoInternetConnection,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    } else {
      setState(() {
        _isLoadingGoogle = true;
      });
      final response = await _authService.signInWithGoogle();
      setState(() {
        _isLoadingGoogle = false;
      });
      if (mounted) {
        if (response != null) {
          context.router.replaceAll([const LayoutRoute()]);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.radicalRed500,
              content: Text(
                AppLocalizations.of(context)!.textSorrySignInGoogle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: KeyboardDismissOnTap(
        child: Center(
          child: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              child: Container(
                alignment: Alignment.center,
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
                            text:
                                AppLocalizations.of(context)!.labelStartedInfo,
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
                        name: _nameEmail,
                        hintText:
                            AppLocalizations.of(context)!.labelEmailAddress,
                        keyboardType: TextInputType.emailAddress,
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
                        ]),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveForm,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (_isLoading)
                                Container(
                                  height: 22,
                                  width: 22,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  child: const CircularProgressIndicator(
                                    backgroundColor: Colors.transparent,
                                    color: Colors.white,
                                  ),
                                ),
                              Text(
                                AppLocalizations.of(context)!.labelSignIn,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .labelOrContinueWith,
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
                            onPressed: _isLoadingGoogle ? null : _signInGoogle,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Assets.svgs.google.svg(
                                  height: 25,
                                ),
                                const SizedBox(width: 15),
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
      ),
    );
  }
}
