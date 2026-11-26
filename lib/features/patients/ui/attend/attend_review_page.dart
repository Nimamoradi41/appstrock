import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../resident/patient_record_dates.dart';
import '../resident/patient_medications_card.dart';

const _ink = Color(0xff0b1a35);
const _teal = Color(0xff007d7c);
const _border = Color(0xffd6dde4);

class AttendReviewPage extends StatefulWidget {
  const AttendReviewPage(
      {super.key,
      required this.patient,
      required this.onBack,
      required this.onSeen,
      required this.onImages,
      required this.onNihss,
      required this.onLaboratory,
      required this.onResidents,
      required this.onBloodPressure,
      required this.onBloodSugar,
      required this.onUpload,
      required this.onNeedCT,
      required this.onNeedMRI,
      required this.onSaveDecision,
      this.refreshing = false});

  final ModelPatient patient;
  final VoidCallback onBack, onSeen, onImages, onNihss, onLaboratory;
  final VoidCallback onResidents;
  final VoidCallback onBloodPressure, onBloodSugar;
  final VoidCallback onUpload, onNeedCT, onNeedMRI;
  final Future<bool> Function(bool inject, int medication) onSaveDecision;
  final bool refreshing;

  @override
  State<AttendReviewPage> createState() => _AttendReviewPageState();
}

