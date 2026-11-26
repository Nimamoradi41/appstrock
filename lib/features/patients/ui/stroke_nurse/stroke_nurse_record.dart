import 'package:flutter/material.dart';

import '../../../../Screens/Atend/ScreenListImages.dart';
import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../../data/resident_patient_repository.dart';
import '../resident/PatientElapsedTimes.dart';
import '../resident/PatientIdentityCard.dart';
import '../resident/PatientRecordHeader.dart';
import '../resident/PatientRecordSteps.dart';
import '../resident/injection_time_screen.dart';
import '../resident/nihss_screen.dart';
import '../resident/patient_medications_card.dart';
import '../resident/patient_record_dates.dart';
import '../resident/patient_vitals_screen.dart';
import '../resident/not_724_reasons.dart';

class StrokeNurseRecord extends StatefulWidget {
  const StrokeNurseRecord(
      {super.key,
      required this.patient,
      required this.from,
      required this.to,
      this.repository});

  final ModelPatient patient;
  final String from, to;
  final ResidentPatientRepository? repository;

  @override
  State<StrokeNurseRecord> createState() => _StrokeNurseRecordState();
}

class _StrokeNurseRecordState extends State<StrokeNurseRecord> {
  late final ResidentPatientRepository _repository;
  late ModelPatient _patient;
  bool _loading = false;
  int _generation = 0;
  String? _error;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? ResidentPatientRepository();
    _patient = widget.patient;
    _refresh();
  }

  Future<void> _refresh() async {
    final generation = ++_generation;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final patient = await _repository.getPatient(
          patientId: widget.patient.id, from: widget.from, to: widget.to);
      if (mounted && generation == _generation) {
        setState(() => _patient = patient);
      }
    } catch (_) {
      if (mounted && generation == _generation) {
        setState(() => _error = 'دریافت اطلاعات جدید پرونده ناموفق بود.');
      }
    } finally {
      if (mounted && generation == _generation) {
        setState(() => _loading = false);
      }
    }
  }

  Future<void> _openVitals(PatientVital vital) async {
    if (_loading || _error != null) return;
    await _refresh();
    if (!mounted || _error != null) return;
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(
        builder: (_) => PatientVitalsScreen(
              patient: _patient,
              vital: vital,
              onSubmit: (first, second) => vital == PatientVital.bloodPressure
                  ? _repository.saveBloodPressure(
                      '${_patient.id}', first, second!)
                  : _repository.saveBloodSugar('${_patient.id}', first),
            )));
    if (saved == true && mounted) await _refresh();
  }

  Future<void> _openInjection() async {
    if (_loading || _error != null) return;
    await _refresh();
    if (!mounted || _error != null) return;
    if (_loading ||
        _error != null ||
        _patient.isFinished == true ||
        _patient.is724IsComplete != true ||
        _patient.isNot724 ||
        _patient.injectionType == 2 ||
        (_patient.timeOfInjection?.trim().isNotEmpty ?? false)) {
      return;
    }
    final saved = await Navigator.of(context).push<bool>(MaterialPageRoute(
        builder: (_) => InjectionTimeScreen(
              patient: _patient,
              onSubmit: (time, timestamp, medicine) => _repository
                  .saveInjection('${_patient.id}', time, timestamp, medicine),
            )));
    if (saved == true && mounted) await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final patient = _patient;
    final active = patient.is724IsComplete == true && !patient.isNot724;
    final finished = patient.isFinished == true;
    final canInject = active &&
        !finished &&
        patient.injectionType != 2 &&
        (patient.timeOfInjection?.trim().isEmpty ?? true);
    final step = finished || (patient.timeOfInjection?.isNotEmpty ?? false)
        ? 4
        : (patient.injectionType ?? 0) != 0
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
                          if (_loading)
                            const LinearProgressIndicator(minHeight: 2),
                          Expanded(
                              child: RefreshIndicator(
                                  onRefresh: _refresh,
                                  child: ListView(
                                      padding: const EdgeInsets.fromLTRB(
                                          14, 12, 14, 16),
                                      children: [
                                        Row(children: [
                                          IconButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              icon: const Icon(
                                                  Icons.arrow_forward),
                                              tooltip: 'بازگشت'),
                                          const Expanded(
                                              child: Text('پرونده بیمار',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppConfig
                                                          .inkColorResident))),
                                          IconButton(
                                              onPressed:
                                                  _loading ? null : _refresh,
                                              icon: const Icon(Icons.refresh),
                                              tooltip: 'به‌روزرسانی')
                                        ]),
                                        if (_error != null)
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(_error!,
                                                  style: const TextStyle(
                                                      color: Colors.red))),
                                        PatientIdentityCard(
                                            patient: patient, active: active),
                                        if (patient.isNot724) ...[
                                          const SizedBox(height: 12),
                                          Container(
                                              decoration: AppConfig.box(),
                                              padding: const EdgeInsets.all(12),
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    const Text(
                                                        'دلایل عدم احراز کد ۷۲۴',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    if (patient
                                                            .isNot724IsComplete !=
                                                        true)
                                                      const Text(
                                                          'دلایل ثبت نشده است.')
                                                    else if (patient
                                                                .misdiagnosisOfTriage !=
                                                            true &&
                                                        patient.misdiagnosisOfEms !=
                                                            true &&
                                                        patient.overTime !=
                                                            true)
                                                      const Text(
                                                          'دلیلی ثبت نشده است.')
                                                    else ...[
                                                      if (patient
                                                              .misdiagnosisOfTriage ==
                                                          true)
                                                        Text(not724ReasonLabels[
                                                            0]),
                                                      if (patient
                                                              .misdiagnosisOfEms ==
                                                          true)
                                                        Text(not724ReasonLabels[
                                                            1]),
                                                      if (patient.overTime ==
                                                          true)
                                                        Text(not724ReasonLabels[
                                                            2]),
                                                    ],
                                                  ])),
                                        ],
                                        if (!finished) ...[
                                          const SizedBox(height: 10),
                                          PatientElapsedTimes(
                                              patient: patient,
                                              elapsedSinceRegistration:
                                                  Duration.zero,
                                              elapsedSinceSymptoms:
                                                  Duration.zero)
                                        ],
                                        const SizedBox(height: 16),
                                        PatientRecordSteps(step: step),
                                        const Divider(height: 25),
                                        const Text('ارزیابی و بررسی‌ها',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: AppConfig
                                                    .inkColorResident)),
                                        const SizedBox(height: 10),
                                        Row(children: [
                                          Expanded(
                                              child: _valueTile(
                                                  'NIHSS',
                                                  patient.nihsIsComplete
                                                      ? AppConfig.digits(
                                                          '${patient.nihsSubscore}')
                                                      : '—',
                                                  null)),
                                          const SizedBox(width: 8),
                                          Expanded(
                                              child: _valueTile(
                                                  'فشار خون',
                                                  (patient.bloodPressure1 ??
                                                              0) >
                                                          0
                                                      ? AppConfig.digits(
                                                          '${patient.bloodPressure1}/${patient.bloodPressure2 ?? '—'}')
                                                      : '—',
                                                  () => _openVitals(PatientVital
                                                      .bloodPressure)))
                                        ]),
                                        const SizedBox(height: 8),
                                        _valueTile(
                                            'قند خون',
                                            (patient.bs ?? 0) > 0
                                                ? '${AppConfig.digits('${patient.bs}')} mg/dL'
                                                : '—',
                                            () => _openVitals(
                                                PatientVital.bloodSugar)),
                                        const SizedBox(height: 10),
                                        _actionRow(
                                            'جزئیات NIHSS',
                                            patient.nihsIsComplete
                                                ? 'مشاهده پاسخ‌ها'
                                                : 'ثبت نشده',
                                            () => Navigator.of(context)
                                                .push(MaterialPageRoute<void>(
                                                    builder: (_) => NihssScreen(
                                                          patient: patient,
                                                          readOnly: true,
                                                          onSubmit: (_,
                                                                  __) async =>
                                                              const PatientOperationResult(
                                                                  false,
                                                                  'امکان ویرایش وجود ندارد'),
                                                        )))),
                                        const SizedBox(height: 8),
                                        _details(
                                            'آزمایشگاه',
                                            patient.labIsComplete
                                                ? 'مشاهده نتایج'
                                                : 'ثبت نشده',
                                            [
                                              _detailRow('BUN', patient.bun),
                                              _detailRow('Cr', patient.cr),
                                              _detailRow('PLT', patient.plt),
                                              _detailRow('PT', patient.pt),
                                              _detailRow('PTT', patient.ptt),
                                              _detailRow('INR', patient.inr),
                                              _detailRow('Hb', patient.hb),
                                              _detailRow('WBC', patient.wbc),
                                              _detailRow(
                                                  'تروپونین',
                                                  patient.labIsComplete
                                                      ? (patient.trop
                                                          ? 'مثبت'
                                                          : 'منفی')
                                                      : '')
                                            ]),
                                        const SizedBox(height: 8),
                                        _actionRow(
                                            'تصویربرداری',
                                            patient.needToCT &&
                                                    patient.needToMRI
                                                ? 'CT / MRI'
                                                : patient.needToCT
                                                    ? 'CT'
                                                    : patient.needToMRI
                                                        ? 'MRI'
                                                        : 'ثبت نشده',
                                            () => Navigator.of(context).push(
                                                MaterialPageRoute<void>(
                                                    builder: (_) =>
                                                        ScreenListImages(
                                                            '${patient.id}')))),
                                        _staticRow(
                                            'دکتر متخصص',
                                            patient.seenByAttend == true
                                                ? 'مشاهده کرده'
                                                : 'مشاهده نکرده'),
                                        _staticRow(
                                            'تصمیم تزریق',
                                            patient.injectionType == 1
                                                ? 'تزریق شود'
                                                : patient.injectionType == 2
                                                    ? 'تزریق نشود'
                                                    : 'ثبت نشده'),
                                        if (canInject)
                                          _actionRow('زمان تزریق', 'ثبت زمان',
                                              _openInjection),
                                        const SizedBox(height: 14),
                                        PatientMedicationsCard(
                                            patient: patient),
                                        const SizedBox(height: 14),
                                        PatientRecordDates(patient: patient),
                                        if (patient.signsStartIsUnknown ==
                                            true) ...[
                                          const SizedBox(height: 12),
                                          _details('زمان‌های شروع نامشخص',
                                              'LKW و FSS', [
                                            _detailRow(
                                                'آخرین زمان بدون علامت (LKW)',
                                                '${patient.lkwDate} ${patient.lkwTime ?? ''}'),
                                            _detailRow(
                                                'اولین مشاهده علائم (FSS)',
                                                '${patient.fssDate ?? ''} ${patient.fssTime ?? ''}')
                                          ])
                                        ],
                                      ])))
                        ]),
                      )))),
        ));
  }

  Widget _valueTile(String title, String value, VoidCallback? onTap) =>
      Material(
          color: const Color(0xffeaf1f5),
          borderRadius: BorderRadius.circular(9),
          child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppConfig.borderColorResident),
                      borderRadius: BorderRadius.circular(9)),
                  child: Row(children: [
                    Expanded(
                        child: Text(title,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold))),
                    Text(value,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    if (onTap != null)
                      const Icon(Icons.edit_outlined,
                          size: 16, color: AppConfig.tealColorResident)
                  ]))));

  Widget _details(String title, String subtitle, List<Widget> children) =>
      Container(
          decoration: AppConfig.box(),
          child: ExpansionTile(
              title: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(children: children))
              ]));
  Widget _detailRow(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(children: [
        Expanded(child: Text(label, style: const TextStyle(fontSize: 12))),
        Flexible(
            child: Text(
                value.trim().isEmpty ? 'ثبت نشده' : AppConfig.digits(value),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))
      ]));
  Widget _staticRow(String title, String value) => Container(
      decoration: AppConfig.box(),
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      child: Row(children: [
        Expanded(
            child: Text(title,
                style: const TextStyle(fontWeight: FontWeight.bold))),
        Text(value, style: const TextStyle(fontSize: 12))
      ]));
  Widget _actionRow(String title, String value, VoidCallback onTap) =>
      Container(
          decoration: AppConfig.box(),
          margin: const EdgeInsets.only(top: 8),
          child: ListTile(
              dense: true,
              title: Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
              trailing: Text(value,
                  style: const TextStyle(
                      color: AppConfig.tealColorResident, fontSize: 12)),
              onTap: onTap));
}
