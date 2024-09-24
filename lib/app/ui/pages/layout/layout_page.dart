import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/presenter/controllers/connectivity_controller.dart';
import 'package:recipe_food/app/presenter/controllers/notification/notification_permission.dart';
import 'package:recipe_food/app/presenter/providers/app/profile/user_notifier.dart';
import 'package:recipe_food/app/ui/pages/recipe/recipe_form_page.dart';
import 'package:recipe_food/gen/assets.gen.dart';
import 'package:recipe_food/app/config/app_colors.dart';

@RoutePage()
class LayoutPage extends ConsumerStatefulWidget {
  const LayoutPage({super.key});

  @override
  LayoutPageState createState() => LayoutPageState();
}

class LayoutPageState extends ConsumerState<LayoutPage> {
  final autoSizeGroup = AutoSizeGroup();
  // int _bottomNavIndex = 0; // Default index

  final iconListBottom = [
    Assets.svgs.iconHome,
    Assets.svgs.iconSearch,
    // Assets.svgs.iconChatDots,
    Assets.svgs.notification,
    Assets.svgs.iconProfile,
  ];

  final iconListBottomFill = [
    Assets.svgs.iconHomeFill,
    Assets.svgs.iconSearchAlt,
    // Assets.svgs.iconChatDotsFill,
    Assets.svgs.notificationFill,
    Assets.svgs.iconProfileFill,
  ];
  final List<PageRouteInfo<dynamic>> _routes = const [
    HomeRoute(),
    SearchRoute(),
    NotificationRoute(),
    ProfileRoute(),
  ];

  @override
  void initState() {
    // Cargamos los datos del usuario solo la primera vez
    ref.read(userProvider.notifier).loadUserData();
    verifyPermissions();
    super.initState();
  }

  void verifyPermissions() async {
    await requestNotificationPermission(); // Solicitar el permiso aquí
    ref.read(notificationPermission.notifier).requestPermissions();
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      // Solicitar permiso si no ha sido otorgado
      await Permission.notification.request();
    }
    if (await Permission.photos.isDenied) {
      await Permission.photos.request();
    }
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconListName = [
      AppLocalizations.of(context)!.labelHome,
      AppLocalizations.of(context)!.labelSearch,
      AppLocalizations.of(context)!.labelNotifications,
      AppLocalizations.of(context)!.labelProfile,
    ];

    // Escucha los cambios en el estado de la conectividad
    final connectivityResult = ref.watch(connectivityStatusProvider);
    print("🚗 $connectivityResult");
    // ref.watch(firebaseMessagingServiceProvider);

    return AutoTabsScaffold(
      routes: _routes,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => const AddRecipePage(),
              builder: (context) => const RecipeFormPage(),
            ),
          );
          // context.router.push(AddRecipeRoute());
        },
        backgroundColor: AppColors.visVis500,
        tooltip: 'Chef',
        shape: const CircleBorder(),
        child: Assets.svgs.chefHat.svg(
          color: Colors.white,
          width: 28,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
      bottomNavigationBuilder: (context, tabsRouter) {
        return ClipRRect(
          borderRadius: const BorderRadiusDirectional.only(
            topEnd: Radius.circular(15),
            topStart: Radius.circular(15),
          ),
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            shape: const CircularNotchedRectangle(),
            color: theme.bottomNavigationBarTheme.backgroundColor,
            notchMargin: 9,
            padding: EdgeInsets.zero,
            elevation: 8,
            shadowColor: theme.shadowColor.withOpacity(0.8),
            child: Row(
              children: _buildItems(
                itemCount: iconListBottom.length,
                theme: theme,
                iconListName: iconListName,
                activeIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildItems({
    required int itemCount,
    required ThemeData theme,
    required List<String> iconListName,
    required int activeIndex,
    required Function(int) onTap,
  }) {
    const double gapWidth = 72.0;
    final items = <Widget>[];

    for (var i = 0; i < itemCount; i++) {
      final isActive = i == activeIndex;
      final color = isActive
          ? theme.bottomNavigationBarTheme.selectedItemColor
          : theme.bottomNavigationBarTheme.unselectedItemColor;

      if (i == itemCount / 2) {
        items.add(const SizedBox(width: gapWidth));
      }

      items.add(
        Expanded(
          child: SizedBox.expand(
            child: InkWell(
              onTap: () => onTap(i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (isActive ? iconListBottomFill[i] : iconListBottom[i]).svg(
                    height: 20,
                    color: color,
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: AutoSizeText(
                      iconListName[i],
                      maxLines: 1,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                      group: autoSizeGroup,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }
}

// class NotchedAndRoundedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final path = Path();
//     const notchRadius = 38.0; // Radio del notch para el FAB
//     const radius = 15.0; // Radio de los bordes redondeados
//     const notchCornerRadius = 10.0; // Radio de las esquinas del notch

//     // Mueve a la esquina superior izquierda
//     path.moveTo(0, radius);

//     // Borde superior izquierdo redondeado
//     path.quadraticBezierTo(0, 0, radius, 0);

//     // Línea horizontal hasta el inicio de la esquina del notch
//     path.lineTo((size.width / 2) - notchRadius - notchCornerRadius, 0);

//     // Esquina redondeada del notch
//     path.quadraticBezierTo(
//       (size.width / 2) - notchRadius,
//       0,
//       (size.width / 2) - notchRadius,
//       notchCornerRadius,
//     );

//     // Curva del notch para el FAB
//     path.arcToPoint(
//       Offset((size.width / 2) + notchRadius, notchCornerRadius),
//       radius: const Radius.circular(notchRadius),
//       clockwise: false,
//     );

//     // Esquina redondeada del notch
//     path.quadraticBezierTo(
//       (size.width / 2) + notchRadius,
//       0,
//       (size.width / 2) + notchRadius + notchCornerRadius,
//       0,
//     );

//     // Línea horizontal después del notch hasta el borde superior derecho
//     path.lineTo(size.width - radius, 0);

//     // Borde superior derecho redondeado
//     path.quadraticBezierTo(size.width, 0, size.width, radius);

//     // Línea vertical hasta el borde inferior derecho
//     path.lineTo(size.width, size.height);

//     // Línea horizontal hasta el borde inferior izquierdo
//     path.lineTo(0, size.height);

//     // Cierra el path
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
// }
