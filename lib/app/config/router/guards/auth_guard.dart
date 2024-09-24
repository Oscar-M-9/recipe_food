import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGuard extends AutoRouteGuard {
  final Box hiveBox = Hive.box('setting');

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final bool isOnboarding = hiveBox.get("onboarding") ?? true;

    if (connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.ethernet ||
        connectivityResult.first == ConnectivityResult.wifi) {
      final SupabaseClient supabase = SupabaseManager().client;

      final session = supabase.auth.currentSession;

      if (session != null && session.accessToken != '') {
        debugPrint("🎇 Token válido, redirigiendo...");
        FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
          debugPrint("🚨 fcmToken Refresh: $fcmToken");
        });
        resolver.next(true); // Token válido, continuar a la siguiente pantalla
      } else {
        if (isOnboarding) {
          debugPrint("🎆 No hay token, redirigiendo a Onboarding");
          router.replaceAll([const OnboardingRoute()]);
        } else {
          debugPrint("🎆 Usuario no autenticado o sesión cerrada");
          router.replaceAll([const SignInRoute()]);
        }
      }
    } else {
      debugPrint(
          "🚫 No hay conexión a Internet, redirigiendo a página de error");
      router.replaceAll([const NotFoundRoute()]);
    }
  }
}
