import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
      final token = session?.accessToken;

      if (token != null) {
        debugPrint("🎇 Token válido, redirigiendo...");
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



// import 'package:auto_route/auto_route.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:hive/hive.dart';
// import 'package:recipe_food/app/config/router/router.gr.dart';
// import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthGuard extends AutoRouteGuard {
//   final Box hiveBox = Hive.box('setting');

//   @override
//   Future<void> onNavigation(
//       NavigationResolver resolver, StackRouter router) async {
//     final connectivityResult = await Connectivity().checkConnectivity();
//     final bool isOnboarding = hiveBox.get("onboarding") ?? true;
//     print("🎃| $isOnboarding");
//     if (connectivityResult.first == ConnectivityResult.mobile ||
//         connectivityResult.first == ConnectivityResult.ethernet ||
//         connectivityResult.first == ConnectivityResult.wifi) {
//       //
//       final SupabaseClient supabase = SupabaseManager().client;
//       supabase.auth.onAuthStateChange.listen((data) async {
//         final event = data.event;
//         final token = data.session?.accessToken;
//         print("🎇🎆🎈1 $token");
//         // print("🎇🎆🎈3 ${data.session!.expiresAt}");

//         if (token != null) {
//           print("aquii----");
//           if (event == AuthChangeEvent.signedIn ||
//               event == AuthChangeEvent.initialSession ||
//               event == AuthChangeEvent.tokenRefreshed) {
//             print("aquii222----");
//             // Lógica para verificar la expiración del token
//             // final payload = _decodeToken(token);
//             // final int? timestampUnix = data.session!.expiresAt;
//             // final DateTime expirationTime = DateTime.fromMillisecondsSinceEpoch(
//             //   timestampUnix! * 1000,
//             //   isUtc: true,
//             // );
//             // final timeDifference =
//             //     expirationTime.difference(DateTime.now().toUtc());
//             // print("expire time: $expirationTime");
//             // print("time diference: $timeDifference");
//             // print("date utc : ${DateTime.now().toUtc()}");

//             // if (timeDifference.inMinutes < 5) {
//             //   // Verificar la conexión antes de refrescar el token

//             //   if (connectivityResult.first != ConnectivityResult.none) {
//             //     try {
//             //       // Hay conexión a internet, refrescar token
//             //       print("Se va a refrescar el token");
//             //       await supabase.auth.refreshSession();
//             //     } on SocketException catch (e) {
//             //       // Manejar el error de conexión
//             //       print("Error de conexión: $e");
//             //       // Mostrar un mensaje de error al usuario
//             //     } catch (e) {
//             //       print("🎉 $e");
//             //     }
//             //   } else {
//             //     // No hay conexión a internet, manejar el error
//             //     print("Sin conexión a internet");
//             //   }
//             // }

//             resolver.next(true); // Token válido, continuar a Home
//           }
//         } else if (event == AuthChangeEvent.signedOut || !isOnboarding) {
//           print("🎆 signed out");
//           router.replaceAll([const SignInRoute()]);
//         } else {
//           // Token expirado o no autenticado, redirigir a Onboarding
//           print("🎆 not token");
//           router.replaceAll([const OnboardingRoute()]);
//         }
//       });
//     } else {
//       print("no fount en el guard");
//       router.replaceAll([const NotFoundRoute()]);
//     }
//   }
// }