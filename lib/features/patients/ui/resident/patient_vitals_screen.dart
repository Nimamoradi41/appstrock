import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../../data/resident_patient_repository.dart';

enum PatientVital { bloodSugar, bloodPressure }

class PatientVitalsScreen extends StatefulWidget {
  const PatientVitalsScreen(
      {super.key,
      required this.patient,
      required this.vital,
      required this.onSubmit});

  final ModelPatient patient;
  final PatientVital vital;
  final Future<PatientOperationResult> Function(String first, String? second)
      onSubmit;

  @override
  State<PatientVitalsScreen> createState() => _PatientVitalsScreenState();
}

class _PatientVitalsScreenState extends State<PatientVitalsScreen> {
  late final TextEditingController _first;
  late final TextEditingController _second;
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;
  String? _error;

  bool get _pressure => widget.vital == PatientVital.bloodPressure;

  @override
  void initState() {
    super.initState();
    String initial(int? value) =>
        value != null && value > 0 ? AppConfig.digits('$value') : '';
    _first = TextEditingController(
        text: initial(
            _pressure ? widget.patient.bloodPressure1 : widget.patient.bs));
    _second =
        TextEditingController(text: initial(widget.patient.bloodPressure2));
  }

  @override
  void dispose() {
    _first.dispose();
    _second.dispose();
    super.dispose();
  }

  String _latinDigits(String value) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    return value.split('').map((digit) {
      final index = persian.indexOf(digit);
      if (index >= 0) return '$index';
      final arabicIndex = arabic.indexOf(digit);
      return arabicIndex >= 0 ? '$arabicIndex' : digit;
    }).join();
  }

  String? _validate(String? text, int min, int max) {
    final input = (text ?? '').trim();
    if (input.isEmpty) return 'این مقدار را وارد کنید.';
    final value = int.tryParse(_latinDigits(input));
    if (value == null || value < min || value > max) {
      return 'مقدار باید بین ${AppConfig.digits('$min')} و ${AppConfig.digits('$max')} باشد.';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_submitting || !_formKey.currentState!.validate()) return;
    final first = int.parse(_latinDigits(_first.text));
    final second = _pressure ? int.parse(_latinDigits(_second.text)) : null;
    if (second != null && second >= first) {
      setState(() => _error = 'فشار سیستول باید بیشتر از فشار دیاستول باشد.');
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final result = await widget.onSubmit('$first', second?.toString());
      if (!mounted) return;
      if (result.success) {
        Navigator.of(context).pop(true);
      } else {
        setState(() => _error = result.message.isEmpty
            ? 'ثبت اطلاعات ناموفق بود.'
            : result.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'ثبت اطلاعات ناموفق بود. دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _input(
          {required String label,
          required String hint,
          required String unit,
          required TextEditingController controller,
          required int min,
          required int max,
          required String keyName,
          TextInputAction action = TextInputAction.done}) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(label,
            style: const TextStyle(
                color: AppConfig.inkColorResident,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          key: ValueKey(keyName),
          controller: controller,
          enabled: !_submitting,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          textInputAction: action,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9۰-۹٠-٩]')),
            LengthLimitingTextInputFormatter(4)
          ],
          validator: (value) => _validate(value, min, max),
          onChanged: (_) {
            if (_error != null) setState(() => _error = null);
          },
          decoration: InputDecoration(
            hintText: hint,
            suffixText: unit,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffcfd9e1))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffcfd9e1))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                    color: AppConfig.tealColorResident, width: 2)),
          ),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    final title = _pressure ? 'فشار خون' : 'قند خون';
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
                                    Expanded(
                                        child: Text('ثبت $title',
                                            style: const TextStyle(
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
                                                const SizedBox(height: 24),
                                                Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16),
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffe4f6f1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0xffbce8db))),
                                                    child: Row(children: [
                                                      Icon(
                                                          _pressure
                                                              ? Icons
                                                                  .favorite_border
                                                              : Icons
                                                                  .water_drop_outlined,
                                                          color: AppConfig
                                                              .tealColorResident,
                                                          size: 30),
                                                      const SizedBox(width: 12),
                                                      Expanded(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                            Text(
                                                                'اندازه‌گیری $title',
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppConfig
                                                                        .inkColorResident)),
                                                            const SizedBox(
                                                                height: 5),
                                                            const Text(
                                                                'مقدار اندازه‌گیری‌شده را وارد و بررسی کنید.',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Color(
                                                                        0xff526073)))
                                                          ]))
                                                    ])),
                                                const SizedBox(height: 20),
                                                if (_pressure) ...[
                                                  _input(
                                                      label:
                                                          'فشار سیستول (عدد بالا)',
                                                      hint: 'مثلاً ۱۲۰',
                                                      unit: 'mmHg',
                                                      controller: _first,
                                                      min: 50,
                                                      max: 300,
                                                      keyName: 'systolic',
                                                      action:
                                                          TextInputAction.next),
                                                  const SizedBox(height: 16),
                                                  _input(
                                                      label:
                                                          'فشار دیاستول (عدد پایین)',
                                                      hint: 'مثلاً ۸۰',
                                                      unit: 'mmHg',
                                                      controller: _second,
                                                      min: 20,
                                                      max: 150,
                                                      keyName: 'diastolic'),
                                                ] else
                                                  _input(
                                                      label: 'مقدار قند خون',
                                                      hint: 'مثلاً ۱۲۴',
                                                      unit: 'mg/dL',
                                                      controller: _first,
                                                      min: 1,
                                                      max: 1000,
                                                      keyName: 'bloodSugar'),
                                                if (_error != null)
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 14),
                                                      child: Text(_error!,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red))),
                                                const SizedBox(height: 18),
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
                                                              'پیش از ثبت، مقدار و واحد اندازه‌گیری را بررسی کنید.',
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
                                                : Text('ثبت $title'))),
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
