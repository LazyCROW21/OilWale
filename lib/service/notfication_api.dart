// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class NotificationAPI {
//   static String _channelId = 'oilmart';
//   static String _channelName = 'oilmart';
//   static String _channelDescription = 'oilmart';
//   // static String _icon = '';

//   static final _notifications = FlutterLocalNotificationsPlugin();

//   static Future _notificationDetails() async {
//     return NotificationDetails(
//         android: AndroidNotificationDetails(
//             _channelId, _channelName, _channelDescription,
//             importance: Importance.defaultImportance),
//         iOS: IOSNotificationDetails());
//   }

//   static Future showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//   }) async =>
//       _notifications.show(id, title, body, await _notificationDetails(),
//           payload: payload);
// }
