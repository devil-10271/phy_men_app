import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final notifiplugin = FlutterLocalNotificationsPlugin();
  bool _initli = false;
  Future<void> intNotification() async {
    if (_initli) return;

    const initSettingAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSetting = InitializationSettings(android: initSettingAndroid);

    await notifiplugin.initialize(initSetting);

    NotificationDetails notificationDetails() {
      return const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily_channel_id', 'Daily Notification',
              channelDescription: 'Daily notification channel',
              importance: Importance.max,
              priority: Priority.high));
    }
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    return notifiplugin.show(id, title, body, NotificationDetails());
  }
}
