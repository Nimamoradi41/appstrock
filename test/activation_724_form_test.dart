import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/features/patients/data/resident_patient_repository.dart';
import 'package:appstrock/features/patients/ui/resident/activation_724_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart'
    as persian;

void main() {
  testWidgets('edits Persian date and time and submits known onset',
      (tester) async {
    Map<String, dynamic>? submitted;
    await tester.pumpWidget(MaterialApp(
        home: Activation724Form(
      patient: ModelPatient.fromJson(
          {'id': 1, 'fullName': 'بیمار نمونه', 'age': '64'}),
      onSubmit: (
          {required unknown,
          required startTime,
          required startDate,
          required fssTime,
          required fssDate,
          required lkwTime,
          required lkwDate,
          required timestamp,
          required lkwTimestamp,
          required fssTimestamp}) async {
        submitted = {
          'unknown': unknown,
          'date': startDate,
          'time': startTime,
          'timestamp': timestamp
        };
        return const PatientOperationResult(false, 'خطای ثبت');
      },
    )));
    expect(find.text('بیمار نمونه  ·  ۶۴ سال'), findsOneWidget);
    expect(find.text('اگر زمان شروع نامشخص باشد'), findsOneWidget);
    await tester.tap(find.text('تاریخ شروع علائم'));
    await tester.pumpAndSettle();
    expect(find.byType(persian.DatePickerDialog), findsOneWidget);
    final yesterday = persian.Jalali.fromDateTime(
        DateTime.now().subtract(const Duration(days: 1)));
    Navigator.of(tester.element(find.byType(persian.DatePickerDialog)))
        .pop(yesterday);
    await tester.pumpAndSettle();
    await tester.tap(find.text('ساعت شروع علائم'));
    await tester.pumpAndSettle();
    expect(find.byType(TimePickerDialog), findsOneWidget);
    Navigator.of(tester.element(find.byType(TimePickerDialog)))
        .pop(const TimeOfDay(hour: 10, minute: 5));
    await tester.pumpAndSettle();
    expect(find.text('۱۰:۰۵'), findsOneWidget);
    await tester.tap(find.text('مرور و ثبت کد ۷۲۴'));
    await tester.pumpAndSettle();
    expect(find.text('مرور اطلاعات'), findsOneWidget);
    await tester.tap(find.text('ثبت کد ۷۲۴'));
    await tester.pumpAndSettle();
    expect(submitted!['unknown'], false);
    expect(submitted!['time'], '10:05');
    expect(submitted!['date'],
        '${yesterday.year}/${yesterday.month.toString().padLeft(2, '0')}/${yesterday.day.toString().padLeft(2, '0')}');
    expect(int.parse(submitted!['timestamp']), greaterThan(0));
    expect(find.text('خطای ثبت'), findsOneWidget);
  });

  testWidgets('unknown onset shows editable LKW and FSS and submits both',
      (tester) async {
    Map<String, dynamic>? submitted;
    await tester.pumpWidget(MaterialApp(
        home: Activation724Form(
      patient: ModelPatient.fromJson({'id': 1}),
      onSubmit: (
          {required unknown,
          required startTime,
          required startDate,
          required fssTime,
          required fssDate,
          required lkwTime,
          required lkwDate,
          required timestamp,
          required lkwTimestamp,
          required fssTimestamp}) async {
        submitted = {
          'unknown': unknown,
          'lkw': lkwTimestamp,
          'fss': fssTimestamp,
          'start': timestamp
        };
        return const PatientOperationResult(false, 'خطای ثبت');
      },
    )));
    await tester.ensureVisible(find.text('زمان شروع مشخص نیست'));
    await tester.tap(find.text('زمان شروع مشخص نیست'));
    await tester.pumpAndSettle();
    expect(find.text('تاریخ LKW'), findsOneWidget);
    expect(find.text('ساعت FSS'), findsOneWidget);
    await tester.tap(find.text('مرور و ثبت کد ۷۲۴'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ثبت کد ۷۲۴'));
    await tester.pumpAndSettle();
    expect(submitted!['unknown'], true);
    expect(int.parse(submitted!['lkw']), greaterThan(0));
    expect(int.parse(submitted!['fss']), greaterThan(0));
    expect(submitted!['start'], '');
  });
}
