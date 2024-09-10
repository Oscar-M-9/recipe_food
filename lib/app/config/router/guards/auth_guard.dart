import 'package:hive/hive.dart';
import 'package:auto_route/auto_route.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthGuard extends AutoRouteGuard {
  final Box hiveBox = Hive.box('setting');
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final token = await _getToken();
    print("Token encontrado: $token");

    if (token != null && !_isTokenExpired(token)) {
      print("💚 usuario autenticado");
      resolver.next(true); // Usuario autenticado, continuar a Home
    } else {
      print("Usuario no autenticado, redirigiendo a Onboarding");
      // Redirigir al Onboarding y cancelar la navegación actual
      router.replaceAll([const OnboardingRoute()]);

      // router.pushAndPopUntil(const OnboardingRoute(),
      //     predicate: (_) => false); // Redirigir a Login
    }
  }

  Future<String?> _getToken() async {
    // Verificar en Hive o SecureStorage
    final token = hiveBox.get('accessToken');
    if (token != null) {
      return token;
    }

    final secureToken = await secureStorage.read(key: 'accessToken');
    return secureToken;
  }

  bool _isTokenExpired(String token) {
    // Lógica para verificar si el token ha expirado (puedes usar JWT o cualquier otro método)
    // Retorna true si ha expirado, false si es válido
    // Ejemplo simple con un timestamp de expiración:
    // final expiryDate = DateTime.parse(tokenExpiryDate);
    // return DateTime.now().isAfter(expiryDate);
    return false; // Solo como placeholder
  }
}


// class AuthGuard extends AutoRouteGuard {
//   @override
//   void onNavigation(NavigationResolver resolver, StackRouter router) async {
//     // the navigation is paused until resolver.next() is called with either
//     // true to resume/continue navigation or false to abort navigation
//     const isAuthenticated = false; // await _authService.isAuthenticated();

//     // ignore: dead_code
//     if (isAuthenticated) {
//       resolver.redirect(const HomeRoute());
//     }
//     // if user is authenticated we continue
//     resolver.redirect(const OnboardingRoute());
//   }
// }
