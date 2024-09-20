import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/presenter/controllers/connectivity_controller.dart';
import 'package:recipe_food/app/presenter/providers/app/notification_provider.dart';
import 'package:recipe_food/app/presenter/services/auth/auth_service.dart';
import 'package:recipe_food/app/ui/shared/widgets/custom_toast.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class ProfileSettingPage extends ConsumerStatefulWidget {
  const ProfileSettingPage({super.key});

  @override
  ProfileSettingPageState createState() => ProfileSettingPageState();
}

class ProfileSettingPageState extends ConsumerState<ProfileSettingPage> {
  late FToast fToast;
  final authService = AuthService();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  void signOut() async {
    final connectivityNotifier = ref.read(connectivityStatusProvider.notifier);
    final isConnected = await connectivityNotifier.isConnected;

    if (!isConnected && mounted) {
      _showToast(
        text: AppLocalizations.of(context)!.textNoInternetConnection,
      );
      return;
    }

    try {
      await authService.signOut();
      if (mounted) {
        context.router.replaceAll([const LayoutRoute()]);
      }
    } catch (e) {
      // Manejar el error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: AppColors.radicalRed500,
            content: Text(
              e.toString(), // Convertir a String
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuracion"),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CustomListTile(
                  leading: Assets.svgs.language.svg(
                    height: 22,
                  ),
                  title: "Lenguaje",
                  onTap: () {},
                ),
                _CustomListTile(
                  leading: Assets.svgs.palette9.svg(
                    height: 22,
                  ),
                  title: "Apariencia",
                  onTap: () {},
                ),
                _CustomListTile(
                  leading: Assets.svgs.logout.svg(
                    height: 22,
                  ),
                  title: "Logout",
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Cerrar sesion"),
                          content: Text("esta seguro en cerrar sesion?"),
                          actions: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.maybePop(context);
                                    },
                                    child: Text("cancetar"),
                                  ),
                                ),
                                Expanded(
                                  child: MaterialButton(
                                    color: AppColors.radicalRed400,
                                    onPressed: signOut,
                                    child: Text("cerrar Sesion"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    "OTROS",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: AppColors.silver950.withOpacity(0.4),
                        ),
                  ),
                ),
                _CustomListTile(
                  leading: Assets.svgs.secureShieldPasswordProtectSafe.svg(
                    height: 22,
                  ),
                  title: "Politica de privacidad",
                  onTap: () {},
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final notificationsEnabled =
                        ref.watch(notificationProvider);
                    return Icon(
                      notificationsEnabled
                          ? Icons.notifications_active
                          : Icons.notifications_off,
                      size: 48,
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({
    required this.title,
    this.leading,
    this.onTap,
  });

  final String title;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right_rounded,
      ),
    );
  }
}
