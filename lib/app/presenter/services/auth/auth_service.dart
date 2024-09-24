import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/config/utils/constants.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:recipe_food/app/presenter/services/profile/profile_service.dart';
import 'package:recipe_food/app/presenter/services/user_device/user_devices_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final Box hiveBox = Hive.box('setting');
  final Box hiveBoxUser = Hive.box('user');
  // Get a reference your Supabase client
  final SupabaseClient supabase = SupabaseManager().client;
  final profileService = ProfileService();

  // ? Iniciar sesion por correo electronico y contraseña
  Future<AuthResponse?> signInWithEmail(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      hiveBox.put("onboarding", false);
      final user = await profileService.getUserData();
      await UserDevicesService().saveDeviceToSupabase(userId: user!.id!);
      return response;
    } on AuthException catch (e) {
      debugPrint("Error en autenticación:  ${e.message}");
      return null;
    }
  }

  // ? Registro con correo y contraseña
  Future<AuthResponse?> signUpWithEmail(
    String email,
    String password,
    String nameUser,
    bool acceptTerms,
  ) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      // Accediendo a a información del usuario
      final user = response.user;
      // Generar el username único
      final username = await generateUniqueUsername(nameUser);

      if (user != null) {
        // Insertar datos en la tabla users
        await supabase.from('users').insert({
          "auth_id": user.id,
          "name": nameUser,
          "username": username,
          "email": email,
          "terms_and_conditions": acceptTerms,
        });
      }
      hiveBox.put("onboarding", false);
      final userModel = await profileService.getUserData();
      await UserDevicesService().saveDeviceToSupabase(userId: userModel!.id!);
      return response;
    } on AuthException catch (e) {
      debugPrint("Error en registro: ${e.message}");
      return null;
    }
  }

  // ? Iniciar sessión con Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      debugPrint("------------Autenticando con google -------------");

      final GoogleSignIn googleSignIn = _getGoogleSignInInstance();
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        // El usuario canceló el proceso de inicio de sesión
        throw Exception('Inicio de sesión cancelado por el usuario.');
      }
      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw Exception('No Access Token found.');
      }
      if (idToken == null) {
        throw Exception('No ID Token found.');
      }

      // Autenticación en Supabase con los tokens de Google
      final response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      // Accediendo a la información del usuario
      final user = response.user;
      // Generar el username único

      if (user != null) {
        final existingUser = await supabase
            .from('users')
            .select()
            .eq('auth_id', user.id)
            .maybeSingle();

        if (existingUser == null) {
          // Inserta al nuevo usuario solo si no existe
          final username =
              await generateUniqueUsername(googleUser.displayName!);
          await supabase.from('users').insert({
            'auth_id': user.id,
            'email': googleUser.email,
            'name': googleUser.displayName,
            'username': username,
            'avatar_url': googleUser.photoUrl,
            "terms_and_conditions": true,
          });
        }
      }
      hiveBox.put("onboarding", false);
      final userModel = await profileService.getUserData();
      await UserDevicesService().saveDeviceToSupabase(userId: userModel!.id!);

      return response;
    } on AuthException catch (e) {
      debugPrint('Error de autenticación en Google: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error desconocido: $e');
      return null;
    }
  }

  // Cerrar sesión
  Future<void> signOut() async {
    final user = supabase.auth.currentUser;

    if (user != null) {
      // Obtener el proveedor de autenticación desde el app_metadata
      final String? provider = user.appMetadata['provider'];

      if (provider == 'google') {
        debugPrint('El usuario inició sesión con Google');
        await UserDevicesService().removeFcmTokenFromDevice();
        await signOutGoogleAndSupabase();
      } else if (provider == 'email') {
        debugPrint('El usuario inició sesión con email');
        await UserDevicesService().removeFcmTokenFromDevice();
        await supabase.auth.signOut();
      } else {
        debugPrint('El usuario inició sesión con otro proveedor: $provider');
      }
    } else {
      debugPrint('No hay ningún usuario autenticado');
    }
  }

  Future<void> signOutGoogleAndSupabase() async {
    try {
      final GoogleSignIn googleSignIn = _getGoogleSignInInstance();
      // Cierra sesión de Google
      await googleSignIn.signOut();
      debugPrint('Sesión cerrada de Google');

      // Cierra sesión en Supabase
      await Supabase.instance.client.auth.signOut();
      debugPrint('Sesión cerrada de Supabase');
    } catch (error) {
      debugPrint('Error cerrando sesión: $error');
    }
  }

// Instancia de GoogleSignIn para evitar duplicación de código
  GoogleSignIn _getGoogleSignInInstance() {
    // Web Client ID that you registered with Google Cloud.
    var webClientId = Constants.googleWebClientId;

    //  iOS Client ID that you registered with Google Cloud.
    // const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    return GoogleSignIn(
      serverClientId: webClientId,
      scopes: [
        'email',
        // Auth  userinfo email, profile
        'profile',
        // Auth userinfo profile, email
        'openid',
        // Auth userinfo profile, email
        'https://www.googleapis.com/auth/userinfo.email',
        // Auth userinfo profile, email
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
    );
  }

  //**** */ gen del username
  Future<String> generateUniqueUsername(String name) async {
    // 1. Generar el url
    String finalUsername = generarUrl(name);
    // 2. Verificar si ya existe en la base de datos
    bool isUsernameTaken = await _isUsernameTaken(finalUsername);

    // 3. Si el nombre ya existe, agregar un número aleatorio
    while (isUsernameTaken) {
      // Agregar un número aleatorio de 4 dígitos
      final random = Random();
      final randomNumber =
          random.nextInt(9999) + 1; // Generar un número de 1 a 9999
      finalUsername = '$finalUsername$randomNumber';

      // Volver a verificar si este nuevo username existe
      isUsernameTaken = await _isUsernameTaken(finalUsername);
    }
    return finalUsername;
  }

  String generarUrl(String texto) {
    return texto
        .toLowerCase() // Convertir a minúsculas
        .replaceAll(RegExp(r'\s+(?!$)'),
            '_') // Reemplazar espacios por guiones bajos, excepto si es el último caracter
        .replaceAll(
            RegExp(r'[^a-z0-9_@.-]'), ''); // Eliminar caracteres no permitidos
  }

  Future<bool> _isUsernameTaken(String username) async {
    final response = await supabase
        .from('users')
        .select('id')
        .eq('username', username)
        .maybeSingle();

    // Si la respuesta es null, significa que el username NO está tomado
    if (response == null) {
      return false;
    }

    // Si la respuesta no es null, significa que el username está tomado
    debugPrint("username is taken:  => $response");
    return true;
  }

  Future<bool> isEmailTaken(String email) async {
    final response = await supabase
        .from('users')
        .select('email')
        .eq('email', email)
        .maybeSingle();

    return response != null;
  }
}
