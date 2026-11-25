import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';
import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../data/resident_patient_repository.dart';

const not724ReasonLabels = [
  'تشخیص اشتباه در تریاژ',
  'تشخیص اشتباه اورژانس پیش‌بیمارستانی',
  'گذشت بیش از چهار ساعت و نیم از شروع علائم',
];

class Not724ReasonsCard extends StatelessWidget {
  const Not724ReasonsCard(
      {super.key, required this.patient, required this.onAddReasons});

  final ModelPatient patient;
  final VoidCallback onAddReasons;

  @override
  Widget build(BuildContext context) {
    final complete = patient.isNot724IsComplete == true;
    final selected = [
      patient.misdiagnosisOfTriage == true,
      patient.misdiagnosisOfEms == true,
      patient.overTime == true
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color(0xfffbfcfe),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppConfig.borderColorResident)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Row(children: [
          const Icon(Icons.assignment_outlined,
              color: AppConfig.tealColorResident),
          const SizedBox(width: 8),
          const Expanded(
              child: Text('دلایل عدم احراز کد ۷۲۴',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConfig.inkColorResident))),
          if (complete)
            const Icon(Icons.check_circle, color: Color(0xff17a672), size: 21),
        ]),
        const SizedBox(height: 12),
        if (complete) ...[
          if (!selected.contains(true))
            const Text('دلیلی برای این پرونده ثبت نشده است.',
                style: TextStyle(color: Color(0xff526073), fontSize: 12)),
          for (var index = 0; index < selected.length; index++)
            if (selected[index])
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.check_circle_outline,
                          color: AppConfig.tealColorResident, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text(not724ReasonLabels[index],
                              style: const TextStyle(
                                  color: AppConfig.inkColorResident,
                                  fontSize: 12))),
                    ]),
              ),
        ] else ...[
          const Text(
              'برای تکمیل پرونده، دلیل یا دلایل عدم احراز کد ۷۲۴ را ثبت کنید.',
              style: TextStyle(color: Color(0xff526073), fontSize: 12)),
          const SizedBox(height: 12),
          SizedBox(
              height: 46,
              child: FilledButton.icon(
                onPressed: onAddReasons,
                icon: const Icon(Icons.playlist_add_check),
                label: const Text('ثبت دلایل'),
                style: FilledButton.styleFrom(
                    backgroundColor: AppConfig.tealColorResident),
              )),
        ],
      ]),
    );
  }
}

class Not724ReasonsForm extends StatefulWidget {
  const Not724ReasonsForm({super.key, required this.onSubmit});
  final Future<PatientOperationResult> Function(
      bool triage, bool ems, bool overTime) onSubmit;

  @override
  State<Not724ReasonsForm> createState() => _Not724ReasonsFormState();
}

class _Not724ReasonsFormState extends State<Not724ReasonsForm> {
  final _selected = [false, false, false];
  bool _submitting = false;
  String? _error;

  Future<void> _submit() async {
    if (_submitting) return;
    if (!_selected.contains(true)) {
      setState(() => _error = 'حداقل یک دلیل را انتخاب کنید.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final result =
          await widget.onSubmit(_selected[0], _selected[1], _selected[2]);
      if (!mounted) return;
      if (result.success) {
        Navigator.of(context).pop(true);
      } else {
        setState(() => _error =
            result.message.isEmpty ? 'ثبت دلایل ناموفق بود.' : result.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'ثبت دلایل ناموفق بود. دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) => PopScope(
        canPop: !_submitting,
        child: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  20, 16, 20, 20 + MediaQuery.viewInsetsOf(context).bottom),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: Container(
                            width: 42,
                            height: 4,
                            decoration: BoxDecoration(
                                color: const Color(0xffc6d1da),
                                borderRadius: BorderRadius.circular(4)))),
                    const SizedBox(height: 16),
                    const Text('دلایل عدم احراز کد ۷۲۴',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConfig.inkColorResident)),
                    const SizedBox(height: 6),
                    const Text('یک یا چند مورد را انتخاب کنید.',
                        style:
                            TextStyle(color: Color(0xff526073), fontSize: 12)),
                    const SizedBox(height: 14),
                    for (var index = 0;
                        index < not724ReasonLabels.length;
                        index++)
                      Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Material(
                            color: _selected[index]
                                ? const Color(0xffe5f5f1)
                                : const Color(0xfff7f9fb),
                            borderRadius: BorderRadius.circular(10),
                            child: CheckboxListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(
                                      color: _selected[index]
                                          ? AppConfig.tealColorResident
                                          : AppConfig.borderColorResident)),
                              value: _selected[index],
                              activeColor: AppConfig.tealColorResident,
                              onChanged: _submitting
                                  ? null
                                  : (value) => setState(() {
                                        _selected[index] = value ?? false;
                                        _error = null;
                                      }),
                              title: Text(not724ReasonLabels[index],
                                  style: const TextStyle(
                                      color: AppConfig.inkColorResident,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          )),
                    if (_error != null)
                      Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 8),
                          child: Text(_error!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 12))),
                    const SizedBox(height: 8),
                    SizedBox(
                        height: 48,
                        child: FilledButton(
                          onPressed: _submitting ? null : _submit,
                          style: FilledButton.styleFrom(
                              backgroundColor: AppConfig.tealColorResident),
                          child: _submitting
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : const Text('ثبت دلایل',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                        )),
                    TextButton(
                        onPressed:
                            _submitting ? null : () => Navigator.pop(context),
                        child: const Text('انصراف')),
                  ]),
            ))),
      );
}
