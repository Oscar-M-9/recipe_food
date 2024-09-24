import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import 'package:recipe_food/app/config/router/router.dart';
import 'package:recipe_food/app/config/theme/app_theme.dart';
import 'package:recipe_food/app/presenter/controllers/notification/notification_controller.dart';

import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';
import 'package:recipe_food/app/presenter/controllers/hive_manager.dart';
import 'package:recipe_food/app/presenter/providers/language/language_notifier.dart';
import 'package:recipe_food/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationController.instance.setupFlutterNotifications();
  // Si el mensaje contiene datos y NO contiene una notificación, muestra una notificación personalizada
  if (message.notification == null) {
    NotificationController.instance.showDefaultNotification(message);
  }
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// inicializando firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializamos el controlador de notificaciones una sola vez
  await NotificationController.instance.initialize();

  // Set the background messaging handler early on, as a named top-level function
  // Listeners para notificaciones en diferentes estados
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// inicializando hive
  await HiveManager.init();

  /// inicializamos el enviaroment .env
  await dotenv.load(fileName: '.env');

  /// inicializamos el Supabase
  await SupabaseManager().init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

final _appRouter = AppRouter();

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    // Cargamos los datos del usuario por primera vez
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: AppColors.visVis400,
    //   ),
    // );

    return MaterialApp.router(
      title: 'Recetas Deliciosas',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      darkTheme: AppTheme.darkTheme(),
      theme: AppTheme.lightTheme(),
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      routerConfig: _appRouter.config(),
      // routerDelegate: _appRouter.delegate(),
      // routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
