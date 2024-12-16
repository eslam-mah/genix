import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification(
      {required String title, required String body}) async {
    const NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'id',
        'name',
        channelDescription: 'This channel is used for Pusher notifications',
        importance: Importance.max,
        priority: Priority.high,
        showWhen: true,
      ),
    );

    await _notificationsPlugin.show(
      1,
      title,
      body,
      notificationDetails,
    );
  }
}
