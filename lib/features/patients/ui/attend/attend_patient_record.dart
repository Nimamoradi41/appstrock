import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';

import '../resident/PatientElapsedTimes.dart';
import '../resident/PatientIdentityCard.dart';
import '../resident/PatientRecordRow.dart';
import '../resident/PatientUploadButton.dart';
import '../resident/patient_medications_card.dart';
import '../resident/patient_record_dates.dart';

const _navy = AppConfig.inkColorResident;
const _teal = AppConfig.tealColorResident;
const _line = AppConfig.borderColorResident;
const _warningBackground = Color(0xfffff2df);
const _warningBorder = Color(0xffffc36c);
const _warningInk = Color(0xffa85a00);
const _infoBackground = Color(0xffeef4fa);
const _infoBorder = Color(0xffcdddeb);

/// Full page record used by the attending physician.
///
/// The specialist reviews the patient, confirms that the file was seen and
/// opens the imaging, laboratory and injection information from one screen.
class AttendPatientRecord extends StatelessWidget {
  const AttendPatientRecord({
    super.key,
    required this.patient,
    required this.elapsedSinceRegistration,
    required this.elapsedSinceSymptoms,
    required this.onBack,
    required this.onRefresh,
    required this.onSeen,
    required this.onImages,
    required this.onNihss,
    required this.onLaboratory,
    required this.onBloodPressure,
    required this.onBloodSugar,
    required this.onInjectionTime,
    required this.onNeedCT,
    required this.onNeedMRI,
    required this.onToggleMT,
    this.onInjectionReasons,
    this.seenSubmitting = false,
    this.refreshing = false,
  });

  final ModelPatient patient;
  final Duration elapsedSinceRegistration;
  final Duration elapsedSinceSymptoms;
  final VoidCallback onBack;
  final VoidCallback onRefresh;
  final VoidCallback onSeen;
  final VoidCallback onImages;
  final VoidCallback onNihss;
  final VoidCallback onLaboratory;
  final VoidCallback onBloodPressure;
  final VoidCallback onBloodSugar;
  final VoidCallback onInjectionTime;
  final VoidCallback onNeedCT;
  final VoidCallback onNeedMRI;
  final VoidCallback onToggleMT;
  final VoidCallback? onInjectionReasons;
  final bool seenSubmitting;
  final bool refreshing;

  bool get _seen => patient.seenByAttend == true;
  bool get _active724 =>
      patient.is724IsComplete == true && patient.isNot724 != true;

