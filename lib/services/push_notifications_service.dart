import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';

// SHA1: 5A:2F:E8:7B:66:B2:C0:25:FA:98:DB:08:14:F3:40:03:9E:EE:99:48
// P8 - KeyID: VYZH37GGZ9

class PushNotificationService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {
    // debugPrint( 'onBackground Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
    // _messageStream.add( message.notification?.title ?? 'No title' );
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    // debugPrint( 'onMessage Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
    // _messageStream.add( message.notification?.title ?? 'No title' );
  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // debugPrint( 'onMessageOpenApp Handler ${ message.messageId }');
    print(message.data);
    _messageStream.add(message.data['product'] ?? 'No data');
    // _messageStream.add( message.notification?.title ?? 'No title' );
  }

  static Future initializeApp() async {
    // Push Notifications
    await Firebase.initializeApp();
    //   await requestPermission();
    await messaging.getInitialMessage();
    token = await FirebaseMessaging.instance.getToken();
    debugPrint('Token: $token');

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications
  }

  // // Apple / Web
  // static requestPermission() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true
  //   );

  //   print('User push notification status ${ settings.authorizationStatus }');

  // }

  static closeStreams() {
    _messageStream.close();
  }
}
