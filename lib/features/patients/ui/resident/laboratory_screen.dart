import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../../data/resident_patient_repository.dart';

class LaboratoryScreen extends StatefulWidget {
  const LaboratoryScreen(
      {super.key, required this.patient, required this.onSubmit});

  final ModelPatient patient;
  final Future<PatientOperationResult> Function(List<Map<String, dynamic>>)
      onSubmit;

  @override
  State<LaboratoryScreen> createState() => _LaboratoryScreenState();
}

class _LaboratoryScreenState extends State<LaboratoryScreen> {
  static const _names = ['BUN', 'Cr', 'PLT', 'PTT', 'INR', 'Hb', 'WBC'];
  static const _labels = [
    'اوره خون',
    'کراتینین',
    'پلاکت',
    'زمان انعقاد',
    'نسبت انعقاد',
    'هموگلوبین',
    'گلبول سفید'
  ];
  final _formKey = GlobalKey<FormState>();
  late final List<TextEditingController> _controllers;
  bool? _trop;
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final patient = widget.patient;
    final values = [
      patient.bun,
      patient.cr,
      patient.plt,
      patient.pt,
      patient.inr,
      patient.hb,
      patient.wbc
    ];
    _controllers = values
        .map((value) => TextEditingController(text: AppConfig.digits(value)))
        .toList();
    _trop = patient.labIsComplete ? patient.trop : null;
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  String _normalize(String text) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    return text.trim().split('').map((character) {
      final index = persian.indexOf(character);
      if (index >= 0) return '$index';
      final other = arabic.indexOf(character);
      if (other >= 0) return '$other';
      return character == '٫' ? '.' : character;
    }).join();
  }

  String? _validate(String? value) {
    final text = _normalize(value ?? '');
    if (text.isEmpty) return null;
    final number = double.tryParse(text);
    if (number == null || !number.isFinite || number < 0) {
      return 'یک عدد معتبر وارد کنید.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    if (_trop == null) {
      setState(() => _error = 'نتیجه تروپونین را انتخاب کنید.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final answers = [
        for (final controller in _controllers)
          <String, dynamic>{'selected_answer': _normalize(controller.text)},
        <String, dynamic>{'selected_answer': _trop! ? '1' : '0'},
      ];
      final result = await widget.onSubmit(answers);
      if (!mounted) return;
      if (result.success) {
        Navigator.of(context).pop(true);
      } else {
        setState(() => _error =
            result.message.isEmpty ? 'ثبت نتایج ناموفق بود.' : result.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'ثبت نتایج ناموفق بود. دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _field(int index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: TextFormField(
          key: ValueKey('lab-${_names[index]}'),
          controller: _controllers[index],
          enabled: !_submitting,
          textDirection: TextDirection.ltr,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹٠-٩.٫]')),
            LengthLimitingTextInputFormatter(12)
          ],
          validator: _validate,
          decoration: InputDecoration(
            labelText: '${_labels[index]}  ·  ${_names[index]}',
            hintText: 'اختیاری',
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffd2dce4))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: AppConfig.tealColorResident, width: 2)),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final patient = widget.patient;
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
                                        child: Text('نتایج آزمایشگاه',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: AppConfig
                                                    .inkColorResident)))
                                  ])),
                              const Divider(height: 1),
                              Expanded(
                                  child: SingleChildScrollView(
                                      padding: const EdgeInsets.all(16),
                                      child: Form(
                                          key: _formKey,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Row(children: [
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0xffe0f6ed),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppConfig
                                                                  .inkColorResident)))
                                                ]),
                                                const SizedBox(height: 20),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffe4f6f1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffbce8db))),
                                                    child: const Row(children: [
                                                      Icon(
                                                          Icons
                                                              .science_outlined,
                                                          color: AppConfig
                                                              .tealColorResident,
                                                          size: 28),
                                                      SizedBox(width: 12),
                                                      Expanded(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                            Text(
                                                                'ثبت نتایج آزمایش',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16,
                                                                    color: AppConfig
                                                                        .inkColorResident)),
                                                            SizedBox(height: 5),
                                                            Text(
                                                                'مقادیر موجود را بر اساس برگه آزمایش وارد کنید.',
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xff526073),
                                                                    fontSize:
                                                                        12))
                                                          ]))
                                                    ])),
                                                const SizedBox(height: 18),
                                                for (var index = 0;
                                                    index < _names.length;
                                                    index++)
                                                  _field(index),
                                                const Text('تروپونین (Trop)',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppConfig
                                                            .inkColorResident)),
                                                const SizedBox(height: 8),
                                                Row(children: [
                                                  for (final option in [
                                                    true,
                                                    false
                                                  ])
                                                    Expanded(
                                                        child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: option
                                                                        ? 8
                                                                        : 0),
                                                            child:
                                                                OutlinedButton
                                                                    .icon(
                                                              onPressed:
                                                                  _submitting
                                                                      ? null
                                                                      : () =>
                                                                          setState(
                                                                              () {
                                                                            _trop =
                                                                                option;
                                                                            _error =
                                                                                null;
                                                                          }),
                                                              icon: Icon(
                                                                  _trop ==
                                                                          option
                                                                      ? Icons
                                                                          .radio_button_checked
                                                                      : Icons
                                                                          .radio_button_unchecked,
                                                                  size: 19),
                                                              label: Text(option
                                                                  ? 'مثبت'
                                                                  : 'منفی'),
                                                              style: OutlinedButton.styleFrom(
                                                                  backgroundColor: _trop ==
                                                                          option
                                                                      ? const Color(
                                                                          0xffe2f7f0)
                                                                      : Colors
                                                                          .white,
                                                                  foregroundColor:
                                                                      AppConfig
                                                                          .tealColorResident,
                                                                  minimumSize:
                                                                      const Size(
                                                                          0,
                                                                          46),
                                                                  side: BorderSide(
                                                                      color: _trop ==
                                                                              option
                                                                          ? AppConfig
                                                                              .tealColorResident
                                                                          : const Color(
                                                                              0xffd2dce4))),
                                                            )))
                                                ]),
                                                if (_error != null)
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12),
                                                      child: Text(_error!,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red))),
                                                const SizedBox(height: 16),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffe2effb),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffc7def5))),
                                                    child: const Row(children: [
                                                      Icon(Icons.info_outline,
                                                          color: Color(
                                                              0xff2059a2)),
                                                      SizedBox(width: 8),
                                                      Expanded(
                                                          child: Text(
                                                              'پیش از ثبت، نتایج را با برگه آزمایش مطابقت دهید.',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13)))
                                                    ])),
                                              ])))),
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
                                                : Text(patient.labIsComplete
                                                    ? 'ثبت ویرایش نتایج'
                                                    : 'ثبت نتایج آزمایش'))),
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
