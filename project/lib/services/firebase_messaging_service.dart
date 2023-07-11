import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:UniVerse/utils/route.dart';
import 'package:UniVerse/services/notification_service.dart';

import '../utils/authentication/auth.dart';
import 'package:http/http.dart' as http;

import 'package:UniVerse/consts/api_consts.dart';

class FirebaseMessagingService {
  final NotificationService _notificationService;

  FirebaseMessagingService(this._notificationService);

  Future<void> initialize() async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    getDeviceFirebaseToken();
    _onMessage();
    _onMessageOpenedApp();
  }

  getDeviceFirebaseToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('=============================================');
    print('TOKEN: $token');
    print('=============================================');
  }

  _onMessage() {
    FirebaseMessaging.onMessage.listen((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if(notification != null && android != null) {
        _notificationService.showLocalNotification(
          CustomNotification(
            id: android.hashCode,
            title: notification.title!,
            body: notification.body!,
            payload: message.data['route'] ?? '',
          ),
        );
      }
    });
  }

  _onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen(_goToPageAfterMessage);
  }

  _goToPageAfterMessage(message) {
    final String route = message.data['route'] ?? '';
    if(route.isNotEmpty) {
      Routing.navigatorKey?.currentState?.pushNamed(route);
    }
  }

  static Future<int> registerDevice() async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();

    final url = Uri.parse('$notificationUrl/register');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token
      },
      body: json.encode({
        'fcmToken': fcmToken,
      }),
    );

    return response.statusCode;
  }

}