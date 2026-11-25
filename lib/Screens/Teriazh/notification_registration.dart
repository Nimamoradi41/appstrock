import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api_client.dart';
import '../../firebase_web_messaging.dart';

/// True only after permission is granted and the current token reaches the server.
Future<bool> notificationRegistrationIsActive() async {
  final preferences = await SharedPreferences.getInstance();
  final userId = int.tryParse(preferences.getString('UserId') ?? '');
  if (userId == null || userId <= 0) return false;
  if (kIsWeb) {
    await initializeFirebaseWebMessaging();
  } else if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
  final messaging = FirebaseMessaging.instance;
  if (!await messaging.isSupported()) return false;
  final settings = await messaging.getNotificationSettings();
  if (settings.authorizationStatus != AuthorizationStatus.authorized &&
      settings.authorizationStatus != AuthorizationStatus.provisional) {
    return false;
  }
  final token = await messaging.getToken(vapidKey: kIsWeb ? firebaseWebVapidKey : null);
  if (token == null || token.isEmpty) return false;
  await _sendToken(preferences, userId, token);
  await preferences.reload();
  return preferences.getString('UserId') == userId.toString();
}

Future<void> syncNotificationTokenIfAllowed() async {
  if (!kIsWeb) return;
  final preferences = await SharedPreferences.getInstance();
  final userId = int.tryParse(preferences.getString('UserId') ?? '');
  if (userId == null || userId <= 0) {
    debugPrint('FCM: token synchronization skipped: no signed-in user');
    return;
  }

  await initializeFirebaseWebMessaging();
  final messaging = FirebaseMessaging.instance;
  if (!await messaging.isSupported()) return;
  final settings = await messaging.getNotificationSettings();
  if (settings.authorizationStatus != AuthorizationStatus.authorized &&
      settings.authorizationStatus != AuthorizationStatus.provisional) {
    debugPrint('FCM: notification permission is not granted');
    return;
  }

  // On web, getToken also attaches FlutterFire's underlying onMessage listener.
  final token = await messaging.getToken(vapidKey: firebaseWebVapidKey);
  if (token == null || token.isEmpty) return;
  debugPrint('FCM: token obtained; synchronizing with server');
  await _sendToken(preferences, userId, token);
  debugPrint('FCM: token synchronization completed');
}

Future<void> _sendToken(SharedPreferences preferences, int userId, String token) async {
  await preferences.reload();
  if (preferences.getString('UserId') != userId.toString()) return;
  await ApiClient.instance.dio.post<dynamic>(
    '/notifications/register-token',
    data: {'userId': userId, 'token': token},
  );
}

Future<void> registerNotificationToken() async {
  final preferences = await SharedPreferences.getInstance();
  final userId = int.tryParse(preferences.getString('UserId') ?? '');
  if (userId == null || userId <= 0) {
    throw StateError('شناسه کاربر پیدا نشد؛ دوباره وارد حساب شوید');
  }

  if (kIsWeb) {
    await initializeFirebaseWebMessaging();
  } else if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  final messaging = FirebaseMessaging.instance;
  if (!await messaging.isSupported()) {
    throw StateError('اعلان‌ها در این دستگاه یا مرورگر پشتیبانی نمی‌شوند');
  }
  final settings = await messaging.requestPermission();
  if (settings.authorizationStatus != AuthorizationStatus.authorized &&
      settings.authorizationStatus != AuthorizationStatus.provisional) {
    throw StateError('اجازه ارسال اعلان صادر نشده است');
  }

  final token = await messaging.getToken(
    vapidKey: kIsWeb ? firebaseWebVapidKey : null,
  );
  if (token == null || token.isEmpty) {
    throw StateError('دریافت توکن اعلان ناموفق بود');
  }

  await _sendToken(preferences, userId, token);


}
