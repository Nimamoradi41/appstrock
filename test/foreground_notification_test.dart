import 'package:appstrock/foreground_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows received notification inside the open app', (tester) async {
    await tester.pumpWidget(MaterialApp(
      scaffoldMessengerKey: notificationMessengerKey,
      home: const Scaffold(body: Text('صفحه برنامه')),
    ));

    showInAppNotification('عنوان اعلان', 'متن اعلان');
    await tester.pump();

    expect(find.text('عنوان اعلان\nمتن اعلان'), findsOneWidget);
  });
}
