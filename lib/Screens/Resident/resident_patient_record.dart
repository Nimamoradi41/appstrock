import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/AppConfig.dart';
import '../../features/patients/ui/resident/PatientCodeDecision.dart';
import '../../features/patients/ui/resident/PatientElapsedTimes.dart';
import '../../features/patients/ui/resident/PatientIdentityCard.dart';
import '../../features/patients/ui/resident/PatientMeasurement.dart';
import '../../features/patients/ui/resident/PatientRecordHeader.dart';
import '../../features/patients/ui/resident/PatientRecordRow.dart';
import '../../features/patients/ui/resident/PatientRecordSteps.dart';
import '../../features/patients/ui/resident/PatientUploadButton.dart';
import '../../features/patients/ui/resident/not_724_reasons.dart';
import '../../features/patients/ui/resident/patient_record_dates.dart';
import '../../features/patients/ui/resident/patient_medications_card.dart';
import '../../features/patients/data/resident_patient_repository.dart';
import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';

class ResidentPatientRecord extends StatelessWidget {
  const ResidentPatientRecord({
    super.key,
    required this.patient,
    required this.elapsedSinceRegistration,
    required this.elapsedSinceSymptoms,
    required this.onBack,
    required this.onActions,
    required this.onImages,
    required this.onNihss,
    required this.onLaboratory,
    required this.onInjectionTime,
    required this.onBloodPressure,
    required this.onBloodSugar,
    required this.onIs724,
    required this.onIsNot724,
    required this.onSaveNot724Reasons,
    required this.onNot724ReasonsSaved,
    this.statusSubmitting = false,
  });

  final ModelPatient patient;
  final Duration elapsedSinceRegistration;
  final Duration elapsedSinceSymptoms;
  final VoidCallback onBack;
  final VoidCallback onActions;
  final VoidCallback onImages;
  final VoidCallback onNihss;
  final VoidCallback onLaboratory;
  final VoidCallback onInjectionTime;
  final VoidCallback onBloodPressure;
  final VoidCallback onBloodSugar;
  final VoidCallback onIs724;
  final VoidCallback onIsNot724;
  final Future<PatientOperationResult> Function(bool, bool, bool)
      onSaveNot724Reasons;
  final VoidCallback onNot724ReasonsSaved;
  final bool statusSubmitting;

