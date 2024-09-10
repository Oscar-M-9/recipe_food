import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class AuthCheckRoute extends StatelessWidget {
  const AuthCheckRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child:
            CircularProgressIndicator(), // Pantalla de carga mientras se verifica la autenticación
      ),
    );
  }
}
