import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'foreground_notification.dart';
import 'notification_display.dart';

const _webOptions = FirebaseOptions(
  apiKey: 'AIzaSyA1DnPt2k7cbCd8m2kswL4IxhxmwCYiD-M',
  appId: '1:523822990960:web:ffc8326bc7a938c23c96b5',
  messagingSenderId: '523822990960',
  projectId: 'nimamoradi41',
  authDomain: 'nimamoradi41.firebaseapp.com',
  storageBucket: 'nimamoradi41.firebasestorage.app',
);

const firebaseWebVapidKey = 'BMEP5BN459E25U8bvZBTEFKO3Y7cjPA5oawnFCUdl-cQVdclHkhz0DQrwwja3mV06VwvNU1IVv3gnvOoLon7v80';

Future<void>? _initialization;

Future<void> initializeFirebaseWebMessaging() =>
    _initialization ??= _initializeFirebaseWebMessaging().catchError((Object error, StackTrace stack) {
      _initialization = null;
      Error.throwWithStackTrace(error, stack);
    });

Future<void> _initializeFirebaseWebMessaging() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(options: _webOptions);
    }
    if (await FirebaseMessaging.instance.isSupported()) {
      FirebaseMessaging.onMessage.listen((message) {
        debugPrint('FCM: foreground message received');
        final title = message.notification?.title ??
            message.data['title']?.toString() ?? 'AppStroke';
        final body = message.notification?.body ??
            message.data['body']?.toString() ?? '';
        showInAppNotification(title, body);
        try {
          showForegroundNotification(title, body);
        } catch (error) {
          debugPrint('FCM: browser notification display failed: $error');
        }
      });
      debugPrint('FCM: foreground message listener ready');
    } else {
      debugPrint('FCM: messaging is not supported by this browser');
    }
  } catch (error) {
    debugPrint('Firebase Messaging initialization failed: $error');
    rethrow;
  }
}
