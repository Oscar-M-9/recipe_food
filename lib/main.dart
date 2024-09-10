import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:recipe_food/app/config/app_colors.dart';
import 'package:recipe_food/app/config/router/router.dart';
import 'package:recipe_food/app/config/theme/app_theme.dart';
import 'package:recipe_food/app/config/utils/constants.dart';

import 'package:recipe_food/app/presenter/controllers/hive_manager.dart';
import 'package:recipe_food/app/presenter/providers/language/language_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// inicializando hive
  await HiveManager.init();

  /// inicializamos el enviaroment .env
  await EnvManager.init();

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
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: AppColors.visVis500,
      ),
    );

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
