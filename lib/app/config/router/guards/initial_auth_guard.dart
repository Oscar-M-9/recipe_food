import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InitialAuthGuard extends AutoRouteGuard {
  final Box hiveBox = Hive.box('setting');
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final token = await _getToken();
    print('Iniciando verificación de token... $token');

    if (token != null && !_isTokenExpired(token)) {
      print("💚 Usuario autenticado");
      // router.replace(
      //     const LayoutRoute()); // Redirigir al Home si está autenticado dentro del layout
      resolver.next(
          true); // Dejar pasar la navegación si el usuario está autenticado
    } else if (token != null && await _refreshToken()) {
      // Intentar refrescar el token expirado
      print("🚆 token refrescado, usuario autenticado");
      resolver.next();
    } else {
      print("💚 Usuario no autenticado");
      print(router.current.name);
      // Evitar redirigir a la misma ruta recursivamente
      if (router.current.name != OnboardingRoute.name) {
        router.replace(
            const OnboardingRoute()); // Redirigir solo si no está en Onboarding
      }
    }
  }

  Future<String?> _getToken() async {
    final token = hiveBox.get('accessToken');
    return token;
  }

  bool _isTokenExpired(String token) {
    // Lógica para verificar la expiración del token
    final payload = _decodeToken(token);
    if (payload == null) {
      // Si no se puede decodificar el token, se asume que está expirado
      return true;
    }
    final expiryTime = payload['exp'];
    final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;

    return expiryTime != null && currentTime >= expiryTime;
  }

  Map<String, dynamic>? _decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      return null;
    }

    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload) as Map<String, dynamic>?;
  }

  Future<bool> _refreshToken() async {
    try {
      final String? refreshToken = hiveBox.get("refreshToken");
      if (refreshToken == null) {
        // no hay refresh token
        return false;
      }
      final response = await supabase.auth.refreshSession(refreshToken);
      if (response.session == null) {
        // No se pudo refrescar el token
        return false;
      }

      // Guardar el nuevo token en Hive
      final newToken = response.session?.accessToken;
      hiveBox.put("accessToken", newToken);
      return true;
    } on AuthException catch (e) {
      print("Error al refrescar token: ${e.message}");
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
