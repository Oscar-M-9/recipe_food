import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class ChannelNotification {
  ChannelNotification._();
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'recipe_channel', // ID del canal
    'Recetas Deliciosas', // Nombre del canal
    description: 'Notificaciones de la App', // Descripción del canal
    importance: Importance.high,
  );
}