class _AttendReviewPageState extends State<AttendReviewPage> {
  bool? _inject;
  int? _medication;
  bool _saving = false;
  bool _edited = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadDecision();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && widget.patient.isFinished != true) setState(() {});
    });
  }

  void _loadDecision() {
    _inject = widget.patient.injectionType == 1
        ? true
        : widget.patient.injectionType == 2
            ? false
            : null;
    final medication = widget.patient.recommendedMedication ?? 0;
    _medication = medication >= 1 && medication <= 3 ? medication : null;
  }

  @override
  void didUpdateWidget(covariant AttendReviewPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.patient.id != widget.patient.id || !_edited) _loadDecision();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _elapsed(int? timestamp) {
    if (timestamp == null || timestamp <= 0) return '—';
    final duration = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(timestamp));
    if (duration.isNegative) return '—';
    return AppConfig.digits(
        '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}');
  }

  Future<void> _save() async {
    if (_inject == null ||
        (_inject == true && _medication == null) ||
        _saving) {
      return;
    }
    final medicineName =
        const {1: 'آلتپلاز', 2: 'تنکتپلاز', 3: 'آلتلایز (ایرانی)'}[_medication];
    final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
              title: const Text('تأیید تصمیم متخصص'),
              content: Text(_inject == true
                  ? 'تصمیم: تزریق\nداروی پیشنهادی: $medicineName\n\nثبت این تصمیم به معنی انجام تزریق نیست.'
                  : 'تصمیم: عدم تزریق'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('بازگشت')),
                FilledButton(
                    onPressed: () => Navigator.pop(dialogContext, true),
                    child: const Text('تأیید و ثبت'))
              ],
            ));
    if (confirmed != true || !mounted) return;
    setState(() => _saving = true);
    final saved = await widget.onSaveDecision(_inject!, _medication ?? 0);
    if (!mounted) return;
    setState(() => _saving = false);
    if (saved) {
      _edited = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('تصمیم متخصص ثبت شد')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final patient = widget.patient;
    final finished = patient.isFinished == true;
    final canSave = !widget.refreshing &&
        !_saving &&
        _inject != null &&
        (_inject != true || _medication != null);
    return Column(children: [
      Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          child: Row(children: [
            IconButton(
                onPressed: widget.onBack,
                tooltip: 'بازگشت',
                icon: const Icon(Icons.arrow_forward, color: _ink)),
            const Expanded(
                child: Text('بررسی بیمار',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: _ink))),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                    color: const Color(0xfff0f3f6),
                    borderRadius: BorderRadius.circular(10)),
                child: const Row(children: [
                  Icon(Icons.person_outline, size: 18, color: _ink),
                  SizedBox(width: 5),
                  Text('اتند',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: _ink))
                ])),
          ])),
      if (widget.refreshing)
        const LinearProgressIndicator(minHeight: 2, color: _teal),
      Expanded(
          child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: const Color(0xffd8f6eb),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.person_outline,
                                  size: 30, color: Color(0xff075965))),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text(
                                    patient.withoutInfo
                                        ? 'بیمار مجهول‌الهویه'
                                        : patient.fullName.isEmpty
                                        ? 'نام ثبت نشده'
                                        : patient.fullName,
                                    style: const TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: _ink)),
                                Text(
                                    '${patient.gender.isEmpty ? '—' : patient.gender} · ${patient.age.isEmpty ? '—' : AppConfig.digits(patient.age)} سال',
                                    style: const TextStyle(color: _ink)),
                              ])),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                    onPressed: patient.seenByAttend == true ||
                                            widget.refreshing
                                        ? null
                                        : widget.onSeen,
                                    icon: Icon(
                                        patient.seenByAttend == true
                                            ? Icons.check
                                            : Icons.visibility_outlined,
                                        size: 17),
                                    label: Text(
                                        patient.seenByAttend == true
                                            ? 'پرونده مشاهده شد'
                                            : 'ثبت مشاهده',
                                        style: const TextStyle(fontSize: 11)),
                                    style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.green,
                                        disabledForegroundColor: Colors.green,
                                        side: const BorderSide(
                                            color: Colors.green),
                                        visualDensity: VisualDensity.compact)),
                                const SizedBox(height: 8,),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffd8f6eb),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                        finished ? 'تکمیل شده' : 'کد ۷۲۴ فعال',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: _ink))),
                              ]),
                        ]),
                    const SizedBox(height: 14),
                    if (!finished) ...[
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffffedcf),
                              border:
                                  Border.all(color: const Color(0xffffd28f)),
                              borderRadius: BorderRadius.circular(13)),
                          child: Row(children: [
                            const Icon(Icons.access_time,
                                color: Color(0xffc55b00)),
                            const SizedBox(width: 8),
                            Expanded(
                                child: Text(
                                    patient.signsStartIsUnknown == true
                                        ? 'از مشاهده علائم (FSS)'
                                        : 'از شروع علائم',
                                    style: const TextStyle(
                                        color: _ink, fontSize: 12))),
                            Text(
                                _elapsed(patient.signsStartIsUnknown == true
                                    ? patient.signsStartTSFSS
                                    : patient.signsStartTS),
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: _ink))
                          ])),
                      const SizedBox(height: 12),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                              color: const Color(0xffe9f4f5),
                              border:
                                  Border.all(color: const Color(0xffc7e5e4)),
                              borderRadius: BorderRadius.circular(13)),
                          child: Row(children: [
                            const Icon(Icons.schedule, color: _teal),
                            const SizedBox(width: 8),
                            const Expanded(
                                child: Text('از ثبت در سیستم',
                                    style:
                                        TextStyle(color: _ink, fontSize: 12))),
                            Text(_elapsed(patient.insertTimeTS),
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
                                    color: _ink))
                          ])),
                      const SizedBox(height: 12),
                    ],
                    Container(
                        decoration: _box(),
                        child: IntrinsicHeight(
                            child: Row(children: [
                          _metric(
                              'NIHSS',
                              patient.nihsIsComplete
                                  ? AppConfig.digits('${patient.nihsSubscore}')
                                  : '—',
                              Icons.assignment_outlined,
                              widget.onNihss),
                          const VerticalDivider(
                              width: 1, indent: 8, endIndent: 8),
                          _metric(
                              'فشار خون',
                              (patient.bloodPressure1 ?? 0) > 0
                                  ? AppConfig.digits(
                                      '${patient.bloodPressure1}/${patient.bloodPressure2 ?? '—'}')
                                  : '—',
                              Icons.monitor_heart_outlined,
                              widget.onBloodPressure),
                          const VerticalDivider(
                              width: 1, indent: 8, endIndent: 8),
                          _metric(
                              'قند خون',
                              (patient.bs ?? 0) > 0
                                  ? '${AppConfig.digits('${patient.bs}')} mg/dL'
                                  : '—',
                              Icons.water_drop_outlined,
                              widget.onBloodSugar),
                        ]))),
                    const SizedBox(height: 10),
                    _linkRow(
                        'آزمایشگاه',
                        patient.labIsComplete ? 'مشاهده نتایج' : 'ثبت نشده',
                        Icons.science_outlined,
                        widget.onLaboratory),
                    const SizedBox(height: 6),
                    _linkRow(
                        'تصویربرداری',
                        [
                          if (patient.needToCT) 'CT',
                          if (patient.needToMRI) 'MRI'
                        ].join(' · ').isEmpty
                            ? 'مشاهده تصاویر'
                            : '${[
                                if (patient.needToCT) 'CT',
                                if (patient.needToMRI) 'MRI'
                              ].join(' · ')} · مشاهده تصاویر',
                        Icons.image_outlined,
                        widget.onImages),
                    const SizedBox(height: 8),
                    Container(
                        decoration: _box(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        child: Row(children: [
                          const Expanded(
                              child: Text('درخواست تصویربرداری',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: _ink))),
                          FilterChip(
                              label: const Text('CT'),
                              selected: patient.needToCT,
                              onSelected: widget.refreshing
                                  ? null
                                  : (_) => widget.onNeedCT(),
                              selectedColor: const Color(0xffe3f6f0)),
                          const SizedBox(width: 6),
                          FilterChip(
                              label: const Text('MRI'),
                              selected: patient.needToMRI,
                              onSelected: widget.refreshing
                                  ? null
                                  : (_) => widget.onNeedMRI(),
                              selectedColor: const Color(0xffe3f6f0)),
                        ])),
                    const SizedBox(height: 14),
                    PatientMedicationsCard(
                        patient: patient, showInjectionTime: false),
                    const SizedBox(height: 12),
                    PatientRecordDates(patient: patient),
                    const SizedBox(height: 12),
                    _linkRow('تصاویر بیمار', 'بارگذاری تصویر',
                        Icons.upload_outlined, widget.onUpload),
                    const SizedBox(height: 6),
                    _linkRow('رزیدنت‌های بیمار', 'مشاهده فعالیت‌ها',
                        Icons.people_outline, widget.onResidents),
                    const SizedBox(height: 14),
                    const Text('تصمیم متخصص',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: _ink)),
                    const SizedBox(height: 8),
                    Row(children: [
                      Expanded(
                          child: _choice(
                              'تزریق',
                              _inject == true,
                              () => setState(() {
                                    _inject = true;
                                    _edited = true;
                                  }),
                              enabled: !widget.refreshing)),
                      const SizedBox(width: 8),
                      Expanded(
                          child: _choice(
                              'عدم تزریق',
                              _inject == false,
                              () => setState(() {
                                    _inject = false;
                                    _edited = true;
                                  }),
                              enabled: !widget.refreshing))
                    ]),
                    if (_inject == true) ...[
                      const SizedBox(height: 12),
                      const Text('داروی پیشنهادی',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _ink)),
                      const SizedBox(height: 6),
                      for (final option in const {
                        1: 'آلتپلاز',
                        2: 'تنکتپلاز',
                        3: 'آلتلایز (ایرانی)'
                      }.entries)
                        Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: _choice(
                                option.value,
                                _medication == option.key,
                                () => setState(() {
                                      _medication = option.key;
                                      _edited = true;
                                    }),
                                enabled: !widget.refreshing,
                                compact: true)),
                    ],
                    const SizedBox(height: 5),
                    Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: const Color(0xffe1eefb),
                            border: Border.all(color: const Color(0xffc5ddfa)),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Row(children: [
                          Icon(Icons.info_outline,
                              color: Color(0xff1354a3), size: 21),
                          SizedBox(width: 8),
                          Expanded(
                              child: Text('ثبت نوع دارو با رزیدنت باشد',
                                  style: TextStyle(color: _ink, fontSize: 12)))
                        ])),
                    const SizedBox(height: 9),
                    SizedBox(
                        height: 44,
                        child: FilledButton(
                            onPressed: canSave ? _save : null,
                            style: FilledButton.styleFrom(
                                backgroundColor: _teal,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: _saving
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        strokeWidth: 2, color: Colors.white))
                                : const Text('مرور و تأیید تصمیم',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))),
                  ]))),
    ]);
  }

  BoxDecoration _box() => BoxDecoration(
      color: Colors.white,
      border: Border.all(color: _border),
      borderRadius: BorderRadius.circular(12));

  Widget _metric(
          String title, String value, IconData icon, VoidCallback onTap) =>
      Expanded(
          child: InkWell(
              onTap: onTap,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 9, horizontal: 3),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(icon, size: 17, color: _ink),
                      const SizedBox(width: 4),
                      Flexible(
                          child: Text(title,
                              maxLines: 1,
                              style:
                                  const TextStyle(fontSize: 11, color: _ink)))
                    ]),
                    const SizedBox(height: 4),
                    FittedBox(
                        child: Text(value,
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: _ink))),
                  ]))));

  Widget _linkRow(
          String title, String action, IconData icon, VoidCallback onTap) =>
      Material(
          color: Colors.white,
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: _border),
              borderRadius: BorderRadius.circular(12)),
          child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  child: Row(children: [
                    Icon(icon, color: _ink, size: 21),
                    const SizedBox(width: 9),
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: _ink)),
                    const Spacer(),
                    Flexible(
                        child: Text(action,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _teal))),
                    const SizedBox(width: 8),
                    const Icon(Icons.chevron_left, color: _ink, size: 19)
                  ]))));

  Widget _choice(String title, bool selected, VoidCallback onTap,
          {bool enabled = true, bool compact = false}) =>
      Material(
          color: selected ? const Color(0xffe3f6f0) : Colors.white,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: selected ? _teal : _border),
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
              onTap: enabled ? onTap : null,
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 12, vertical: compact ? 7 : 12),
                  child: Row(children: [
                    Icon(
                        selected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: selected ? _teal : const Color(0xff909aa6),
                        size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                        child: Text(title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: _ink)))
                  ]))));
}