  @override
  Widget build(BuildContext context) => Column(children: [
        _header(context),
        if (refreshing)
          const LinearProgressIndicator(minHeight: 2, color: _teal),
        Expanded(
            child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _title(),
                      const SizedBox(height: 8),
                      PatientIdentityCard(patient: patient, active: _active724),
                      const SizedBox(height: 12),
                      if (!_seen) ...[
                        _seenWarning(context),
                        const SizedBox(height: 12),
                      ],
                      _metrics(context),
                      if (patient.isFinished != true) ...[
                        const SizedBox(height: 12),
                        PatientElapsedTimes(
                            patient: patient,
                            elapsedSinceRegistration:
                                elapsedSinceRegistration,
                            elapsedSinceSymptoms: elapsedSinceSymptoms),
                      ],
                      const SizedBox(height: 16),
                      const Text('تصویربرداری و تصمیم درمان',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _navy)),
                      const SizedBox(height: 10),
                      _imagingCard(context),
                      const SizedBox(height: 14),
                      const Text('پرونده بالینی',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _navy)),
                      const SizedBox(height: 10),
                      _clinicalCard(),
                      const SizedBox(height: 14),
                      PatientMedicationsCard(patient: patient),
                      const SizedBox(height: 14),
                      PatientRecordDates(patient: patient),
                      const SizedBox(height: 14),
                      _guideBox(),
                      const SizedBox(height: 12),
                      PatientUploadButton(
                          onPressed: onImages,
                          label: 'نمایش عکس‌های ارسال شده'),
                    ]))),
      ]);

  Widget _header(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: _line))),
      child: Row(children: [
        Image.asset('web/icons/Icon-512.png', width: 28, height: 28),
        const SizedBox(width: 4),
        const Text('استروک',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: _navy)),
        const Spacer(),
        if (!_seen)
          TextButton.icon(
              onPressed: seenSubmitting ? null : onSeen,
              icon: seenSubmitting
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: _teal))
                  : const Icon(Icons.visibility_outlined,
                      size: 18, color: _teal),
              label: const Text('ثبت مشاهده',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: _teal))),
        IconButton(
            onPressed: onRefresh,
            tooltip: 'به‌روزرسانی',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.refresh, size: 20, color: _navy)),
      ]));

  Widget _title() => Row(children: [
        IconButton(
            onPressed: onBack,
            tooltip: 'بازگشت',
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.arrow_forward, color: _navy)),
        const Expanded(
            child: Text('پرونده بیمار',
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: _navy))),
        if (_seen)
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: AppConfig.successSurfaceResident,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppConfig.successBorderResident)),
              child: const Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.verified_outlined,
                    size: 14, color: AppConfig.successColorResident),
                SizedBox(width: 4),
                Text('مشاهده شده',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.successColorResident)),
              ])),
      ]);

  Widget _seenWarning(BuildContext context) => Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
          color: _warningBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _warningBorder)),
      child: Row(children: [
        const Icon(Icons.visibility_off_outlined,
            color: _warningInk, size: 20),
        const SizedBox(width: 8),
        const Expanded(
            child: Text('این پرونده هنوز توسط دکتر متخصص بررسی نشده است.',
                style: TextStyle(
                    color: _warningInk,
                    fontSize: 12,
                    fontWeight: FontWeight.bold))),
        TextButton(
            onPressed: seenSubmitting ? null : onSeen,
            style: TextButton.styleFrom(
                foregroundColor: _warningInk,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                minimumSize: const Size(0, 32),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap),
            child: const Text('ثبت مشاهده',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold))),
      ]));

  Widget _metrics(BuildContext context) => Row(children: [
        Expanded(
            child: _MetricTile(
                title: 'NIHSS',
                value: patient.nihsIsComplete
                    ? AppConfig.digits('${patient.nihsSubscore}')
                    : '—',
                icon: Icons.psychology_alt_outlined,
                accent: const Color(0xff007d83),
                background: const Color(0xffe5f5f2),
                onTap: onNihss)),
        const SizedBox(width: 8),
        Expanded(
            child: _MetricTile(
                title: 'فشار خون',
                value: (patient.bloodPressure1 ?? 0) > 0
                    ? AppConfig.digits(
                        '${patient.bloodPressure1}/${patient.bloodPressure2 ?? '—'}')
                    : '—',
                icon: Icons.monitor_heart_outlined,
                accent: const Color(0xffb56709),
                background: const Color(0xfffff2df),
                onTap: onBloodPressure,
                ltr: true)),
        const SizedBox(width: 8),
        Expanded(
            child: _MetricTile(
                title: 'قند خون',
                value: (patient.bs ?? 0) > 0
                    ? AppConfig.digits('${patient.bs} mg/dL')
                    : '—',
                icon: Icons.water_drop_outlined,
                accent: const Color(0xff1d6fb8),
                background: const Color(0xffe8f1fb),
                onTap: onBloodSugar,
                ltr: true)),
      ]);

  Widget _imagingCard(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: AppConfig.box(),
      child: Column(children: [
        Row(children: [
          const Text('درخواست تصویربرداری',
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.bold, color: _navy)),
          const Spacer(),
          Text(_imagingStatus,
              style: const TextStyle(fontSize: 12, color: Color(0xff526073))),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: _DecisionButton(
                  label: 'CT',
                  selected: patient.needToCT,
                  onPressed: onNeedCT)),
          const SizedBox(width: 8),
          Expanded(
              child: _DecisionButton(
                  label: 'MRI',
                  selected: patient.needToMRI,
                  onPressed: onNeedMRI)),
        ]),
        const Divider(height: 22, color: _line),
        Row(children: [
          const Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('ترومبکتومی مکانیکی (MT)',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _navy)),
                Text('تصمیم نهایی متخصص برای انجام MT',
                    style: TextStyle(fontSize: 11, color: Color(0xff667589))),
              ])),
          Switch.adaptive(
              value: patient.needToMT,
              activeTrackColor: _teal,
              onChanged: (_) => onToggleMT()),
        ]),
      ]));

  String get _imagingStatus {
    if (patient.needToCT && patient.needToMRI) return 'CT و MRI';
    if (patient.needToCT) return 'CT';
    if (patient.needToMRI) return 'MRI';
    return 'ثبت نشده';
  }

  Widget _clinicalCard() => Container(
      clipBehavior: Clip.antiAlias,
      decoration: AppConfig.box(),
      child: Column(children: [
        PatientRecordRow(
            title: 'آزمایشگاه',
            status: patient.labIsComplete ? 'تکمیل شده' : 'تکمیل نشده',
            action: patient.labIsComplete ? 'مشاهده فرم' : 'تکمیل فرم',
            onTap: onLaboratory,
            statusComplete: patient.labIsComplete),
        PatientRecordRow(
            title: 'زمان تزریق',
            status: (patient.timeOfInjection?.trim() ?? '').isEmpty
                ? 'ثبت نشده'
                : 'ثبت شده',
            action: (patient.timeOfInjection?.trim() ?? '').isEmpty
                ? 'مشاهده'
                : AppConfig.digits(patient.timeOfInjection!.trim()),
            onTap: onInjectionTime,
            statusComplete: (patient.timeOfInjection?.trim() ?? '').isNotEmpty),
        PatientRecordRow(
            title: 'تصمیم تزریق',
            status: '',
            action: patient.injectionType == 1
                ? 'تزریق شود'
                : patient.injectionType == 2
                    ? 'تزریق نشود'
                    : 'هنوز ثبت نشده',
            onTap: onInjectionTime,
            last: patient.injectionType != 2 || onInjectionReasons == null),
        if (patient.injectionType == 2 && onInjectionReasons != null)
          PatientRecordRow(
              title: 'دلایل تزریق نشدن',
              status: '',
              action: 'مشاهده',
              onTap: onInjectionReasons!,
              last: true),
      ]));

  Widget _guideBox() => Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: _infoBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _infoBorder)),
      child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.info_outline, color: _teal, size: 19),
        SizedBox(width: 8),
        Expanded(
            child: Text(
                'برای تکمیل بررسی، تصاویر ارسال‌شده بیمار را کنترل کنید و در صورت نیاز پرونده را دوباره به‌روزرسانی کنید.',
                style: TextStyle(
                    color: Color(0xff2f4157), fontSize: 12, height: 1.5))),
      ]));
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.title,
    required this.value,
    required this.icon,
    required this.accent,
    required this.background,
    required this.onTap,
    this.ltr = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color accent;
  final Color background;
  final VoidCallback onTap;
  final bool ltr;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
              color: background, borderRadius: BorderRadius.circular(12)),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon, size: 16, color: accent),
              const SizedBox(width: 4),
              Flexible(
                  child: Text(title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: accent))),
            ]),
            const SizedBox(height: 6),
            FittedBox(
                child: Text(value,
                    textDirection:
                        ltr ? TextDirection.ltr : TextDirection.rtl,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _navy))),
          ])));
}

class _DecisionButton extends StatelessWidget {
  const _DecisionButton(
      {required this.label,
      required this.selected,
      required this.onPressed});

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          foregroundColor: selected ? Colors.white : _teal,
          backgroundColor: selected ? _teal : Colors.white,
          side: BorderSide(color: selected ? _teal : _line),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: Text(label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)));
}
