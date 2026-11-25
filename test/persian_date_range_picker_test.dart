import 'package:appstrock/core/utils/persian_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart' as persian;

void main() {
  testWidgets('returns both dates and prevents an end before the start', (tester) async {
    PersianDateRange? result;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(
      builder: (context) => TextButton(
        onPressed: () async {
          result = await showPersianDateRangePicker(context,
              initialFrom: persian.Jalali(1405, 2, 1),
              initialTo: persian.Jalali(1405, 1, 1));
        },
        child: const Text('انتخاب'),
      ),
    ))));

    await tester.tap(find.text('انتخاب'));
    await tester.pumpAndSettle();
    expect(find.text('لغو'), findsOneWidget);
    expect(find.text('تأیید'), findsOneWidget);
    expect(find.textContaining('اردیبهشت'), findsWidgets);
    expect(find.text('۱'), findsWidgets);
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    final start = persian.Jalali(1405, 2, 10);
    navigator.pop(start);
    await tester.pumpAndSettle();
    expect(find.text('لغو'), findsOneWidget);
    expect(find.text('تأیید'), findsOneWidget);
    final endPicker = tester.widget<persian.DatePickerDialog>(find.byType(persian.DatePickerDialog));
    expect(endPicker.firstDate, start);
    expect(endPicker.initialDate, start);
    final end = persian.Jalali(1405, 2, 12);
    navigator.pop(end);
    await tester.pumpAndSettle();
    expect(result!.from, start);
    expect(result!.to, end);
  });

  testWidgets('cancelling the second picker returns no range', (tester) async {
    var completed = false;
    PersianDateRange? result;
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: Builder(
      builder: (context) => TextButton(
        onPressed: () async {
          result = await showPersianDateRangePicker(context);
          completed = true;
        },
        child: const Text('انتخاب'),
      ),
    ))));
    await tester.tap(find.text('انتخاب'));
    await tester.pumpAndSettle();
    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pop(persian.Jalali(1405, 2, 10));
    await tester.pumpAndSettle();
    navigator.pop();
    await tester.pumpAndSettle();
    expect(completed, isTrue);
    expect(result, isNull);
  });
}
