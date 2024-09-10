import 'package:auto_route/auto_route.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';

import 'package:recipe_food/app/config/router/guards/index.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        /// Ruta de inicio que verifica la autenticación
        // AutoRoute(
        //   page: AuthCheckRoute
        //       .page, // Página vacía que sirve de verificación inicial
        //   path: "/",
        //   initial: true,
        //   guards: [
        //     InitialAuthGuard(), // Verifica el estado inicial
        //   ],
        // ),
        AutoRoute(
          page: OnboardingRoute.page,
          path: "/onboarding",
        ),
        AutoRoute(
          page: SignInRoute.page,
          path: "/auth/sign-in",
        ),
        AutoRoute(
          page: SignUpRoute.page,
          path: "/auth/sign-up",
        ),
        AutoRoute(
          page: LayoutRoute.page,
          path: "/",
          guards: [
            InitialAuthGuard(), // Requiere autenticación para nevegar el home
          ],
          children: [
            AutoRoute(page: HomeRoute.page, path: ""),
            AutoRoute(
              page: HomeRoute.page,
              path: "home",
              children: [
                AutoRoute(page: RecipesForYouRoute.page, path: ""),
                AutoRoute(
                  page: RecipesForYouRoute.page,
                  path: "recipe-for-you",
                ),
                AutoRoute(
                  page: FollowingChefsRoute.page,
                  path: "recipe-for-you",
                ),
              ],
            ),
            AutoRoute(page: SearchRoute.page, path: "search"),
            AutoRoute(page: AddRecipeRoute.page, path: "add-recipe"),
            AutoRoute(page: NotificationRoute.page, path: "notification"),
            AutoRoute(
              page: ProfileRoute.page,
              path: "profile",
              children: [
                AutoRoute(
                  page: AllRecipeRoute.page,
                  path: "all-recipe-view",
                ),
                AutoRoute(
                  page: AllFavoriteRoute.page,
                  path: "all-favorite-view",
                ),
              ],
            ),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: '/'),
      ];

  // @override
  // List<AutoRouteGuard> get guards => [
  //       // optionally add root guards here
  //       AuthGuard(),
  //     ];
}
