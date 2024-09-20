import 'dart:async';
import 'dart:io';
// import 'dart:convert';
// import 'dart:typed_data';

// import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
// ignore: unnecessary_import
// import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recipe_food/app/infra/models/received_notification.dart';
// ignore: depend_on_referenced_packages
// import 'package:http/http.dart' as http;
// ignore: unused_import
// import 'package:image/image.dart' as image;
// import 'package:path_provider/path_provider.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/data/latest_all.dart' as tz;
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

// !! -------- Flutter local notification----------------------------

int id = 0;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotificationModel>
    didReceiveLocalNotificationStream =
    StreamController<ReceivedNotificationModel>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

const MethodChannel platform = MethodChannel('osmi.dev/delicious_recipes');

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}
// !! -------- Flutter local notification----------------------------

abstract class LocalNotification {
  LocalNotification._();

  static Future<void> init() async {
    await _configureLocalTimeZone();

    /// * inicamos la configuracion de flutter local notification
    // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //     !kIsWeb && Platform.isLinux
    //         ? null
    //         : await flutterLocalNotificationsPlugin
    //             .getNotificationAppLaunchDetails();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        // final payload = notificationResponse.payload;
        // if (payload != null) {
        //   print('Notificación seleccionada con payload: $payload');
        //   if (payload == 'screen_1') {
        //     navigatorKey.currentState?.pushNamed('/screen1');
        //   } else if (payload == 'screen_2') {
        //     navigatorKey.currentState?.pushNamed('/screen2');
        //   }
        // }
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }
            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  //!! Show Notification
  // static Future<void> showNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  // static Future<void> showNotificationWithActions() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //     actions: <AndroidNotificationAction>[
  //       AndroidNotificationAction(
  //         urlLaunchActionId,
  //         'Action 1',
  //         icon: DrawableResourceAndroidBitmap('food'),
  //         contextual: true,
  //       ),
  //       AndroidNotificationAction(
  //         'id_2',
  //         'Action 2',
  //         titleColor: Color.fromARGB(255, 255, 0, 0),
  //         icon: DrawableResourceAndroidBitmap('secondary_icon'),
  //       ),
  //       AndroidNotificationAction(
  //         navigationActionId,
  //         'Action 3',
  //         icon: DrawableResourceAndroidBitmap('secondary_icon'),
  //         showsUserInterface: true,
  //         // By default, Android plugin will dismiss the notification when the
  //         // user tapped on a action (this mimics the behavior on iOS).
  //         cancelNotification: false,
  //       ),
  //     ],
  //   );

  //   const DarwinNotificationDetails iosNotificationDetails =
  //       DarwinNotificationDetails(
  //     categoryIdentifier: darwinNotificationCategoryPlain,
  //   );

  //   const DarwinNotificationDetails macOSNotificationDetails =
  //       DarwinNotificationDetails(
  //     categoryIdentifier: darwinNotificationCategoryPlain,
  //   );

  //   const LinuxNotificationDetails linuxNotificationDetails =
  //       LinuxNotificationDetails(
  //     actions: <LinuxNotificationAction>[
  //       LinuxNotificationAction(
  //         key: urlLaunchActionId,
  //         label: 'Action 1',
  //       ),
  //       LinuxNotificationAction(
  //         key: navigationActionId,
  //         label: 'Action 2',
  //       ),
  //     ],
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: iosNotificationDetails,
  //     macOS: macOSNotificationDetails,
  //     linux: linuxNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item z');
  // }

  // static Future<void> showNotificationWithTextAction() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //     actions: <AndroidNotificationAction>[
  //       AndroidNotificationAction(
  //         'text_id_1',
  //         'Enter Text',
  //         icon: DrawableResourceAndroidBitmap('food'),
  //         inputs: <AndroidNotificationActionInput>[
  //           AndroidNotificationActionInput(
  //             label: 'Enter a message',
  //           ),
  //         ],
  //       ),
  //     ],
  //   );

  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     categoryIdentifier: darwinNotificationCategoryText,
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: darwinNotificationDetails,
  //     macOS: darwinNotificationDetails,
  //   );

  //   await flutterLocalNotificationsPlugin.show(id++, 'Text Input Notification',
  //       'Expand to see input action', notificationDetails,
  //       payload: 'item x');
  // }

  // static Future<void> showNotificationWithIconAction() async {
  //   const LinuxNotificationDetails linuxNotificationDetails =
  //       LinuxNotificationDetails(
  //     actions: <LinuxNotificationAction>[
  //       LinuxNotificationAction(
  //         key: 'media-eject',
  //         label: 'Eject',
  //       ),
  //     ],
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     linux: linuxNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item z');
  // }

