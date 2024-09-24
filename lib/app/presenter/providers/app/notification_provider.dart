import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod/riverpod.dart';

final notificationProvider =
    StateNotifierProvider<NotificationStateNotifier, bool>(
  (ref) => NotificationStateNotifier(),
);

class NotificationStateNotifier extends StateNotifier<bool> {
  NotificationStateNotifier() : super(false);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      state = granted;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestNotificationsPermission();
      state = grantedNotificationPermission ?? false;
    }
  }

  // void configureDidReceiveLocalNotificationSubject() {
  //   didReceiveLocalNotificationStream.stream
  //       .listen((ReceivedNotificationModel receivedNotification) async {
  //     // Tu lógica para manejar las notificaciones recibidas
  //     print("🔔 received notification ${receivedNotification.toJson()}");
  //     // await showDialog(
  //     //   context: context,
  //     //   builder: (BuildContext context) => CupertinoAlertDialog(
  //     //     title: receivedNotification.title != null
  //     //         ? Text(receivedNotification.title!)
  //     //         : null,
  //     //     content: receivedNotification.body != null
  //     //         ? Text(receivedNotification.body!)
  //     //         : null,
  //     //     actions: <Widget>[
  //     //       CupertinoDialogAction(
  //     //         isDefaultAction: true,
  //     //         onPressed: () async {
  //     //           Navigator.of(context, rootNavigator: true).pop();
  //     //           await Navigator.of(context).push(
  //     //             MaterialPageRoute<void>(
  //     //               builder: (BuildContext context) =>
  //     //                   SecondPage(receivedNotification.payload),
  //     //             ),
  //     //           );
  //     //         },
  //     //         child: const Text('Ok'),
  //     //       )
  //     //     ],
  //     //   ),
  //     // );
  //   });
  // }

  // void configureSelectNotificationSubject() {
  //   selectNotificationStream.stream.listen((String? payload) async {
  //     // Tu lógica para manejar las notificaciones seleccionadas
  //     print("🔔 notification payload: $payload");
  //     // await Navigator.of(context).push(MaterialPageRoute<void>(
  //     //   builder: (BuildContext context) => SecondPage(payload),
  //     // ));
  //   });
  // }

  // void notificationDispose() {
  //   didReceiveLocalNotificationStream.close();
  //   selectNotificationStream.close();
  // }
}
