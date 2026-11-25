import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/features/patients/data/resident_patient_repository.dart';
import 'package:appstrock/features/patients/ui/resident/laboratory_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'submits Persian decimal values and selected troponin to repository',
      (tester) async {
    RequestOptions? request;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(
          requestOptions: options,
          statusCode: 200,
          data: {'success': false, 'message': 'خطای ثبت'}));
    }));
    final repository =
        ResidentPatientRepository(dio: dio, userId: () async => '9');
    await tester.pumpWidget(MaterialApp(
        home: LaboratoryScreen(
      patient: ModelPatient.fromJson({'id': 42, 'fullName': 'بیمار نمونه'}),
      onSubmit: (answers) => repository.saveLab('42', answers, update: false),
    )));
    await tester.enterText(find.byKey(const ValueKey('lab-Cr')), '۱٫۵');
    await tester.tap(find.widgetWithText(FilledButton, 'ثبت نتایج آزمایش'));
    await tester.pump();
    expect(request, isNull);
    await tester.ensureVisible(find.text('نتیجه تروپونین را انتخاب کنید.'));
    expect(find.text('نتیجه تروپونین را انتخاب کنید.'), findsOneWidget);
    await tester.tap(find.text('مثبت'));
    await tester.tap(find.widgetWithText(FilledButton, 'ثبت نتایج آزمایش'));
    await tester.pumpAndSettle();
    expect(request!.path, '/Patients/AddLabResult');
    final fields = Map.fromEntries((request!.data as FormData).fields);
    expect(fields['Cr'], '1.5');
    expect(fields['Trop'], 'true');
    expect(fields['patientId'], '42');
    expect(fields['userId'], '9');
    await tester.ensureVisible(find.text('خطای ثبت'));
    expect(find.text('خطای ثبت'), findsOneWidget);
    expect(find.text('۱٫۵'), findsOneWidget);
  });

  testWidgets('loads prior results and sends edits to update endpoint',
      (tester) async {
    RequestOptions? request;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      request = options;
      handler.resolve(Response(
          requestOptions: options, statusCode: 200, data: {'success': false}));
    }));
    final repository =
        ResidentPatientRepository(dio: dio, userId: () async => '9');
    await tester.pumpWidget(MaterialApp(
        home: LaboratoryScreen(
      patient: ModelPatient.fromJson({
        'id': 42,
        'labIsComplete': true,
        'bun': '22',
        'pt': '13',
        'trop': true
      }),
      onSubmit: (answers) => repository.saveLab('42', answers, update: true),
    )));
    expect(find.text('۲۲'), findsOneWidget);
    await tester.ensureVisible(find.text('منفی'));
    await tester.tap(find.text('منفی'));
    await tester.tap(find.text('ثبت ویرایش نتایج'));
    await tester.pumpAndSettle();
    expect(request!.path, '/Patients/UpdateLabResult');
    final fields = Map.fromEntries((request!.data as FormData).fields);
    expect(fields['BUN'], '22');
    expect(fields['PT'], '13');
    expect(fields['Trop'], 'false');
  });
}