  // static Future<void> showNotificationWithTextChoice() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //     actions: <AndroidNotificationAction>[
  //       AndroidNotificationAction(
  //         'text_id_2',
  //         'Action 2',
  //         icon: DrawableResourceAndroidBitmap('food'),
  //         inputs: <AndroidNotificationActionInput>[
  //           AndroidNotificationActionInput(
  //             choices: <String>['ABC', 'DEF'],
  //             allowFreeFormInput: false,
  //           ),
  //         ],
  //         contextual: true,
  //       ),
  //     ],
  //   );

  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     categoryIdentifier: darwinNotificationCategoryText,
  //   );

  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: darwinNotificationDetails,
  //     macOS: darwinNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  // static Future<void> requestFullScreenIntentPermission(
  //     BuildContext context) async {
  //   final bool permissionGranted = await flutterLocalNotificationsPlugin
  //           .resolvePlatformSpecificImplementation<
  //               AndroidFlutterLocalNotificationsPlugin>()
  //           ?.requestFullScreenIntentPermission() ??
  //       false;
  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             content: Text(
  //                 'Full screen intent permission granted: $permissionGranted'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ));
  // }

  // static Future<void> showFullScreenNotification(BuildContext context) async {
  //   await showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Turn off your screen'),
  //       content: const Text(
  //           'to see the full-screen intent in 5 seconds, press OK and TURN '
  //           'OFF your screen. Note that the full-screen intent permission must '
  //           'be granted for this to work too'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //           },
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             await flutterLocalNotificationsPlugin.zonedSchedule(
  //                 0,
  //                 'scheduled title',
  //                 'scheduled body',
  //                 tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //                 const NotificationDetails(
  //                     android: AndroidNotificationDetails(
  //                         'full screen channel id', 'full screen channel name',
  //                         channelDescription: 'full screen channel description',
  //                         priority: Priority.high,
  //                         importance: Importance.high,
  //                         fullScreenIntent: true)),
  //                 androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //                 uiLocalNotificationDateInterpretation:
  //                     UILocalNotificationDateInterpretation.absoluteTime);

  //             Navigator.pop(context);
  //           },
  //           child: const Text('OK'),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // static Future<void> showNotificationWithNoBody() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', null, notificationDetails,
  //       payload: 'item x');
  // }

  // static Future<void> showNotificationWithNoTitle() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin
  //       .show(id++, null, 'plain body', notificationDetails, payload: 'item x');
  // }

  // static Future<void> cancelNotification() async {
  //   await flutterLocalNotificationsPlugin.cancel(--id);
  // }

  // static Future<void> cancelNotificationWithTag() async {
  //   await flutterLocalNotificationsPlugin.cancel(--id, tag: 'tag');
  // }

  // static Future<void> showNotificationCustomSound() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your other channel id',
  //     'your other channel name',
  //     channelDescription: 'your other channel description',
  //     sound: RawResourceAndroidNotificationSound('slow_spring_board'),
  //   );
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     sound: 'slow_spring_board.aiff',
  //   );
  //   final LinuxNotificationDetails linuxPlatformChannelSpecifics =
  //       LinuxNotificationDetails(
  //     sound: AssetsLinuxSound('sound/slow_spring_board.mp3'),
  //   );
  //   final NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: darwinNotificationDetails,
  //     macOS: darwinNotificationDetails,
  //     linux: linuxPlatformChannelSpecifics,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //     id++,
  //     'custom sound notification title',
  //     'custom sound notification body',
  //     notificationDetails,
  //   );
  // }

  // static Future<void> showNotificationCustomVibrationIconLed() async {
  //   final Int64List vibrationPattern = Int64List(4);
  //   vibrationPattern[0] = 0;
  //   vibrationPattern[1] = 1000;
  //   vibrationPattern[2] = 5000;
  //   vibrationPattern[3] = 2000;

  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'other custom channel id', 'other custom channel name',
  //           channelDescription: 'other custom channel description',
  //           icon: 'secondary_icon',
  //           largeIcon: const DrawableResourceAndroidBitmap('sample_large_icon'),
  //           vibrationPattern: vibrationPattern,
  //           enableLights: true,
  //           color: const Color.fromARGB(255, 255, 0, 0),
  //           ledColor: const Color.fromARGB(255, 255, 0, 0),
  //           ledOnMs: 1000,
  //           ledOffMs: 500);

  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'title of notification with custom vibration pattern, LED and icon',
  //       'body of notification with custom vibration pattern, LED and icon',
  //       notificationDetails);
  // }

  // static Future<void> zonedScheduleNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'scheduled title',
  //       'scheduled body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'your channel id', 'your channel name',
  //               channelDescription: 'your channel description')),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  // static Future<void> zonedScheduleAlarmClockNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       123,
  //       'scheduled alarm clock title',
  //       'scheduled alarm clock body',
  //       tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //       const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //               'alarm_clock_channel', 'Alarm Clock Channel',
  //               channelDescription: 'Alarm Clock Notification')),
  //       androidScheduleMode: AndroidScheduleMode.alarmClock,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime);
  // }

  // static Future<void> showNotificationWithNoSound() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('silent channel id', 'silent channel name',
  //           channelDescription: 'silent channel description',
  //           playSound: false,
  //           styleInformation: DefaultStyleInformation(true, true));
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     presentSound: false,
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: darwinNotificationDetails,
  //       macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  // }

  // static Future<void> showNotificationSilently() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker',
  //           silent: true);
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     presentSound: false,
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       android: androidNotificationDetails,
  //       iOS: darwinNotificationDetails,
  //       macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, '<b>silent</b> title', '<b>silent</b> body', notificationDetails);
  // }

  // static Future<void> showSoundUriNotification() async {
  //   /// this calls a method over a platform channel implemented within the
  //   /// example app to return the Uri for the default alarm sound and uses
  //   /// as the notification sound
  //   final String? alarmUri = await platform.invokeMethod<String>('getAlarmUri');
  //   final UriAndroidNotificationSound uriSound =
  //       UriAndroidNotificationSound(alarmUri!);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('uri channel id', 'uri channel name',
  //           channelDescription: 'uri channel description',
  //           sound: uriSound,
  //           styleInformation: const DefaultStyleInformation(true, true));
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'uri sound title', 'uri sound body', notificationDetails);
  // }

  // static Future<void> showTimeoutNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('silent channel id', 'silent channel name',
  //           channelDescription: 'silent channel description',
  //           timeoutAfter: 3000,
  //           styleInformation: DefaultStyleInformation(true, true));
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(id++, 'timeout notification',
  //       'Times out after 3 seconds', notificationDetails);
  // }

  // static Future<void> showInsistentNotification() async {
  //   // This value is from: https://developer.android.com/reference/android/app/Notification.html#FLAG_INSISTENT
  //   const int insistentFlag = 4;
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker',
  //           additionalFlags: Int32List.fromList(<int>[insistentFlag]));
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'insistent title', 'insistent body', notificationDetails,
  //       payload: 'item x');
  // }

  // static Future<String> _downloadAndSaveFile(
  //     String url, String fileName) async {
  //   final Directory directory = await getApplicationDocumentsDirectory();
  //   final String filePath = '${directory.path}/$fileName';
  //   final http.Response response = await http.get(Uri.parse(url));
  //   final File file = File(filePath);
  //   await file.writeAsBytes(response.bodyBytes);
  //   return filePath;
  // }

  // static Future<void> showBigPictureNotification() async {
  //   final String largeIconPath =
  //       await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
  //   final String bigPicturePath = await _downloadAndSaveFile(
  //       'https://dummyimage.com/400x800', 'bigPicture');
  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
  //           largeIcon: FilePathAndroidBitmap(largeIconPath),
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'big text title', 'silent body', notificationDetails);
  // }

  // static Future<String> _base64encodedImage(String url) async {
  //   final http.Response response = await http.get(Uri.parse(url));
  //   final String base64Data = base64Encode(response.bodyBytes);
  //   return base64Data;
  // }

  // static Future<void> showBigPictureNotificationBase64() async {
  //   final String largeIcon =
  //       await _base64encodedImage('https://dummyimage.com/48x48');
  //   final String bigPicture =
  //       await _base64encodedImage('https://dummyimage.com/400x800');

  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(
  //           ByteArrayAndroidBitmap.fromBase64String(
  //               bigPicture), //Base64AndroidBitmap(bigPicture),
  //           largeIcon: ByteArrayAndroidBitmap.fromBase64String(largeIcon),
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'big text title', 'silent body', notificationDetails);
  // }

  // static Future<Uint8List> _getByteArrayFromUrl(String url) async {
  //   final http.Response response = await http.get(Uri.parse(url));
  //   return response.bodyBytes;
  // }

  // static Future<void> showBigPictureNotificationURL() async {
  //   final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
  //       await _getByteArrayFromUrl('https://dummyimage.com/48x48'));
  //   final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
  //       await _getByteArrayFromUrl('https://dummyimage.com/400x800'));

  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(bigPicture,
  //           largeIcon: largeIcon,
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'big text title', 'silent body', notificationDetails);
  // }

  // static Future<void> showBigPictureNotificationHiddenLargeIcon() async {
  //   final String largeIconPath =
  //       await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
  //   final String bigPicturePath = await _downloadAndSaveFile(
  //       'https://dummyimage.com/400x800', 'bigPicture');
  //   final BigPictureStyleInformation bigPictureStyleInformation =
  //       BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
  //           hideExpandedLargeIcon: true,
  //           contentTitle: 'overridden <b>big</b> content title',
  //           htmlFormatContentTitle: true,
  //           summaryText: 'summary <i>text</i>',
  //           htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           largeIcon: FilePathAndroidBitmap(largeIconPath),
  //           styleInformation: bigPictureStyleInformation);
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'big text title', 'silent body', notificationDetails);
  // }

