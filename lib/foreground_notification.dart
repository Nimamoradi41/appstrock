import 'package:flutter/material.dart';

final notificationMessengerKey = GlobalKey<ScaffoldMessengerState>();

void showInAppNotification(String title, String body) {
  final messenger = notificationMessengerKey.currentState;
  if (messenger == null) return;
  messenger.showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 8),
      content: Text(body.isEmpty ? title : '$title\n$body',
          textDirection: TextDirection.rtl),
    ),
  );
}
