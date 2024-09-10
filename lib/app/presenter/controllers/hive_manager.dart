import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

/// Clase para gestionar la inicialización y apertura de cajas de Hive.
class HiveManager {
  /// Inicializa Hive y abre una caja llamada 'setting'.
  ///
  /// Este método debe ser llamado una vez, preferentemente al inicio de la aplicación,
  /// para configurar Hive y asegurarse de que la caja 'setting' esté lista para su uso.
  static Future<void> init() async {
    String appDocumentDirectory = "osmidev.com/recipe_food";
    if (!kIsWeb) {
      final directory = await path_provider.getApplicationDocumentsDirectory();
      appDocumentDirectory = directory.path;
    }
    Hive.init(appDocumentDirectory);
    // Inicializa Hive con soporte para Flutter.
    await Hive.initFlutter();

    // Abre una caja llamada 'setting'.
    await Hive.openBox('setting');
  }
}
