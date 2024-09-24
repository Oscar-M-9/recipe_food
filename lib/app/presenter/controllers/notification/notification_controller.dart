import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:recipe_food/app/presenter/controllers/notification/channel_notification.dart';

class NotificationController {
  late FirebaseMessaging _messaging;
  late FlutterLocalNotificationsPlugin _localNotifications;

  static final NotificationController instance =
      NotificationController._internal();

  NotificationController._internal() {
    _messaging = FirebaseMessaging.instance;
    _localNotifications = FlutterLocalNotificationsPlugin();
  }

  get messaging => _messaging;
  get localNotificationPlugin => _localNotifications;

  Future<void> initialize() async {
    // Inicializamos la configuración de notificaciones
    await _initializeLocalNotifications();
    await _setupFirebaseMessagingListeners();
  }

  Future<String?> getToken() async {
    return await _messaging.getToken();
  }

  Future<void> deleteToken() async {
    await _messaging.deleteToken();
  }

  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> setupFlutterNotifications() async {
    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(ChannelNotification.channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> _setupFirebaseMessagingListeners() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Mensaje recibido en primer plano: ${message.messageId}");
      if (message.notification != null) {
        showNotification(
            message.notification!.title, message.notification!.body);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notificación fue pulsada: ${message.data}');
      // Aquí puedes manejar la navegación o acción cuando se abre la app desde una notificación
    });
  }

  // Mostrar notificaciones locales
  Future<void> showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'recipe_channel',
      'Recetas Deliciosas',
      channelDescription: 'Notificaciones de la App',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      DateTime.now().millisecondsSinceEpoch % 1000, // Evitar duplicados
      title,
      body,
      notificationDetails,
    );
  }

  // Función para manejar selección de notificaciones
  void _onSelectNotification(NotificationResponse response) {
    if (response.payload != null) {
      final data = jsonDecode(response.payload!);
      if (data['action'] == 'text') {
        print("Notificación con acción de texto seleccionada");
        // Manejar la acción aquí
      }
    }
  }

  // !! Notificacion Show

  // Cancela la notificaion por el id
  Future<void> cancelNotification(int id) async {
    await _localNotifications.cancel(id);
  }

  void showDefaultNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      showNotification(notification.title, notification.body);
    }
  }

  // Función para mostrar notificación de finalización
  Future<void> showCompletionNotification(int id, bool success) async {
    String title = success ? 'Subida Completa' : 'Error en la Subida';
    String body = success
        ? 'La receta se ha subido exitosamente.'
        : 'Ocurrió un error al subir la receta.';

    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'recipe_completion_channel',
      'Recetas Completadas',
      channelDescription: 'Notifica cualquier tarea de la receta.',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'drawable/ic_notification',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: 'recipe_completion',
    );
  }

  // Función para mostrar la notificación inicial
  void showProgressNotification(int id, int progress, int maxProgress) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_recipe_channel',
      'Enviando receta',
      channelDescription: 'Muestra el progreso de la subida de una receta.',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      indeterminate: false,
      icon: 'drawable/ic_notification',
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      id,
      'Subiendo receta',
      'Progreso: 0%',
      platformChannelSpecifics,
      payload: 'recipe_upload',
    );
  }

// Función para actualizar la notificación de progreso
  void updateProgressNotification(int id, int progress, int maxProgress) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_recipe_channel',
      'Enviando receta',
      channelDescription: 'Muestra el progreso de la subida de una receta.',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      indeterminate: false,
      icon: 'drawable/ic_notification',
    );

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await _localNotifications.show(
      id,
      'Subiendo receta',
      'Progreso: ${(progress / maxProgress * 100).toStringAsFixed(0)}%',
      platformChannelSpecifics,
      payload: 'recipe_upload',
    );
  }
}

// Handler para notificaciones en background
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print('Notificación ${notificationResponse.id} fue pulsada en background');
}
