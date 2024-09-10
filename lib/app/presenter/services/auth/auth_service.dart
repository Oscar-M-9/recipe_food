// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:math';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final Box hiveBox = Hive.box('setting');
  // Get a reference your Supabase client
  final SupabaseClient supabase = Supabase.instance.client;

  // ? Iniciar sesion por correo electronico y contraseña
  Future<AuthResponse?> signInWithEmail(String email, String password) async {
    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } on AuthException catch (e) {
      print("Error en autenticación:  ${e.message}");
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
      // final response2 = await supabase.auth.admin.createUser(
      //   AdminUserAttributes(
      //     email: email,
      //     password: password,
      //     emailConfirm: false,
      //   ),
      // );
      print("response: $response");
      // Accediendo a a información del usuario
      final user = response.user;
      print("user : $user");
      // Generar el username único
      final username = await generateUniqueUsername(nameUser);
      print("username : $username");

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
      // Accediendo a la sesión
      final session = response.session;
      print("sesion : $session");
      if (session != null) {
        final accessToken = session.accessToken;
        final refreshToken = session.refreshToken;
        hiveBox.put("accessToken", accessToken);
        hiveBox.put("refreshToken", refreshToken);
        print("Access Token: $accessToken");
        print("Refresh Token: $refreshToken");
      }

      return response;
    } on AuthException catch (e) {
      print("Error en registro: ${e.message}");
      return null;
    }
  }

  // ? Iniciar seesión con Google
  Future<AuthResponse?> signInWithGoogle() async {
    try {
      /// TODO: update the Web client ID with your own.
      ///
      /// Web Client ID that you registered with Google Cloud.
      const webClientId =
          '766543360584-k8r3t7d3u4t91pos3n7krdedhb0h1ho5.apps.googleusercontent.com';

      // /// iOS Client ID that you registered with Google Cloud.
      // const iosClientId = 'my-ios.apps.googleusercontent.com';

      // Google sign in on Android will work without providing the Android
      // Client ID registered on Google Cloud.

      final GoogleSignIn googleSignIn = GoogleSignIn(
        // clientId: iosClientId,
        serverClientId: webClientId,
      );
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
      final username = await generateUniqueUsername(googleUser.displayName!);

      if (user != null) {
        // 2. Insertar el usuario en la tabla 'users'
        await supabase.from('users').upsert({
          'auth_id': user.id,
          'email': googleUser.email,
          'name': googleUser.displayName,
          'username': username,
          'avatar_url': googleUser.photoUrl,
          "terms_and_conditions": true,
        });
      }
      // Accediendo a la sesión
      final session = response.session;
      if (session != null) {
        final accessToken = session.accessToken;
        final refreshToken = session.refreshToken;
        hiveBox.put("accessToken", accessToken);
        hiveBox.put("refreshToken", refreshToken);
        print("Access Token: $accessToken");
        print("Refresh Token: $refreshToken");
      }

      return response;
    } on AuthException catch (e) {
      print('Error de autenticación en Google: ${e.message}');
      return null;
    } catch (e) {
      print('Error desconocido: $e');
      return null;
    }
  }

  //**** */ gen del username
  Future<String> generateUniqueUsername(String name) async {
    // 1. Remover las tildes y convertir el nombre a minúsculas y reemplazar espacios por guiones bajos
    String baseUsername =
        _removeDiacritics(name.toLowerCase()).replaceAll(' ', '_');
    print("baseUsername: $baseUsername");

    // 2. Verificar si ya existe en la base de datos
    String finalUsername = baseUsername;
    bool isUsernameTaken = await _isUsernameTaken(finalUsername);
    print("isUsernameTaken: $isUsernameTaken");

    // 3. Si el nombre ya existe, agregar un número aleatorio
    while (isUsernameTaken) {
      // Agregar un número aleatorio de 4 dígitos
      final random = Random();
      final randomNumber =
          random.nextInt(9999) + 1; // Generar un número de 1 a 9999
      finalUsername = '$baseUsername$randomNumber';

      // Volver a verificar si este nuevo username existe
      isUsernameTaken = await _isUsernameTaken(finalUsername);
    }
    print("finalUsername: $finalUsername");
    return finalUsername;
  }

  // Función para remover las tildes
  String _removeDiacritics(String str) {
    const withDiacritics = 'áéíóúÁÉÍÓÚ';
    const withoutDiacritics = 'aeiouAEIOU';

    for (int i = 0; i < withDiacritics.length; i++) {
      str = str.replaceAll(withDiacritics[i], withoutDiacritics[i]);
    }

    return str;
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
    print("username is taken: true => ${response == null}");
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

  // // listen de la autenticacion en supabase
  // void setupAuthListener(context) {
  //   supabase.auth.onAuthStateChange.listen((data) {
  //     final event = data.event;
  //     if (event == AuthChangeEvent.signedIn ||
  //         event == AuthChangeEvent.initialSession) {
  //       context.router.pushAndPopUntil(
  //         const LayoutRoute(),
  //         predicate: (route) => false,
  //       );
  //     }else if (event == AuthChangeEvent.signedOut){
  //       context.router.
  //     }
  //   });
  // }
}
