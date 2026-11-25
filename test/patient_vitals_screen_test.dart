import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/features/patients/data/resident_patient_repository.dart';
import 'package:appstrock/features/patients/ui/resident/patient_vitals_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('blood sugar accepts Persian digits and preserves input on failure', (tester) async {
    String? submitted;
    await tester.pumpWidget(MaterialApp(home: PatientVitalsScreen(
      patient: ModelPatient.fromJson({'id': 1}), vital: PatientVital.bloodSugar,
      onSubmit: (first, second) async { submitted = first; return const PatientOperationResult(false, 'خطای سرور'); },
    )));
    await tester.tap(find.widgetWithText(FilledButton, 'ثبت قند خون'));
    await tester.pump();
    expect(find.text('این مقدار را وارد کنید.'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('bloodSugar')), '۱۲۴');
    await tester.tap(find.widgetWithText(FilledButton, 'ثبت قند خون'));
    await tester.pump();
    expect(submitted, '124');
    expect(find.text('خطای سرور'), findsOneWidget);
    expect(find.text('۱۲۴'), findsOneWidget);
  });

  testWidgets('blood pressure validates both values and submits Arabic digits', (tester) async {
    List<String?>? submitted;
    await tester.pumpWidget(MaterialApp(home: PatientVitalsScreen(
      patient: ModelPatient.fromJson({'id': 1}), vital: PatientVital.bloodPressure,
      onSubmit: (first, second) async { submitted = [first, second]; return const PatientOperationResult(false, 'خطای سرور'); },
    )));
    await tester.enterText(find.byKey(const ValueKey('systolic')), '٨٠');
    await tester.enterText(find.byKey(const ValueKey('diastolic')), '٩٠');
    await tester.tap(find.widgetWithText(FilledButton, 'ثبت فشار خون'));
    await tester.pump();
    expect(submitted, isNull);
    expect(find.text('فشار سیستول باید بیشتر از فشار دیاستول باشد.'), findsOneWidget);
    await tester.enterText(find.byKey(const ValueKey('systolic')), '١٢٠');
    await tester.tap(find.widgetWithText(FilledButton, 'ثبت فشار خون'));
    await tester.pump();
    expect(submitted, ['120', '90']);
  });
}
