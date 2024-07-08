import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final fltNotification = FlutterLocalNotificationsPlugin;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print('FCMToken: $FCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  void pushFCMtoken() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print('FCMToken: $FCMToken');
  }

  Future<void> initMessaging() async {
    var androiInit =
        AndroidInitializationSettings("@mipmap/ic_launcher"); //for logo

    var initSetting = InitializationSettings(android: androiInit);
    var fltNotification = FlutterLocalNotificationsPlugin();
    fltNotification.initialize(initSetting);
    var androidDetails = AndroidNotificationDetails("1", "channelName",
        importance: Importance.max,
        priority: Priority.high,
        enableVibration: true,
        playSound: true,
        ticker: "test");

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }
}
