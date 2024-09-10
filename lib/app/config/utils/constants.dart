import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Clase para gestionar la inicialización y apertura de archivo .env.
abstract class EnvManager {
  EnvManager._();

  /// inicializamos el archivo .env
  static Future<void> init() async {
    await dotenv.load(fileName: '.env');
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
      ),
      storageOptions: const StorageClientOptions(
        retryAttempts: 10,
      ),
    );
  }

  /// cosntantes del enviroment
  static String supabaseUrl = dotenv.get("SUPABASE_URL");
  static String supabaseKey = dotenv.get("SUPABASE_KEY");
}
