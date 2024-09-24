import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hive/hive.dart';
import 'package:recipe_food/app/infra/models/user/user_model.dart';
import 'package:recipe_food/app/presenter/controllers/notification/notification_controller.dart';
import 'package:recipe_food/app/presenter/controllers/supabase_manager.dart';

class UserDevicesService {
  final supabase = SupabaseManager().client;
  final messagingService = NotificationController.instance;
  Future<void> saveDeviceToSupabase({
    required String userId,
  }) async {
    final deviceInfo = await getDeviceInfo();

    final deviceName = deviceInfo['device_name']!;
    final deviceOs = deviceInfo['device_os']!;

    // abrir el box donde verificaremos el fcmToken
    final box = await Hive.openBox('user');
    final fcmTokenLocal = box.get('fcmToken');

    // obtenido el fcmToken
    final fcmToken = await messagingService.getToken();

    // verificar que este token no estee registrado en user_devices en supabase
    if (fcmToken != fcmTokenLocal && fcmToken != null) {
      // si el token es diferente al que esta en hive, lo guardamos en supabase
      await _saveDevice(userId, fcmToken, deviceName, deviceOs);
      // guardamos el token en hive
      await box.put('fcmToken', fcmToken);
    }
  }

  Future<void> _saveDevice(
    String userId,
    String? fcmToken,
    String deviceName,
    String deviceOs,
  ) async {
    await supabase.from('user_devices').insert({
      'user_id': userId,
      'device_name': deviceName,
      'device_os': deviceOs,
      'fcm_token': fcmToken,
      // 'last_login': DateTime.now().toUtc().toIso8601String(),
    });
    print('Dispositivo guardado con éxito');
  }

  Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return {
        'device_name': androidInfo.model,
        'device_os': 'Android ${androidInfo.version.release}',
      };
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return {
        'device_name': iosInfo.name,
        'device_os': 'IOS ${iosInfo.systemVersion}',
      };
    } else {
      return {
        'device_name': 'Unknown Device',
        'device_os': 'Unknown OS',
      };
    }
  }

  // Método para eliminar el token FCM del dispositivo
  Future<void> removeFcmTokenFromDevice() async {
    try {
      final box = await Hive.openBox('user');
      final user = box.get('user') as UserModel;
      final fcmTokenLocal = box.get('fcmToken');

      if (fcmTokenLocal != null) {
        final data = await supabase
            .from('user_devices')
            .select()
            .eq('user_id', user.id!)
            .eq('fcm_token', fcmTokenLocal);

        // verificar en supabase si el fcmTokenLocal esta registrado y si lo esta eliminar el registro con ese fcm_token
        if (data.isNotEmpty) {
          await supabase
              .from('user_devices')
              .delete()
              .eq('user_id', user.id!)
              .eq('fcm_token', fcmTokenLocal);
        }
        await messagingService.deleteToken();
        await box.delete('fcmToken');
      }

      print('Token FCM eliminado del dispositivo');
    } catch (e) {
      print('Error al eliminar el token FCM: $e');
    }
  }
}
