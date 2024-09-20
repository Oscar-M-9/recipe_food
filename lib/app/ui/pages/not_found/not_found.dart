import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recipe_food/app/config/language/index.dart';
import 'package:recipe_food/app/config/router/router.gr.dart';
import 'package:recipe_food/gen/assets.gen.dart';

@RoutePage()
class NotFoundPage extends StatefulWidget {
  const NotFoundPage({super.key});

  @override
  State<NotFoundPage> createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> {
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _redirectIfConnected(BuildContext context) async {
    if (_isConnected) {
      // Redirigir cuando hay conexión
      context.router.pushAndPopUntil(
        const LayoutRoute(),
        predicate: (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<ConnectivityResult>>(
        stream: Connectivity().onConnectivityChanged, // Stream de tipo correcto
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final connectivityResult = snapshot.data;
            // Si hay conexión, redirigir y no construir el widget de error
            if (connectivityResult?.first == ConnectivityResult.mobile ||
                connectivityResult?.first == ConnectivityResult.ethernet ||
                connectivityResult?.first == ConnectivityResult.wifi) {
              _isConnected = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _redirectIfConnected(context);
              });
              return const SizedBox(); // Vacío ya que redirigimos
            } else {
              _isConnected = false;
            }
          }

          // Mostrar UI cuando no hay conexión
          return SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Assets.svgs.networkWirelessOffline.svg(
                  height: 40,
                  // ignore: deprecated_member_use_from_same_package
                  color: Theme.of(context).iconTheme.color,
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.textWhereSorryConnection,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                const SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
