# recipe_food

A new Flutter project.

## Getting Started

````
- const int notificationId = 1;

AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'progress_channel',
      'Progress Notification',
      channelDescription: 'Shows the progress of an ongoing task.',
      importance: Importance.high,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      indeterminate: false,
      icon: 'drawable/ic_notification', 
    );
````

para la notificaion de carga al agregar una receta.



----

````
AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'completion_channel',
      'Completion Notification',
      channelDescription: 'Notifica cuando la tarea ha finalizado.',
      importance: Importance.high,
      priority: Priority.high,
      icon: 'drawable/ic_notification',
    );
````