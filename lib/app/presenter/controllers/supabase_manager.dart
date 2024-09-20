// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:recipe_food/app/config/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Clase para gestionar la inicialización y apertura de archivo .env.
class SupabaseManager {
  static final SupabaseManager _instance = SupabaseManager._internal();
  SupabaseClient? _supabaseClient;

  factory SupabaseManager() {
    return _instance;
  }

  SupabaseManager._internal();

  SupabaseClient get client => _supabaseClient!;

  /// inicializamos supabase
  Future<void> init() async {
    await Supabase.initialize(
      url: Constants.supabaseUrl,
      anonKey: Constants.supabaseKey,
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
    _supabaseClient = Supabase.instance.client;
  }
}
