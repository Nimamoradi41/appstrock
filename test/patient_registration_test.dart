import 'package:appstrock/features/patient_registration/model/patient_registration.dart';
import 'package:appstrock/features/patient_registration/data/patient_repository.dart';
import 'package:appstrock/features/patient_registration/ui/patient_registration_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shamsi_date/shamsi_date.dart';

void main() {
  testWidgets('registers unidentified resident without identity fields', (tester) async {
    SharedPreferences.setMockInitialValues({'UserId': '42'});
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? sent;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      sent = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true, 'message': ''}));
    }));
    await tester.pumpWidget(MaterialApp(home: PatientRegistrationScreen(
      source: PatientRegistrationSource.resident, shiftActive: true,
      onChangeShift: (_) {}, onExit: () {}, onEditProfile: () {},
      notificationButton: const SizedBox.shrink(), repository: PatientRepository(dio: dio),
    )));
    await tester.ensureVisible(find.byKey(const ValueKey('without-info')));
    await tester.tap(find.byKey(const ValueKey('without-info')));
    await tester.pumpAndSettle();
    expect(find.byType(TextFormField), findsNothing);
    await tester.ensureVisible(find.text('ثبت و اطلاع به رزیدنت'));
    await tester.tap(find.text('ثبت و اطلاع به رزیدنت'));
    await tester.pumpAndSettle();
    final fields = Map.fromEntries((sent!.data as FormData).fields);
    expect(fields['typeInput'], '4');
    expect(fields['WithoutInfo'], 'true');
    expect(fields.containsKey('FullName'), isFalse);
    expect(fields.containsKey('GenderId'), isFalse);
    expect(fields['Date'], isNotEmpty);
    expect(fields['insertTimeTs'], isNotEmpty);
  });
  for (final source in [PatientRegistrationSource.triage, PatientRegistrationSource.ems, PatientRegistrationSource.resident]) {
    testWidgets('registers using button press time for $source', (tester) async {
      SharedPreferences.setMockInitialValues({'UserId': '42'});
      final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
      RequestOptions? sent;
      dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        sent = options;
        handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true, 'message': ''}));
      }));
      await tester.pumpWidget(MaterialApp(home: PatientRegistrationScreen(
        source: source, shiftActive: true, onChangeShift: (_) {}, onExit: () {},
        onEditProfile: () {}, notificationButton: const SizedBox.shrink(),
        repository: PatientRepository(dio: dio),
      )));
      await tester.enterText(find.byType(TextFormField).first, 'بیمار نمونه');
      final button = find.text('ثبت و اطلاع به رزیدنت');
      await tester.ensureVisible(button);
      final before = DateTime.now().millisecondsSinceEpoch;
      await tester.tap(button);
      await tester.pumpAndSettle();
      final after = DateTime.now().millisecondsSinceEpoch;
      final fields = Map.fromEntries((sent!.data as FormData).fields);
      expect(int.parse(fields['insertTimeTs']!), inInclusiveRange(before, after));
      expect(fields['typeInput'], source.apiValue);
    });
  }

  testWidgets('manual date and time are required and sent together', (tester) async {
    SharedPreferences.setMockInitialValues({'UserId': '42'});
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    RequestOptions? sent;
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      sent = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': true, 'message': ''}));
    }));
    await tester.pumpWidget(MaterialApp(home: PatientRegistrationScreen(
      source: PatientRegistrationSource.triage, shiftActive: true,
      onChangeShift: (_) {}, onExit: () {}, onEditProfile: () {},
      notificationButton: const SizedBox.shrink(), repository: PatientRepository(dio: dio),
    )));
    await tester.enterText(find.byType(TextFormField).first, 'بیمار نمونه');
    await tester.ensureVisible(find.text('انتخاب تاریخ و ساعت'));
    await tester.tap(find.text('انتخاب تاریخ و ساعت'));
    await tester.pumpAndSettle();
    final submit = find.text('ثبت و اطلاع به رزیدنت');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pumpAndSettle();
    expect(sent, isNull);
    await tester.ensureVisible(find.text('تاریخ و ساعت ثبت را انتخاب کنید.'));
    expect(find.text('تاریخ و ساعت ثبت را انتخاب کنید.'), findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('registration-date')));
    await tester.tap(find.byKey(const ValueKey('registration-date')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('تأیید'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('registration-time')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('تأیید'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pumpAndSettle();
    final fields = Map.fromEntries((sent!.data as FormData).fields);
    final selected = DateTime.fromMillisecondsSinceEpoch(int.parse(fields['insertTimeTs']!));
    final date = Jalali.fromDateTime(selected);
    expect(fields['Date'], '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}');
    expect(selected.second, 0);
  });
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

  testWidgets('resident registration displays its source and back button', (tester) async {
    await tester.pumpWidget(MaterialApp(home: PatientRegistrationScreen(
      source: PatientRegistrationSource.resident,
      shiftActive: true, onChangeShift: (_) {}, onExit: () {}, onEditProfile: () {},
      notificationButton: const SizedBox.shrink(), showBackButton: true,
    )));
    expect(find.text('رزیدنت'), findsWidgets);
    expect(find.byTooltip('بازگشت'), findsOneWidget);
    expect(PatientRegistrationSource.resident.apiValue, '4');
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
