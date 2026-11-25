import 'package:appstrock/Screens/Autentication/ScreenLogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('validates fields and focuses the first missing value',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScreenLogin()));
    await tester.ensureVisible(find.text('ورود به سامانه'));
    await tester.tap(find.text('ورود به سامانه'));
    await tester.pumpAndSettle();

    expect(find.text('نام کاربری را وارد کنید'), findsOneWidget);
    expect(find.text('کد ملی ۱۰ رقمی را وارد کنید'), findsOneWidget);
    expect(find.text('رمز عبور را وارد کنید'), findsOneWidget);
    final fields =
        tester.widgetList<TextField>(find.byType(TextField)).toList();
    expect(fields.first.focusNode!.hasFocus, isTrue);
  });

  testWidgets('normalizes national code digits and toggles password visibility',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScreenLogin()));
    final fields = find.byType(TextField);
    await tester.enterText(fields.at(1), '۱۲۳۴۵۶۷۸۹۰');
    await tester.pump();
    expect(tester.widget<TextField>(fields.at(1)).controller!.text,
        '1234567890');

    final password = fields.at(2);
    await tester.ensureVisible(password);
    await tester.enterText(password, 'my_password!');
    expect(tester.widget<TextField>(password).obscureText, isTrue);
    await tester.tap(find.byTooltip('نمایش رمز عبور'));
    await tester.pump();
    expect(tester.widget<TextField>(password).obscureText, isFalse);
    expect(tester.widget<TextField>(password).controller!.text,
        'my_password!');
  });

  testWidgets('keyboard next moves between login fields', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ScreenLogin()));
    final fields = find.byType(TextField);
    await tester.tap(fields.first);
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pump();
    expect(
        tester.widget<TextField>(fields.at(1)).focusNode!.hasFocus, isTrue);
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pump();
    expect(
        tester.widget<TextField>(fields.at(2)).focusNode!.hasFocus, isTrue);
  });
}
