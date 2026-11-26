import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/Screens/Resident/resident_patient_record.dart';
import 'package:appstrock/features/patients/data/resident_patient_repository.dart';
import 'package:appstrock/features/patients/ui/resident/not_724_reasons.dart';
import 'package:appstrock/features/patients/ui/resident/patient_record_dates.dart';
import 'package:appstrock/features/patients/ui/resident/PatientRecordSteps.dart';
import 'package:appstrock/features/patients/ui/resident/PatientIdentityCard.dart';
import 'package:appstrock/core/AppConfig.dart';
import 'package:appstrock/features/patients/ui/resident/patient_medications_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'finished record hides timers, turns the identity box green and lists the upload button last',
      (tester) async {
    Widget record(Map<String, dynamic> fields) => MaterialApp(
            home: ResidentPatientRecord(
          patient: ModelPatient.fromJson(
              {'id': 1, 'is724IsComplete': true, ...fields}),
          elapsedSinceRegistration: const Duration(minutes: 5),
          elapsedSinceSymptoms: const Duration(minutes: 30),
          onBack: () {},
          onActions: () {},
          onImages: () {},
          onNihss: () {},
          onLaboratory: () {},
          onInjectionTime: () {},
          onBloodPressure: () {},
          onBloodSugar: () {},
          onIs724: () {},
          onIsNot724: () {},
          onSaveNot724Reasons: (_, __, ___) async =>
              const PatientOperationResult(true, ''),
          onNot724ReasonsSaved: () {},
        ));

    await tester.pumpWidget(record({}));
    expect(find.text('از ثبت'), findsOneWidget);
    expect(find.text('از شروع علائم'), findsOneWidget);
    expect(find.text('تکمیل شده'), findsNothing);

    await tester.pumpWidget(record({'isFinished': true, 'seenByAttend': true}));
    expect(find.text('از ثبت'), findsNothing);
    expect(find.text('از شروع علائم'), findsNothing);
    expect(
        tester
            .widget<PatientIdentityCard>(find.byType(PatientIdentityCard))
            .patient
            .isFinished,
        true);
    expect(find.text('تکمیل شده'), findsOneWidget);
    expect(find.text('دکتر متخصص مشاهده کرده'), findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color ==
                AppConfig.successSurfaceResident),
        findsOneWidget);

    final upload = tester.getTopLeft(find.text('آپلود عکس'));
    for (final label in ['زمان‌های پرونده', 'داروهای پرونده', 'قند خون']) {
      expect(upload.dy, greaterThan(tester.getTopLeft(find.text(label)).dy),
          reason: 'upload button must sit below $label');
    }
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('record uploads images and retains access to patient actions',
      (tester) async {
    var uploads = 0;
    var actions = 0;
    var assessments = 0;
    var laboratory = 0;
    var injection = 0;
    var pressure = 0;
    var sugar = 0;
    final patient = ModelPatient.fromJson({
      'id': 1,
      'fullName': 'بیمار نمونه',
      'isFinished': false,
      'is724IsComplete': true,
      'insertTimeTS': DateTime.now()
          .subtract(const Duration(minutes: 1))
          .millisecondsSinceEpoch,
    });

    await tester.pumpWidget(MaterialApp(
        home: ResidentPatientRecord(
      patient: patient,
      elapsedSinceRegistration: Duration.zero,
      elapsedSinceSymptoms: Duration.zero,
      onBack: () {},
      onActions: () => actions++,
      onImages: () => uploads++,
      onNihss: () => assessments++,
      onLaboratory: () => laboratory++,
      onInjectionTime: () => injection++,
      onBloodPressure: () => pressure++,
      onBloodSugar: () => sugar++,
      onIs724: () {},
      onIsNot724: () {},
      onSaveNot724Reasons: (_, __, ___) async =>
          const PatientOperationResult(true, ''),
      onNot724ReasonsSaved: () {},
    )));

    expect(find.text('رزیدنت'), findsNothing);
    expect(find.text('شیفت فعال'), findsNothing);
    expect(find.byIcon(Icons.more_vert), findsNothing);
    expect(find.text('تکمیل بررسی‌های بیمار'), findsNothing);
    await tester.tap(find.text('NIHSS'));
    expect(assessments, 1);
    await tester.tap(find.text('فشار خون'));
    await tester.tap(find.text('قند خون'));
    expect(pressure, 1);
    expect(sugar, 1);
    await tester.ensureVisible(find.text('آپلود عکس'));
    await tester.tap(find.text('آپلود عکس'));
    expect(uploads, 1);
    await tester.ensureVisible(find.text('آزمایشگاه'));
    await tester.tap(find.text('آزمایشگاه'));
    expect(laboratory, 1);
    expect(actions, 0);
    await tester.ensureVisible(find.text('زمان تزریق'));
    await tester.tap(find.text('زمان تزریق'));
    expect(injection, 1);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('724 decisions are available only while the status is pending',
      (tester) async {
    var is724 = 0;
    var isNot724 = 0;
    Widget record(Map<String, dynamic> fields) => MaterialApp(
            home: ResidentPatientRecord(
          patient: ModelPatient.fromJson({'id': 1, ...fields}),
          elapsedSinceRegistration: Duration.zero,
          elapsedSinceSymptoms: Duration.zero,
          onBack: () {},
          onActions: () {},
          onImages: () {},
          onNihss: () {},
          onLaboratory: () {},
          onInjectionTime: () {},
          onBloodPressure: () {},
          onBloodSugar: () {},
          onIs724: () => is724++,
          onIsNot724: () => isNot724++,
          onSaveNot724Reasons: (_, __, ___) async =>
              const PatientOperationResult(true, ''),
          onNot724ReasonsSaved: () {},
        ));

    await tester.pumpWidget(record({}));
    expect(find.byType(PatientMedicationsCard), findsNothing);
    expect(find.byType(PatientRecordDates), findsOneWidget);
    expect(tester.widget<PatientRecordSteps>(find.byType(PatientRecordSteps)).step, 1);
    expect(find.text('برای دسترسی به اقدامات پرونده، ابتدا وضعیت کد ۷۲۴ بیمار را مشخص کنید.'), findsOneWidget);
    expect(find.text('آپلود عکس'), findsNothing);
    expect(find.text('آزمایشگاه'), findsNothing);
    expect(find.text('تصویربرداری'), findsNothing);
    expect(find.text('تصمیم تزریق'), findsNothing);
    await tester.tap(find.text('کد ۷۲۴ است'));
    await tester.tap(find.text('کد ۷۲۴ نیست'));
    expect(is724, 1);
    expect(isNot724, 1);
    await tester.pumpWidget(record({'is724IsComplete': true}));
    expect(find.byType(PatientMedicationsCard), findsOneWidget);
    expect(find.byType(PatientRecordDates), findsOneWidget);
    expect(tester.widget<PatientRecordSteps>(find.byType(PatientRecordSteps)).step, 2);
    expect(find.text('آزمایشگاه'), findsOneWidget);
    expect(find.text('آپلود عکس'), findsOneWidget);
    expect(find.text('زمان تزریق'), findsOneWidget);
    await tester.pumpWidget(record({'is724IsComplete': true, 'needToCT': true}));
    expect(find.text('CT'), findsOneWidget);
    await tester.pumpWidget(record({'is724IsComplete': true, 'needToMRI': true}));
    expect(find.text('MRI'), findsOneWidget);
    await tester.pumpWidget(record({'is724IsComplete': true, 'needToCT': true, 'needToMRI': true}));
    expect(find.text('CT / MRI'), findsOneWidget);
    await tester.pumpWidget(record({'is724IsComplete': true, 'injectionType': 2}));
    expect(find.text('زمان تزریق'), findsNothing);
    await tester.pumpWidget(record({'is724IsComplete': true, 'timeOfInjection': '12:00'}));
    expect(find.text('زمان تزریق'), findsOneWidget);
    expect(find.text('۱۲:۰۰'), findsOneWidget);
    expect(find.text('ثبت زمان'), findsNothing);
    for (final fields in [
      {'is724IsComplete': true},
      {'isNot724': true},
      {'isFinished': true},
    ]) {
      await tester.pumpWidget(record(fields));
      expect(find.text('کد ۷۲۴ است'), findsNothing);
      expect(find.text('کد ۷۲۴ نیست'), findsNothing);
    }
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('non-724 record submits reasons and displays saved reasons',
      (tester) async {
    var submissions = 0;
    var refreshed = 0;
    List<bool>? submitted;
    Widget record(Map<String, dynamic> fields) => MaterialApp(
            home: ResidentPatientRecord(
          patient:
              ModelPatient.fromJson({'id': 1, 'isNot724': true, ...fields}),
          elapsedSinceRegistration: Duration.zero,
          elapsedSinceSymptoms: Duration.zero,
          onBack: () {},
          onActions: () {},
          onImages: () {},
          onNihss: () {},
          onLaboratory: () {},
          onInjectionTime: () {},
          onBloodPressure: () {},
          onBloodSugar: () {},
          onIs724: () {},
          onIsNot724: () {},
          onSaveNot724Reasons: (triage, ems, overtime) async {
            submissions++;
            submitted = [triage, ems, overtime];
            return submissions == 1
                ? const PatientOperationResult(false, 'خطای ثبت')
                : const PatientOperationResult(true, '');
          },
          onNot724ReasonsSaved: () => refreshed++,
        ));

    await tester.pumpWidget(record({}));
    expect(find.text('ارزیابی و بررسی‌ها'), findsNothing);
    expect(find.text('NIHSS'), findsNothing);
    expect(find.text('عدم احراز ۷۲۴'), findsOneWidget);
    final addReasons = find.descendant(of: find.byType(Not724ReasonsCard), matching: find.text('ثبت دلایل'));
    await tester.ensureVisible(addReasons);
    await tester.tap(addReasons);
    await tester.pumpAndSettle();
    final submit = find.descendant(of: find.byType(Not724ReasonsForm), matching: find.text('ثبت دلایل'));
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(find.text('حداقل یک دلیل را انتخاب کنید.'), findsOneWidget);
    await tester.tap(find.text('تشخیص اشتباه در تریاژ'));
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pump();
    expect(submitted, [true, false, false]);
    expect(find.text('خطای ثبت'), findsOneWidget);
    await tester.tap(submit);
    await tester.pumpAndSettle();
    expect(refreshed, 1);

    await tester.pumpWidget(record({
      'isNot724IsComplete': true,
      'misdiagnosisOfTriage': true,
      'overTime': true
    }));
    expect(find.text('تشخیص اشتباه در تریاژ'), findsOneWidget);
    expect(
        find.text('گذشت بیش از چهار ساعت و نیم از شروع علائم'), findsOneWidget);
    expect(find.text('ارزیابی و بررسی‌ها'), findsNothing);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('non-724 record shows registration and completion dates', (tester) async {
    Widget record(Map<String, dynamic> fields) => MaterialApp(home: ResidentPatientRecord(
      patient: ModelPatient.fromJson({'id': 1, 'isNot724': true, ...fields}),
      elapsedSinceRegistration: Duration.zero, elapsedSinceSymptoms: Duration.zero,
      onBack: () {}, onActions: () {}, onImages: () {}, onNihss: () {}, onLaboratory: () {}, onInjectionTime: () {}, onBloodPressure: () {}, onBloodSugar: () {}, onIs724: () {}, onIsNot724: () {},
      onSaveNot724Reasons: (_, __, ___) async => const PatientOperationResult(true, ''),
      onNot724ReasonsSaved: () {},
    ));

    await tester.pumpWidget(record({}));
    expect(find.byType(PatientRecordDates), findsOneWidget);
    expect(find.text('نامشخص'), findsNWidgets(2));
    expect(find.text('ثبت نشده'), findsOneWidget);

    await tester.pumpWidget(record({
      'timeOfAddToSystem': '14:08', 'dateOfAddToSystem': '1405/09/04',
      'dateFinishShamsi': '1405/09/04', 'timeFinish': '15:23',
    }));
    expect(find.text('۱۴:۰۸'), findsOneWidget);
    expect(find.text('۱۴۰۵/۰۹/۰۴'), findsOneWidget);
    expect(find.text('۱۴۰۵/۰۹/۰۴  •  ۱۵:۲۳'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('record dates follow availability and laboratory completion', (tester) async {
    Widget dates(Map<String, dynamic> fields) => MaterialApp(home: Scaffold(body: PatientRecordDates(
      patient: ModelPatient.fromJson({'id': 1, ...fields}),
    )));
    await tester.pumpWidget(dates({'signsStartDate': '1405/09/01', 'labInsertDate': '1405/09/02', 'otn': '', 'dtn': ''}));
    expect(find.text('تاریخ ثبت در سیستم'), findsOneWidget);
    expect(find.text('زمان و تاریخ شروع علائم'), findsNothing);
    expect(find.text('زمان ثبت فرم آزمایشگاه'), findsNothing);
    expect(find.text('OTN'), findsNothing);
    expect(find.text('DTN'), findsNothing);

    await tester.pumpWidget(dates({
      'dateOfAddToSystem': '1405/09/02', 'signsStartDate': '1405/09/01',
      'signsStartTime': '13:05', 'labIsComplete': true,
      'labInsertDate': '1405/09/02', 'labInsertTime': '15:10',
      'otn': '45', 'dtn': '70',
    }));
    expect(find.text('۱۴۰۵/۰۹/۰۲'), findsOneWidget);
    expect(find.text('۱۴۰۵/۰۹/۰۱  •  ۱۳:۰۵'), findsOneWidget);
    expect(find.text('۱۴۰۵/۰۹/۰۲  •  ۱۵:۱۰'), findsOneWidget);
    expect(find.text('OTN'), findsOneWidget);
    expect(find.text('۴۵'), findsOneWidget);
    expect(find.text('DTN'), findsOneWidget);
    expect(find.text('۷۰'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('shows proposed and administered medicines independently', (tester) async {
    Widget card(Map<String, dynamic> fields) => MaterialApp(home: Scaffold(
      body: PatientMedicationsCard(patient: ModelPatient.fromJson({'id': 1, ...fields})),
    ));
    await tester.pumpWidget(card({}));
    expect(find.text('داروی پیشنهادی متخصص'), findsOneWidget);
    expect(find.text('داروی تزریق‌شده'), findsOneWidget);
    expect(find.text('ثبت نشده'), findsNWidgets(2));
    await tester.pumpWidget(card({'recommendedMedication': 2, 'medicine': 1}));
    expect(find.text('تنکتپلاز'), findsOneWidget);
    expect(find.text('آلتپلاز'), findsOneWidget);
    await tester.pumpWidget(card({'medicine': 1, 'timeOfInjection': '08:05'}));
    expect(find.text('زمان تزریق'), findsOneWidget);
    expect(find.text('۰۸:۰۵'), findsOneWidget);
    await tester.pumpWidget(card({'recommendedMedication': 3, 'medicine': 99}));
    expect(find.text('آلتلایز (ایرانی)'), findsOneWidget);
    expect(find.text('نامشخص'), findsOneWidget);
  });
}
