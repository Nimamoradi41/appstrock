import 'package:appstrock/Screens/PatientRegistration/model/patient_registration.dart';
import 'package:appstrock/Screens/PatientRegistration/data/patient_repository.dart';
import 'package:appstrock/Screens/PatientRegistration/ui/patient_registration_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('repository posts the documented multipart fields to Patients',
      () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? sent;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      sent = options;
      handler.resolve(Response<dynamic>(
          requestOptions: options,
          statusCode: 200,
          data: {'success': true, 'message': ''}));
    }));
    final patient = PatientRegistration(
      fullName: 'بیمار نمونه',
      nationalCode: '',
      age: '',
      genderId: 2,
      source: PatientRegistrationSource.triage,
      registeredDate: '1402/08/23',
      registeredAt: DateTime.fromMillisecondsSinceEpoch(1700000000000),
      registeredBy: '42',
    );
    final response = await PatientRepository(dio: dio).register(patient);
    expect(response.success, isTrue);
    expect(sent!.path, '/Patients');
    expect(sent!.method, 'POST');
    expect(
        Map.fromEntries((sent!.data as FormData).fields), patient.toFields());
  });

  test('patient request preserves registration source and timestamps', () {
    final date = DateTime.fromMillisecondsSinceEpoch(1700000000000);
    for (final source in PatientRegistrationSource.values) {
      final patient = PatientRegistration(
        fullName: 'بیمار نمونه',
        nationalCode: '0012345678',
        age: '64',
        genderId: 2,
        source: source,
        registeredDate: '1402/08/23',
        registeredAt: date,
        registeredBy: '42',
      );
      expect(patient.toFields(), {
        'FullName': 'بیمار نمونه',
        'Date': '1402/08/23',
        'NationalCode': '0012345678',
        'Age': '64',
        'typeInput': source.apiValue,
        'GenderId': '2',
        'InsertBy': '42',
        'insertTimeTs': '1700000000000',
      });
    }
  });

  testWidgets('account menu opens profile editing and keeps logout',
      (tester) async {
    var edited = false;
    await tester.pumpWidget(MaterialApp(
        home: PatientRegistrationScreen(
      source: PatientRegistrationSource.triage,
      shiftActive: true,
      onChangeShift: (_) {},
      onExit: () {},
      onEditProfile: () => edited = true,
      notificationButton: const SizedBox.shrink(),
    )));
    expect(find.text('انصراف'), findsNothing);
    expect(find.byType(TextFormField), findsNWidgets(3));
    await tester.tap(find.byTooltip('حساب کاربری'));
    await tester.pumpAndSettle();
    expect(find.text('خروج از حساب'), findsOneWidget);
    await tester.tap(find.text('ویرایش حساب کاربری'));
    await tester.pumpAndSettle();
    expect(edited, isTrue);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
      'national code accepts Persian digits and preserves leading zeros',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: PatientRegistrationScreen(
        source: PatientRegistrationSource.ems,
        shiftActive: true,
        onChangeShift: (_) {},
        onExit: () {},
        onEditProfile: () {},
        notificationButton: const SizedBox.shrink(),
      ),
    ));
    final fields = find.byType(TextField);
    await tester.ensureVisible(fields.at(1));
    await tester.enterText(fields.at(1), '۰۰۱۲۳۴۵۶۷۸');
    expect(
        tester.widget<TextField>(fields.at(1)).controller!.text, '0012345678');
    await tester.pumpWidget(const SizedBox.shrink());
  });
  testWidgets('form fits a narrow mobile screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(320, 640));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      home: PatientRegistrationScreen(
        source: PatientRegistrationSource.ems,
        shiftActive: true,
        onChangeShift: (_) {},
        onExit: () {},
        onEditProfile: () {},
        notificationButton:
            const IconButton(onPressed: null, icon: Icon(Icons.notifications)),
      ),
    ));
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
