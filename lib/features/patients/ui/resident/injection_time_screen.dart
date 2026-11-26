import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../../data/resident_patient_repository.dart';

class InjectionTimeScreen extends StatefulWidget {
  const InjectionTimeScreen(
      {super.key, required this.patient, required this.onSubmit});

  final ModelPatient patient;
  final Future<PatientOperationResult> Function(
      String time, String timestamp, String medicine) onSubmit;

  @override
  State<InjectionTimeScreen> createState() => _InjectionTimeScreenState();
}

class _InjectionTimeScreenState extends State<InjectionTimeScreen> {
  static const _medicines = ['آلتپلاز', 'تنکتپلاز', 'آلتلایز (ایرانی)'];
  int? _medicine;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final medicine = widget.patient.medicine;
    if (medicine != null && medicine >= 1 && medicine <= _medicines.length) {
      _medicine = medicine;
    }
  }

  Future<void> _submit() async {
    if (_submitting) return;
    if (_medicine == null) {
      setState(() => _error = 'داروی تزریق‌شده را انتخاب کنید.');
      return;
    }
    final now = DateTime.now();
    final time =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final result = await widget.onSubmit(
          time, '${now.millisecondsSinceEpoch}', '$_medicine');
      if (!mounted) return;
      if (result.success) {
        Navigator.of(context).pop(true);
      } else {
        setState(() => _error = result.message.isEmpty
            ? 'ثبت زمان تزریق ناموفق بود.'
            : result.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'ثبت زمان تزریق ناموفق بود. دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final patient = widget.patient;
    final recommended = patient.recommendedMedication;
    return PopScope(
        canPop: !_submitting,
        child: Directionality(
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
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color(0x220f2943),
                                      blurRadius: 14,
                                      offset: Offset(0, 5))
                                ]),
                            child: Column(children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 12, 0),
                                  child: Row(children: [
                                    IconButton(
                                        onPressed: _submitting
                                            ? null
                                            : () => Navigator.pop(context),
                                        icon: const Icon(Icons.arrow_forward),
                                        tooltip: 'بازگشت'),
                                    const Expanded(
                                        child: Text('ثبت زمان تزریق',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppConfig
                                                    .inkColorResident))),
                                  ])),
                              const Divider(height: 1),
                              Expanded(
                                  child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(children: [
                                              Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffe0f6ed),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Icon(
                                                      Icons.person_outline,
                                                      color: AppConfig
                                                          .inkColorResident)),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                  child: Text(
                                                      '${patient.fullName.isEmpty ? 'نام ثبت نشده' : patient.fullName}  ·  ${patient.age.isEmpty ? '—' : AppConfig.digits(patient.age)} سال',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppConfig
                                                              .inkColorResident))),
                                            ]),
                                            const SizedBox(height: 22),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffe4f6f1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffbce8db))),
                                                child: const Row(children: [
                                                  Icon(Icons.access_time,
                                                      color: AppConfig
                                                          .tealColorResident,
                                                      size: 30),
                                                  SizedBox(width: 12),
                                                  Expanded(
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                        Text('زمان تزریق',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppConfig
                                                                    .inkColorResident)),
                                                        SizedBox(height: 5),
                                                        Text(
                                                            'زمان فعلی هنگام ثبت به عنوان زمان تزریق ذخیره می‌شود.',
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff526073))),
                                                      ])),
                                                ])),
                                            const SizedBox(height: 22),
                                            const Text('داروی تزریق‌شده',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppConfig
                                                        .inkColorResident)),
                                            const SizedBox(height: 5),
                                            const Text(
                                                'دارویی را که تزریق شده انتخاب کنید.',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0xff526073))),
                                            const SizedBox(height: 12),
                                            for (var index = 0;
                                                index < _medicines.length;
                                                index++)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8),
                                                  child: Material(
                                                    color:
                                                        _medicine == index + 1
                                                            ? const Color(
                                                                0xffe2f7f0)
                                                            : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            11),
                                                    child: RadioListTile<int>(
                                                      value: index + 1,
                                                      groupValue: _medicine,
                                                      activeColor: AppConfig
                                                          .tealColorResident,
                                                      onChanged: _submitting
                                                          ? null
                                                          : (value) =>
                                                              setState(() {
                                                                _medicine =
                                                                    value;
                                                                _error = null;
                                                              }),
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(11),
                                                          side: BorderSide(
                                                              color: _medicine ==
                                                                      index + 1
                                                                  ? AppConfig
                                                                      .tealColorResident
                                                                  : const Color(
                                                                      0xffd2dce4))),
                                                      title: Text(
                                                          _medicines[index],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: AppConfig
                                                                  .inkColorResident)),
                                                      subtitle: recommended ==
                                                              index + 1
                                                          ? const Text(
                                                              'داروی پیشنهادی متخصص',
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: AppConfig
                                                                      .tealColorResident))
                                                          : null,
                                                    ),
                                                  )),
                                            if (_error != null)
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, bottom: 10),
                                                  child: Text(_error!,
                                                      style: const TextStyle(
                                                          color: Colors.red))),
                                            const SizedBox(height: 10),
                                            Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffe2effb),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffc7def5))),
                                                child: const Row(children: [
                                                  Icon(Icons.info_outline,
                                                      color: Color(0xff2059a2)),
                                                  SizedBox(width: 8),
                                                  Expanded(
                                                      child: Text(
                                                          'پس از انجام تزریق، دارو را انتخاب و زمان را ثبت کنید.',
                                                          style: TextStyle(
                                                              fontSize: 13)))
                                                ])),
                                          ]))),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 16),
                                  child: Row(children: [
                                    Expanded(
                                        flex: 2,
                                        child: FilledButton(
                                            onPressed:
                                                _submitting ? null : _submit,
                                            style: FilledButton.styleFrom(
                                                backgroundColor:
                                                    AppConfig.tealColorResident,
                                                minimumSize: const Size(0, 48)),
                                            child: _submitting
                                                ? const SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                            strokeWidth: 2))
                                                : const Text(
                                                    'ثبت زمان تزریق'))),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        child: OutlinedButton(
                                            onPressed: _submitting
                                                ? null
                                                : () => Navigator.pop(context),
                                            style: OutlinedButton.styleFrom(
                                                minimumSize: const Size(0, 48),
                                                foregroundColor:
                                                    AppConfig.inkColorResident),
                                            child: const Text('بازگشت'))),
                                  ])),
                            ]),
                          )))),
            )));
  }
}