  // static Future<void> showNotificationMediaStyle() async {
  //   final String largeIconPath = await _downloadAndSaveFile(
  //       'https://dummyimage.com/128x128/00FF00/000000', 'largeIcon');
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'media channel id',
  //     'media channel name',
  //     channelDescription: 'media channel description',
  //     largeIcon: FilePathAndroidBitmap(largeIconPath),
  //     styleInformation: const MediaStyleInformation(),
  //   );
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'notification title', 'notification body', notificationDetails);
  // }

  // static Future<void> showBigTextNotification() async {
  //   const BigTextStyleInformation bigTextStyleInformation =
  //       BigTextStyleInformation(
  //     'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  //     htmlFormatBigText: true,
  //     contentTitle: 'overridden <b>big</b> content title',
  //     htmlFormatContentTitle: true,
  //     summaryText: 'summary <i>text</i>',
  //     htmlFormatSummaryText: true,
  //   );
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'big text channel id', 'big text channel name',
  //           channelDescription: 'big text channel description',
  //           styleInformation: bigTextStyleInformation);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'big text title', 'silent body', notificationDetails);
  // }

  // static Future<void> showInboxNotification() async {
  //   final List<String> lines = <String>['line <b>1</b>', 'line <i>2</i>'];
  //   final InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
  //       lines,
  //       htmlFormatLines: true,
  //       contentTitle: 'overridden <b>inbox</b> context title',
  //       htmlFormatContentTitle: true,
  //       summaryText: 'summary <i>text</i>',
  //       htmlFormatSummaryText: true);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('inbox channel id', 'inboxchannel name',
  //           channelDescription: 'inbox channel description',
  //           styleInformation: inboxStyleInformation);
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'inbox title', 'inbox body', notificationDetails);
  // }

  // static Future<void> showMessagingNotification() async {
  //   // use a platform channel to resolve an Android drawable resource to a URI.
  //   // This is NOT part of the notifications plugin. Calls made over this
  //   /// channel is handled by the app
  //   final String? imageUri =
  //       await platform.invokeMethod('drawableToUri', 'food');

  //   /// First two person objects will use icons that part of the Android app's
  //   /// drawable resources
  //   const Person me = Person(
  //     name: 'Me',
  //     key: '1',
  //     uri: 'tel:1234567890',
  //     icon: DrawableResourceAndroidIcon('me'),
  //   );
  //   const Person coworker = Person(
  //     name: 'Coworker',
  //     key: '2',
  //     uri: 'tel:9876543210',
  //     icon: FlutterBitmapAssetAndroidIcon('icons/coworker.png'),
  //   );
  //   // download the icon that would be use for the lunch bot person
  //   final String largeIconPath =
  //       await _downloadAndSaveFile('https://dummyimage.com/48x48', 'largeIcon');
  //   // this person object will use an icon that was downloaded
  //   final Person lunchBot = Person(
  //     name: 'Lunch bot',
  //     key: 'bot',
  //     bot: true,
  //     icon: BitmapFilePathAndroidIcon(largeIconPath),
  //   );
  //   final Person chef = Person(
  //       name: 'Master Chef',
  //       key: '3',
  //       uri: 'tel:111222333444',
  //       icon: ByteArrayAndroidIcon.fromBase64String(
  //           await _base64encodedImage('https://placekitten.com/48/48')));

  //   final List<Message> messages = <Message>[
  //     Message('Hi', DateTime.now(), null),
  //     Message("What's up?", DateTime.now().add(const Duration(minutes: 5)),
  //         coworker),
  //     Message('Lunch?', DateTime.now().add(const Duration(minutes: 10)), null,
  //         dataMimeType: 'image/png', dataUri: imageUri),
  //     Message('What kind of food would you prefer?',
  //         DateTime.now().add(const Duration(minutes: 10)), lunchBot),
  //     Message('You do not have time eat! Keep working!',
  //         DateTime.now().add(const Duration(minutes: 11)), chef),
  //   ];
  //   final MessagingStyleInformation messagingStyle = MessagingStyleInformation(
  //       me,
  //       groupConversation: true,
  //       conversationTitle: 'Team lunch',
  //       htmlFormatContent: true,
  //       htmlFormatTitle: true,
  //       messages: messages);
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('message channel id', 'message channel name',
  //           channelDescription: 'message channel description',
  //           category: AndroidNotificationCategory.message,
  //           styleInformation: messagingStyle);
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id, 'message title', 'message body', notificationDetails);

  //   // wait 10 seconds and add another message to simulate another response
  //   await Future<void>.delayed(const Duration(seconds: 10), () async {
  //     messages.add(Message("I'm so sorry!!! But I really like thai food ...",
  //         DateTime.now().add(const Duration(minutes: 11)), null));
  //     await flutterLocalNotificationsPlugin.show(
  //         id++, 'message title', 'message body', notificationDetails);
  //   });
  // }

  // static Future<void> showGroupedNotifications() async {
  //   const String groupKey = 'com.android.example.WORK_EMAIL';
  //   const String groupChannelId = 'grouped channel id';
  //   const String groupChannelName = 'grouped channel name';
  //   const String groupChannelDescription = 'grouped channel description';
  //   // example based on https://developer.android.com/training/notify-user/group.html
  //   const AndroidNotificationDetails firstNotificationAndroidSpecifics =
  //       AndroidNotificationDetails(groupChannelId, groupChannelName,
  //           channelDescription: groupChannelDescription,
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           groupKey: groupKey);
  //   const NotificationDetails firstNotificationPlatformSpecifics =
  //       NotificationDetails(android: firstNotificationAndroidSpecifics);
  //   await flutterLocalNotificationsPlugin.show(id++, 'Alex Faarborg',
  //       'You will not believe...', firstNotificationPlatformSpecifics);
  //   const AndroidNotificationDetails secondNotificationAndroidSpecifics =
  //       AndroidNotificationDetails(groupChannelId, groupChannelName,
  //           channelDescription: groupChannelDescription,
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           groupKey: groupKey);
  //   const NotificationDetails secondNotificationPlatformSpecifics =
  //       NotificationDetails(android: secondNotificationAndroidSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'Jeff Chang',
  //       'Please join us to celebrate the...',
  //       secondNotificationPlatformSpecifics);

  //   // Create the summary notification to support older devices that pre-date
  //   /// Android 7.0 (API level 24).
  //   ///
  //   /// Recommended to create this regardless as the behaviour may vary as
  //   /// mentioned in https://developer.android.com/training/notify-user/group
  //   const List<String> lines = <String>[
  //     'Alex Faarborg  Check this out',
  //     'Jeff Chang    Launch Party'
  //   ];
  //   const InboxStyleInformation inboxStyleInformation = InboxStyleInformation(
  //       lines,
  //       contentTitle: '2 messages',
  //       summaryText: 'janedoe@example.com');
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(groupChannelId, groupChannelName,
  //           channelDescription: groupChannelDescription,
  //           styleInformation: inboxStyleInformation,
  //           groupKey: groupKey,
  //           setAsGroupSummary: true);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'Attention', 'Two messages', notificationDetails);
  // }

  // static Future<void> showNotificationWithTag() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           tag: 'tag');
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //     android: androidNotificationDetails,
  //   );
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'first notification', null, notificationDetails);
  // }

  // static Future<void> checkPendingNotificationRequests(
  //     BuildContext context) async {
  //   final List<PendingNotificationRequest> pendingNotificationRequests =
  //       await flutterLocalNotificationsPlugin.pendingNotificationRequests();
  //   return showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content:
  //           Text('${pendingNotificationRequests.length} pending notification '
  //               'requests'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static Future<void> cancelAllNotifications() async {
  //   await flutterLocalNotificationsPlugin.cancelAll();
  // }

  // static Future<void> showOngoingNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ongoing: true,
  //           autoCancel: false);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'ongoing notification title',
  //       'ongoing notification body',
  //       notificationDetails);
  // }

  // static Future<void> repeatNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'repeating channel id', 'repeating channel name',
  //           channelDescription: 'repeating description');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.periodicallyShow(
  //     id++,
  //     'repeating title',
  //     'repeating body',
  //     RepeatInterval.everyMinute,
  //     notificationDetails,
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //   );
  // }

  // static Future<void> repeatPeriodicallyWithDurationNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'repeating channel id', 'repeating channel name',
  //           channelDescription: 'repeating description');
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.periodicallyShowWithDuration(
  //     id++,
  //     'repeating period title',
  //     'repeating period body',
  //     const Duration(minutes: 5),
  //     notificationDetails,
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //   );
  // }

  // Future<void> _scheduleDailyTenAMNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'daily scheduled notification title',
  //       'daily scheduled notification body',
  //       _nextInstanceOfTenAM(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('daily notification channel id',
  //             'daily notification channel name',
  //             channelDescription: 'daily notification description'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time);
  // }

  // /// To test we don't validate past dates when using `matchDateTimeComponents`
  // Future<void> _scheduleDailyTenAMLastYearNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'daily scheduled notification title',
  //       'daily scheduled notification body',
  //       _nextInstanceOfTenAMLastYear(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('daily notification channel id',
  //             'daily notification channel name',
  //             channelDescription: 'daily notification description'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.time);
  // }

  // Future<void> _scheduleWeeklyTenAMNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'weekly scheduled notification title',
  //       'weekly scheduled notification body',
  //       _nextInstanceOfTenAM(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('weekly notification channel id',
  //             'weekly notification channel name',
  //             channelDescription: 'weekly notificationdescription'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  // }

  // Future<void> _scheduleWeeklyMondayTenAMNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'weekly scheduled notification title',
  //       'weekly scheduled notification body',
  //       _nextInstanceOfMondayTenAM(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('weekly notification channel id',
  //             'weekly notification channel name',
  //             channelDescription: 'weekly notificationdescription'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);
  // }

  // Future<void> _scheduleMonthlyMondayTenAMNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'monthly scheduled notification title',
  //       'monthly scheduled notification body',
  //       _nextInstanceOfMondayTenAM(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('monthly notification channel id',
  //             'monthly notification channel name',
  //             channelDescription: 'monthly notificationdescription'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
  // }

  // Future<void> _scheduleYearlyMondayTenAMNotification() async {
  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //       0,
  //       'yearly scheduled notification title',
  //       'yearly scheduled notification body',
  //       _nextInstanceOfMondayTenAM(),
  //       const NotificationDetails(
  //         android: AndroidNotificationDetails('yearly notification channel id',
  //             'yearly notification channel name',
  //             channelDescription: 'yearly notification description'),
  //       ),
  //       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //       matchDateTimeComponents: DateTimeComponents.dateAndTime);
  // }

  // tz.TZDateTime _nextInstanceOfTenAM() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate =
  //       tz.TZDateTime(tz.local, now.year, now.month, now.day, 10);
  //   if (scheduledDate.isBefore(now)) {
  //     scheduledDate = scheduledDate.add(const Duration(days: 1));
  //   }
  //   return scheduledDate;
  // }

  // tz.TZDateTime _nextInstanceOfTenAMLastYear() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   return tz.TZDateTime(tz.local, now.year - 1, now.month, now.day, 10);
  // }

  // tz.TZDateTime _nextInstanceOfMondayTenAM() {
  //   tz.TZDateTime scheduledDate = _nextInstanceOfTenAM();
  //   while (scheduledDate.weekday != DateTime.monday) {
  //     scheduledDate = scheduledDate.add(const Duration(days: 1));
  //   }
  //   return scheduledDate;
  // }

  // Future<void> _showNotificationWithNoBadge() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('no badge channel', 'no badge name',
  //           channelDescription: 'no badge description',
  //           channelShowBadge: false,
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           onlyAlertOnce: true);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'no badge title', 'no badge body', notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showProgressNotification() async {
  //   id++;
  //   final int progressId = id;
  //   const int maxProgress = 5;
  //   for (int i = 0; i <= maxProgress; i++) {
  //     await Future<void>.delayed(const Duration(seconds: 1), () async {
  //       final AndroidNotificationDetails androidNotificationDetails =
  //           AndroidNotificationDetails('progress channel', 'progress channel',
  //               channelDescription: 'progress channel description',
  //               channelShowBadge: false,
  //               importance: Importance.high,
  //               priority: Priority.high,
  //               onlyAlertOnce: true,
  //               showProgress: true,
  //               maxProgress: maxProgress,
  //               progress: i);
  //       final NotificationDetails notificationDetails =
  //           NotificationDetails(android: androidNotificationDetails);
  //       await flutterLocalNotificationsPlugin.show(
  //           progressId,
  //           'progress notification title',
  //           'progress notification body',
  //           notificationDetails,
  //           payload: 'item x');
  //     });
  //   }
  // }

  // Future<void> _showIndeterminateProgressNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //           'indeterminate progress channel', 'indeterminate progress channel',
  //           channelDescription: 'indeterminate progress channel description',
  //           channelShowBadge: false,
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           onlyAlertOnce: true,
  //           showProgress: true,
  //           indeterminate: true);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'indeterminate progress notification title',
  //       'indeterminate progress notification body',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationUpdateChannelDescription() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your updated channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           channelAction: AndroidNotificationChannelAction.update);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'updated notification channel',
  //       'check settings to see updated channel description',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showPublicNotification() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker',
  //           visibility: NotificationVisibility.public);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'public notification title',
  //       'public notification body',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithSubtitle() async {
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     subtitle: 'the subtitle',
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'title of notification with a subtitle',
  //       'body of notification with a subtitle',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithIconBadge() async {
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(badgeNumber: 1);
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'icon badge title', 'icon badge body', notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationsWithThreadIdentifier() async {
  //   NotificationDetails buildNotificationDetailsForThread(
  //     String threadIdentifier,
  //   ) {
  //     final DarwinNotificationDetails darwinNotificationDetails =
  //         DarwinNotificationDetails(
  //       threadIdentifier: threadIdentifier,
  //     );
  //     return NotificationDetails(
  //         iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   }

  //   final NotificationDetails thread1PlatformChannelSpecifics =
  //       buildNotificationDetailsForThread('thread1');
  //   final NotificationDetails thread2PlatformChannelSpecifics =
  //       buildNotificationDetailsForThread('thread2');

  //   await flutterLocalNotificationsPlugin.show(id++, 'thread 1',
  //       'first notification', thread1PlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(id++, 'thread 1',
  //       'second notification', thread1PlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(id++, 'thread 1',
  //       'third notification', thread1PlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.show(id++, 'thread 2',
  //       'first notification', thread2PlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(id++, 'thread 2',
  //       'second notification', thread2PlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(id++, 'thread 2',
  //       'third notification', thread2PlatformChannelSpecifics);
  // }

  // Future<void> _showNotificationWithTimeSensitiveInterruptionLevel() async {
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     interruptionLevel: InterruptionLevel.timeSensitive,
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'title of time sensitive notification',
  //       'body of time sensitive notification',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithBannerNotInNotificationCentre() async {
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     presentBanner: true,
  //     presentList: false,
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'title of banner notification',
  //       'body of banner notification',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationInNotificationCentreOnly() async {
  //   const DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     presentBanner: false,
  //     presentList: true,
  //   );
  //   const NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'title of notification shown only in notification centre',
  //       'body of notification shown only in notification centre',
  //       notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithoutTimestamp() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           showWhen: false);
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithCustomTimestamp() async {
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
  //   );
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithCustomSubText() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     showWhen: false,
  //     subText: 'custom subtext',
  //   );
  //   const NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithChronometer() async {
  //   final AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'your channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     when: DateTime.now().millisecondsSinceEpoch - 120 * 1000,
  //     usesChronometer: true,
  //     chronometerCountDown: true,
  //   );
  //   final NotificationDetails notificationDetails =
  //       NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++, 'plain title', 'plain body', notificationDetails,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithAttachment({
  //   required bool hideThumbnail,
  // }) async {
  //   final String bigPicturePath = await _downloadAndSaveFile(
  //       'https://dummyimage.com/600x200', 'bigPicture.jpg');
  //   final DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     attachments: <DarwinNotificationAttachment>[
  //       DarwinNotificationAttachment(
  //         bigPicturePath,
  //         hideThumbnail: hideThumbnail,
  //       )
  //     ],
  //   );
  //   final NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'notification with attachment title',
  //       'notification with attachment body',
  //       notificationDetails);
  // }

  // Future<void> _showNotificationWithClippedThumbnailAttachment() async {
  //   final String bigPicturePath = await _downloadAndSaveFile(
  //       'https://dummyimage.com/600x200', 'bigPicture.jpg');
  //   final DarwinNotificationDetails darwinNotificationDetails =
  //       DarwinNotificationDetails(
  //     attachments: <DarwinNotificationAttachment>[
  //       DarwinNotificationAttachment(
  //         bigPicturePath,
  //         thumbnailClippingRect:
  //             // lower right quadrant of the attachment
  //             const DarwinNotificationAttachmentThumbnailClippingRect(
  //           x: 0.5,
  //           y: 0.5,
  //           height: 0.5,
  //           width: 0.5,
  //         ),
  //       )
  //     ],
  //   );
  //   final NotificationDetails notificationDetails = NotificationDetails(
  //       iOS: darwinNotificationDetails, macOS: darwinNotificationDetails);
  //   await flutterLocalNotificationsPlugin.show(
  //       id++,
  //       'notification with attachment title',
  //       'notification with attachment body',
  //       notificationDetails);
  // }

  // Future<void> createNotificationChannelGroup(BuildContext context) async {
  //   const String channelGroupId = 'your channel group id';
  //   // create the group first
  //   const AndroidNotificationChannelGroup androidNotificationChannelGroup =
  //       AndroidNotificationChannelGroup(
  //           channelGroupId, 'your channel group name',
  //           description: 'your channel group description');
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()!
  //       .createNotificationChannelGroup(androidNotificationChannelGroup);

  //   // create channels associated with the group
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()!
  //       .createNotificationChannel(const AndroidNotificationChannel(
  //           'grouped channel id 1', 'grouped channel name 1',
  //           description: 'grouped channel description 1',
  //           groupId: channelGroupId));

  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()!
  //       .createNotificationChannel(const AndroidNotificationChannel(
  //           'grouped channel id 2', 'grouped channel name 2',
  //           description: 'grouped channel description 2',
  //           groupId: channelGroupId));

  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             content: Text('Channel group with name '
  //                 '${androidNotificationChannelGroup.name} created'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ));
  // }

  // Future<void> deleteNotificationChannelGroup(BuildContext context) async {
  //   const String channelGroupId = 'your channel group id';
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannelGroup(channelGroupId);

  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: const Text('Channel group with id $channelGroupId deleted'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<void> startForegroundService() async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           ticker: 'ticker');
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.startForegroundService(1, 'plain title', 'plain body',
  //           notificationDetails: androidNotificationDetails, payload: 'item x');
  // }

  // Future<void> startForegroundServiceWithBlueBackgroundNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel name',
  //     channelDescription: 'color background channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //     color: Colors.blue,
  //     colorized: true,
  //   );

  //   /// only using foreground service can color the background
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.startForegroundService(
  //           1, 'colored background text title', 'colored background text body',
  //           notificationDetails: androidPlatformChannelSpecifics,
  //           payload: 'item x');
  // }

  // Future<void> stopForegroundService() async {
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.stopForegroundService();
  // }

  // Future<void> createNotificationChannel(BuildContext context) async {
  //   const AndroidNotificationChannel androidNotificationChannel =
  //       AndroidNotificationChannel(
  //     'your channel id 2',
  //     'your channel name 2',
  //     description: 'your channel description 2',
  //   );
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(androidNotificationChannel);

  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             content:
  //                 Text('Channel with name ${androidNotificationChannel.name} '
  //                     'created'),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ));
  // }

  // Future<void> areNotifcationsEnabledOnAndroid(BuildContext context) async {
  //   final bool? areEnabled = await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.areNotificationsEnabled();
  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             content: Text(areEnabled == null
  //                 ? 'ERROR: received null'
  //                 : (areEnabled
  //                     ? 'Notifications are enabled'
  //                     : 'Notifications are NOT enabled')),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ));
  // }

  // Future<void> checkNotificationsOnCupertino(BuildContext context) async {
  //   final NotificationsEnabledOptions? isEnabled =
  //       await flutterLocalNotificationsPlugin
  //               .resolvePlatformSpecificImplementation<
  //                   IOSFlutterLocalNotificationsPlugin>()
  //               ?.checkPermissions() ??
  //           await flutterLocalNotificationsPlugin
  //               .resolvePlatformSpecificImplementation<
  //                   MacOSFlutterLocalNotificationsPlugin>()
  //               ?.checkPermissions();
  //   final String isEnabledString = isEnabled == null
  //       ? 'ERROR: received null'
  //       : '''
  //   isEnabled: ${isEnabled.isEnabled}
  //   isSoundEnabled: ${isEnabled.isSoundEnabled}
  //   isAlertEnabled: ${isEnabled.isAlertEnabled}
  //   isBadgeEnabled: ${isEnabled.isBadgeEnabled}
  //   isProvisionalEnabled: ${isEnabled.isProvisionalEnabled}
  //   isCriticalEnabled: ${isEnabled.isCriticalEnabled}
  //   ''';
  //   await showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) => AlertDialog(
  //             content: Text(isEnabledString),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pop();
  //                 },
  //                 child: const Text('OK'),
  //               ),
  //             ],
  //           ));
  // }

  // Future<void> deleteNotificationChannel(BuildContext context) async {
  //   const String channelId = 'your channel id 2';
  //   await flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.deleteNotificationChannel(channelId);

  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: const Text('Channel with id $channelId deleted'),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<void> _getActiveNotifications(BuildContext context) async {
  //   final Widget activeNotificationsDialogContent =
  //       await _getActiveNotificationsDialogContent(context);
  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: activeNotificationsDialogContent,
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<Widget> _getActiveNotificationsDialogContent(
  //     BuildContext context) async {
  //   if (Platform.isAndroid) {
  //     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     if (androidInfo.version.sdkInt < 23) {
  //       return const Text(
  //         '"getActiveNotifications" is available only for Android 6.0 or newer',
  //       );
  //     }
  //   } else if (Platform.isIOS) {
  //     final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //     final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     final List<String> fullVersion = iosInfo.systemVersion.split('.');
  //     if (fullVersion.isNotEmpty) {
  //       final int? version = int.tryParse(fullVersion[0]);
  //       if (version != null && version < 10) {
  //         return const Text(
  //           '"getActiveNotifications" is available only for iOS 10.0 or newer',
  //         );
  //       }
  //     }
  //   }

  //   try {
  //     final List<ActiveNotification>? activeNotifications =
  //         await flutterLocalNotificationsPlugin.getActiveNotifications();

  //     return Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         const Text(
  //           'Active Notifications',
  //           style: TextStyle(fontWeight: FontWeight.bold),
  //         ),
  //         const Divider(color: Colors.black),
  //         if (activeNotifications!.isEmpty)
  //           const Text('No active notifications'),
  //         if (activeNotifications.isNotEmpty)
  //           for (final ActiveNotification activeNotification
  //               in activeNotifications)
  //             Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Text(
  //                   'id: ${activeNotification.id}\n'
  //                   'channelId: ${activeNotification.channelId}\n'
  //                   'groupKey: ${activeNotification.groupKey}\n'
  //                   'tag: ${activeNotification.tag}\n'
  //                   'title: ${activeNotification.title}\n'
  //                   'body: ${activeNotification.body}',
  //                 ),
  //                 if (Platform.isAndroid &&
  //                     activeNotification.id != null) ...<Widget>[
  //                   Text('bigText: ${activeNotification.bigText}'),
  //                   TextButton(
  //                     child: const Text('Get messaging style'),
  //                     onPressed: () {
  //                       _getActiveNotificationMessagingStyle(context,
  //                           activeNotification.id!, activeNotification.tag);
  //                     },
  //                   ),
  //                 ],
  //                 const Divider(color: Colors.black),
  //               ],
  //             ),
  //       ],
  //     );
  //   } on PlatformException catch (error) {
  //     return Text(
  //       'Error calling "getActiveNotifications"\n'
  //       'code: ${error.code}\n'
  //       'message: ${error.message}',
  //     );
  //   }
  // }

  // Future<void> _getActiveNotificationMessagingStyle(
  //     BuildContext context, int id, String? tag) async {
  //   Widget dialogContent;
  //   try {
  //     final MessagingStyleInformation? messagingStyle =
  //         await flutterLocalNotificationsPlugin
  //             .resolvePlatformSpecificImplementation<
  //                 AndroidFlutterLocalNotificationsPlugin>()!
  //             .getActiveNotificationMessagingStyle(id, tag: tag);
  //     if (messagingStyle == null) {
  //       dialogContent = const Text('No messaging style');
  //     } else {
  //       dialogContent = SingleChildScrollView(
  //           child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: <Widget>[
  //           Text('person: ${_formatPerson(messagingStyle.person)}\n'
  //               'conversationTitle: ${messagingStyle.conversationTitle}\n'
  //               'groupConversation: ${messagingStyle.groupConversation}'),
  //           const Divider(color: Colors.black),
  //           if (messagingStyle.messages == null) const Text('No messages'),
  //           if (messagingStyle.messages != null)
  //             for (final Message msg in messagingStyle.messages!)
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text('text: ${msg.text}\n'
  //                       'timestamp: ${msg.timestamp}\n'
  //                       'person: ${_formatPerson(msg.person)}'),
  //                   const Divider(color: Colors.black),
  //                 ],
  //               ),
  //         ],
  //       ));
  //     }
  //   } on PlatformException catch (error) {
  //     dialogContent = Text(
  //       'Error calling "getActiveNotificationMessagingStyle"\n'
  //       'code: ${error.code}\n'
  //       'message: ${error.message}',
  //     );
  //   }

  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: const Text('Messaging style'),
  //       content: dialogContent,
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // String _formatPerson(Person? person) {
  //   if (person == null) {
  //     return 'null';
  //   }

  //   final List<String> attrs = <String>[];
  //   if (person.name != null) {
  //     attrs.add('name: "${person.name}"');
  //   }
  //   if (person.uri != null) {
  //     attrs.add('uri: "${person.uri}"');
  //   }
  //   if (person.key != null) {
  //     attrs.add('key: "${person.key}"');
  //   }
  //   if (person.important) {
  //     attrs.add('important: true');
  //   }
  //   if (person.bot) {
  //     attrs.add('bot: true');
  //   }
  //   if (person.icon != null) {
  //     attrs.add('icon: ${_formatAndroidIcon(person.icon)}');
  //   }
  //   return 'Person(${attrs.join(', ')})';
  // }

  // String _formatAndroidIcon(Object? icon) {
  //   if (icon == null) {
  //     return 'null';
  //   }
  //   if (icon is DrawableResourceAndroidIcon) {
  //     return 'DrawableResourceAndroidIcon("${icon.data}")';
  //   } else if (icon is ContentUriAndroidIcon) {
  //     return 'ContentUriAndroidIcon("${icon.data}")';
  //   } else {
  //     return 'AndroidIcon()';
  //   }
  // }

  // Future<void> getNotificationChannels(BuildContext context) async {
  //   final Widget notificationChannelsDialogContent =
  //       await _getNotificationChannelsDialogContent();
  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: notificationChannelsDialogContent,
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () {
  //             Navigator.of(context).pop();
  //           },
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Future<Widget> _getNotificationChannelsDialogContent() async {
  //   try {
  //     final List<AndroidNotificationChannel>? channels =
  //         await flutterLocalNotificationsPlugin
  //             .resolvePlatformSpecificImplementation<
  //                 AndroidFlutterLocalNotificationsPlugin>()!
  //             .getNotificationChannels();

  //     return Container(
  //       width: double.maxFinite,
  //       child: ListView(
  //         children: <Widget>[
  //           const Text(
  //             'Notifications Channels',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           const Divider(color: Colors.black),
  //           if (channels?.isEmpty ?? true)
  //             const Text('No notification channels')
  //           else
  //             for (final AndroidNotificationChannel channel in channels!)
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text('id: ${channel.id}\n'
  //                       'name: ${channel.name}\n'
  //                       'description: ${channel.description}\n'
  //                       'groupId: ${channel.groupId}\n'
  //                       'importance: ${channel.importance.value}\n'
  //                       'playSound: ${channel.playSound}\n'
  //                       'sound: ${channel.sound?.sound}\n'
  //                       'enableVibration: ${channel.enableVibration}\n'
  //                       'vibrationPattern: ${channel.vibrationPattern}\n'
  //                       'showBadge: ${channel.showBadge}\n'
  //                       'enableLights: ${channel.enableLights}\n'
  //                       'ledColor: ${channel.ledColor}\n'
  //                       'audioAttributesUsage: ${channel.audioAttributesUsage}\n'),
  //                   const Divider(color: Colors.black),
  //                 ],
  //               ),
  //         ],
  //       ),
  //     );
  //   } on PlatformException catch (error) {
  //     return Text(
  //       'Error calling "getNotificationChannels"\n'
  //       'code: ${error.code}\n'
  //       'message: ${error.message}',
  //     );
  //   }
  // }

  // Future<void> _showNotificationWithNumber() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails('your channel id', 'your channel name',
  //           channelDescription: 'your channel description',
  //           importance: Importance.high,
  //           priority: Priority.high,
  //           number: 1);
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //       0, 'icon badge title', 'icon badge body', platformChannelSpecifics,
  //       payload: 'item x');
  // }

  // Future<void> _showNotificationWithAudioAttributeAlarm() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your alarm channel id',
  //     'your alarm channel name',
  //     channelDescription: 'your alarm channel description',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //     audioAttributesUsage: AudioAttributesUsage.alarm,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'notification sound controlled by alarm volume',
  //     'alarm notification sound body',
  //     platformChannelSpecifics,
  //   );
  // }
}
