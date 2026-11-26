import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/features/patients/data/resident_patient_repository.dart';
import 'package:appstrock/features/patients/ui/resident/nihss_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';

void main() {
  testWidgets('submitting an edited assessment sends the update request', (tester) async {
    RequestOptions? sent;
    final dio = Dio(BaseOptions(baseUrl: 'https://example.test'));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      sent = options;
      handler.resolve(Response(requestOptions: options, statusCode: 200, data: {'success': false, 'message': 'خطای سرور'}));
    }));
    final repository = ResidentPatientRepository(dio: dio, userId: () async => '9');
    final fields = <String, dynamic>{'id': 42, 'nihsIsComplete': true};
    for (final key in ['n_1_a', 'n_1_b', 'n_1_c', 'n_2', 'n_3', 'n_4', 'n_5_a', 'n_5_b', 'n_6_a', 'n_6_b', 'n_7', 'n_8', 'n_9', 'n_10', 'n_11']) {
      fields[key] = '0';
    }
    await tester.pumpWidget(MaterialApp(home: NihssScreen(
      patient: ModelPatient.fromJson(fields),
      onSubmit: (answers, score) => repository.saveNihss('42', answers, score, update: true),
    )));
    await tester.tap(find.byKey(const ValueKey('nihss-0-2')));
    await tester.tap(find.text('ثبت ویرایش NIHSS'));
    await tester.pumpAndSettle();
    expect(sent!.path, '/Patients/UpdateNihsForm');
    final data = Map.fromEntries((sent!.data as FormData).fields);
    expect(data['N_1_a'], '2');
    expect(data['subscore'], '2');
    expect(data['patientId'], '42');
    await tester.ensureVisible(find.text('خطای سرور'));
    expect(find.text('خطای سرور'), findsOneWidget);
  });
  const titles = [
    'سطح هوشیاری',
    'پرسش‌های هوشیاری',
    'اجرای دستورات',
    'حرکت چشم‌ها',
    'میدان بینایی',
    'فلج صورت',
    'حرکت دست چپ',
    'حرکت دست راست',
    'حرکت پای چپ',
    'حرکت پای راست',
    'آتاکسی اندام',
    'حس',
    'زبان',
    'تکلم',
    'بی‌توجهی و خاموشی'
  ];

  testWidgets('submits selected answers without treating missing answers as zero',
      (tester) async {
    List<Map<String, dynamic>>? answers;
    int? score;
    await tester.pumpWidget(MaterialApp(
        home: NihssScreen(
      patient: ModelPatient.fromJson({'id': 1, 'fullName': 'بیمار نمونه'}),
      onSubmit: (values, total) async {
        answers = values;
        score = total;
        return const PatientOperationResult(false, 'خطای ثبت');
      },
    )));
    await tester.tap(find.text('ثبت ارزیابی NIHSS'));
    await tester.pump();
    expect(answers, isNull);
    await tester
        .ensureVisible(find.text('برای ثبت ارزیابی، حداقل یک بخش را پاسخ دهید.'));
    expect(find.text('برای ثبت ارزیابی، حداقل یک بخش را پاسخ دهید.'),
        findsOneWidget);
    await tester.ensureVisible(find.byKey(const ValueKey('nihss-0-1')));
    await tester.tap(find.byKey(const ValueKey('nihss-0-1')));
    await tester.tap(find.text('ثبت ارزیابی NIHSS'));
    await tester.pump();
    expect(answers!.length, 15);
    expect(answers![0]['selected_answer'], 1);
    expect(answers![1]['selected_answer'], isNull);
    expect(score, 1);
    expect(find.text('امتیاز جزئی'), findsOneWidget);
    for (var index = 0; index < titles.length; index++) {
      final title = find.text(titles[index]);
      await tester.ensureVisible(title);
      if (index >= 3) {
        await tester.tap(title);
        await tester.pump();
      }
      final option = find.byKey(ValueKey('nihss-$index-${index == 6 ? 4 : 1}'));
      await tester.ensureVisible(option);
      await tester.tap(option);
      await tester.pump();
    }
    await tester.tap(find.text('ثبت ارزیابی NIHSS'));
    await tester.pump();
    expect(answers!.length, 15);
    expect(answers![6]['selected_answer'], 4);
    expect(score, 18);
    await tester.ensureVisible(find.text('خطای ثبت'));
    expect(find.text('خطای ثبت'), findsOneWidget);
  });

  testWidgets('loads saved values for editing without trusting stored total',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: NihssScreen(
      patient: ModelPatient.fromJson({
        'id': 1,
        'nihsIsComplete': true,
        'n_1_a': '2',
        'n_1_b': '1',
        'nihsSubscore': 99
      }),
      onSubmit: (_, __) async => const PatientOperationResult(true, ''),
    )));
    expect(find.text('۳'), findsWidgets);
    expect(find.text('۲ از ۱۵ بخش تکمیل شده'), findsOneWidget);
    expect(find.text('ثبت ویرایش NIHSS'), findsOneWidget);
    expect(find.text('برای پاسخ به تحریک مکرر یا دردناک نیاز دارد'),
        findsOneWidget);
  });
}