  @override
  Widget build(BuildContext context) {
    final active = patient.is724IsComplete == true && !patient.isNot724;
    final pending = patient.is724IsComplete != true &&
        !patient.isNot724 &&
        patient.isFinished != true;
    final step = patient.isFinished == true ||
            (patient.timeOfInjection?.isNotEmpty ?? false)
        ? 4
        : patient.injectionType != null && patient.injectionType != 0
            ? 3
            : active || patient.nihsIsComplete
                ? 2
                : 1;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xffeaf0f7),
        body: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    color: const Color(0xfffbfcfe),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x220f2943),
                          blurRadius: 14,
                          offset: Offset(0, 5))
                    ]),
                child: Column(children: [
                  const PatientRecordHeader(),
                  Expanded(
                      child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(children: [
                            IconButton(
                                onPressed: onBack,
                                icon: const Icon(Icons.arrow_forward,
                                    color: AppConfig.inkColorResident),
                                tooltip: 'بازگشت'),
                            const Text('پرونده بیمار',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.inkColorResident)),
                          ]),
                          const SizedBox(height: 6),
                          PatientIdentityCard(patient: patient, active: active),
                          if (pending) ...[
                            const SizedBox(height: 10),
                            PatientCodeDecision(
                              onIs724: onIs724,
                              onIsNot724: onIsNot724,
                              submitting: statusSubmitting,
                            ),
                          ],
                          if (patient.isFinished != true) ...[
                            const SizedBox(height: 10),
                            PatientElapsedTimes(
                                patient: patient,
                                elapsedSinceRegistration:
                                    elapsedSinceRegistration,
                                elapsedSinceSymptoms: elapsedSinceSymptoms),
                          ],
                          const SizedBox(height: 16),
                          if (patient.isNot724)
                            PatientRecordSteps(
                              step: 3,
                              labels: const [
                                'ثبت بیمار',
                                'عدم احراز ۷۲۴',
                                'ثبت دلایل'
                              ],
                              completed: patient.isNot724IsComplete == true,
                            )
                          else
                            PatientRecordSteps(step: step),
                          const Divider(
                              height: 25, color: AppConfig.borderColorResident),
                          if (pending) ...[
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: const Color(0xffeef4fa),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: const Color(0xffcdddeb)),
                              ),
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.lock_outline, color: AppConfig.tealColorResident, size: 21),
                                  SizedBox(width: 10),
                                  Expanded(child: Text(
                                    'برای دسترسی به اقدامات پرونده، ابتدا وضعیت کد ۷۲۴ بیمار را مشخص کنید.',
                                    style: TextStyle(color: AppConfig.inkColorResident, fontSize: 13),
                                  )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            PatientRecordDates(patient: patient),
                          ] else if (patient.isNot724) ...[
                            PatientRecordDates(patient: patient),
                            const SizedBox(height: 12),
                            Not724ReasonsCard(
                                patient: patient,
                                onAddReasons: () async {
                                  final saved =
                                      await showModalBottomSheet<bool>(
                                    context: context,
                                    isScrollControlled: true,
                                    isDismissible: false,
                                    enableDrag: false,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    builder: (_) => Not724ReasonsForm(
                                        onSubmit: onSaveNot724Reasons),
                                  );
                                  if (saved == true && context.mounted) {
                                    onNot724ReasonsSaved();
                                  }
                                }),
                          ]
                          else ...[
                            const Text('ارزیابی و بررسی‌ها',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.inkColorResident)),
                            const SizedBox(height: 10),
                            Row(children: [
                              Expanded(
                                  child: PatientMeasurement(
                                      title: 'NIHSS',
                                      onTap: onNihss,
                                      value: patient.nihsIsComplete
                                          ? AppConfig.digits(
                                              '${patient.nihsSubscore}')
                                          : '—')),
                              const SizedBox(width: 8),
                              Expanded(
                                  child: PatientMeasurement(
                                      title: 'فشار خون',
                                      onTap: onBloodPressure,
                                      value: (patient.bloodPressure1 ?? 0) > 0
                                          ? AppConfig.digits(
                                              '${patient.bloodPressure1}/${patient.bloodPressure2 ?? '—'}')
                                          : '—')),
                            ]),
                            const SizedBox(height: 8),
                            InkWell(
                                onTap: onBloodSugar,
                                borderRadius: BorderRadius.circular(9),
                                child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 9),
                                decoration: BoxDecoration(
                                    color: const Color(0xffeaf1f5),
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(
                                        color: AppConfig.borderColorResident)),
                                child: Row(children: [
                                  const Text('قند خون',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppConfig.inkColorResident)),
                                  const Spacer(),
                                  Text(
                                      (patient.bs ?? 0) > 0
                                          ? '${patient.bs} mg/dL'
                                          : '—',
                                      textDirection: TextDirection.ltr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 19,
                                          color: AppConfig.inkColorResident)),
                                ]))),
                            const SizedBox(height: 10),
                            Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: AppConfig.box(),
                                child: Column(children: [
                                  PatientRecordRow(
                                      title: 'آزمایشگاه',
                                      status: patient.labIsComplete
                                          ? 'تکمیل شده'
                                          : 'تکمیل نشده',
                                      action: patient.labIsComplete
                                          ? 'مشاهده فرم'
                                          : 'تکمیل فرم',
                                      onTap: onLaboratory,
                                      statusComplete: patient.labIsComplete),
                                  PatientRecordRow(
                                      title: 'تصویربرداری',
                                      status: patient.needToCT && patient.needToMRI
                                          ? 'CT / MRI'
                                          : patient.needToCT
                                              ? 'CT'
                                              : patient.needToMRI
                                                  ? 'MRI'
                                                  : 'ثبت نشده',
                                      action: 'تصاویر',
                                      onTap: onImages),
                                  PatientRecordRow(
                                      title: 'دکتر متخصص',
                                      status: patient.seenByAttend == true
                                          ? 'مشاهده کرده'
                                          : 'مشاهده نکرده',
                                      statusComplete:
                                          patient.seenByAttend == true,
                                      action: 'جزئیات',
                                      onTap: onActions),
                                  PatientRecordRow(
                                      title: 'تصمیم تزریق',
                                      status: '',
                                      action: patient.injectionType == 1
                                          ? 'تزریق شود'
                                          : patient.injectionType == 2
                                              ? 'تزریق نشود'
                                              : 'هنوز ثبت نشده',
                                      onTap: onActions,
                                      last: !(active && patient.isFinished != true && patient.injectionType != 2 && (patient.timeOfInjection?.isEmpty ?? true))),
                                  if (active && patient.isFinished != true && patient.injectionType != 2 && (patient.timeOfInjection?.isEmpty ?? true))
                                    PatientRecordRow(title: 'زمان تزریق', status: 'ثبت نشده', action: 'ثبت زمان', onTap: onInjectionTime, last: true),
                                ])),
                            const SizedBox(height: 14),
                            PatientMedicationsCard(patient: patient),
                            const SizedBox(height: 14),
                            PatientRecordDates(patient: patient),
                            const SizedBox(height: 14),
                            PatientUploadButton(onPressed: onImages),
                          ],
                        ]),
                  )),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
