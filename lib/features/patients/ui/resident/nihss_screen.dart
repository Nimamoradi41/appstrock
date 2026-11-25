import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../../data/resident_patient_repository.dart';

class _NihssItem {
  const _NihssItem(this.title, this.english, this.icon, this.options);
  final String title;
  final String english;
  final IconData icon;
  final List<String> options;
}

const _items = <_NihssItem>[
  _NihssItem(
      'سطح هوشیاری', 'Level of Consciousness', Icons.psychology_outlined, [
    'هوشیار',
    'خواب‌آلود؛ با تحریک جزئی پاسخ می‌دهد',
    'برای پاسخ به تحریک مکرر یا دردناک نیاز دارد',
    'فقط پاسخ حرکتی یا واکنشی دارد یا پاسخ نمی‌دهد'
  ]),
  _NihssItem('پرسش‌های هوشیاری', 'LOC Questions', Icons.help_outline,
      ['هر دو پاسخ درست', 'یک پاسخ درست', 'هیچ پاسخ درست نیست']),
  _NihssItem(
      'اجرای دستورات',
      'LOC Commands',
      Icons.assignment_turned_in_outlined,
      ['هر دو دستور درست', 'یک دستور درست', 'هیچ دستوری درست نیست']),
  _NihssItem('حرکت چشم‌ها', 'Best Gaze', Icons.visibility_outlined,
      ['طبیعی', 'فلج نسبی نگاه', 'انحراف اجباری یا فلج کامل نگاه']),
  _NihssItem('میدان بینایی', 'Visual', Icons.remove_red_eye_outlined, [
    'بدون کاهش بینایی',
    'همی‌آنوپی نسبی',
    'همی‌آنوپی کامل',
    'همی‌آنوپی دوطرفه یا کوری'
  ]),
  _NihssItem('فلج صورت', 'Facial Palsy', Icons.face_outlined,
      ['حرکت طبیعی', 'فلج خفیف', 'فلج نسبی', 'فلج کامل']),
  _NihssItem('حرکت دست چپ', 'Motor Arm — Left', Icons.pan_tool_alt_outlined, [
    'بدون افت',
    'افت اندام',
    'حرکت مختصر در برابر جاذبه',
    'بدون حرکت در برابر جاذبه',
    'بدون حرکت'
  ]),
  _NihssItem(
      'حرکت دست راست', 'Motor Arm — Right', Icons.pan_tool_alt_outlined, [
    'بدون افت',
    'افت اندام',
    'حرکت مختصر در برابر جاذبه',
    'بدون حرکت در برابر جاذبه',
    'بدون حرکت'
  ]),
  _NihssItem('حرکت پای چپ', 'Motor Leg — Left', Icons.directions_walk, [
    'بدون افت',
    'افت اندام',
    'حرکت مختصر در برابر جاذبه',
    'بدون حرکت در برابر جاذبه',
    'بدون حرکت'
  ]),
  _NihssItem('حرکت پای راست', 'Motor Leg — Right', Icons.directions_walk, [
    'بدون افت',
    'افت اندام',
    'حرکت مختصر در برابر جاذبه',
    'بدون حرکت در برابر جاذبه',
    'بدون حرکت'
  ]),
  _NihssItem('آتاکسی اندام', 'Limb Ataxia', Icons.accessibility_new,
      ['وجود ندارد', 'در یک اندام', 'در دو اندام']),
  _NihssItem('حس', 'Sensory', Icons.touch_app_outlined,
      ['طبیعی', 'کاهش خفیف تا متوسط حس', 'کاهش شدید یا کامل حس']),
  _NihssItem('زبان', 'Best Language', Icons.record_voice_over_outlined, [
    'بدون آفازی',
    'آفازی خفیف تا متوسط',
    'آفازی شدید',
    'بی‌کلام یا آفازی کامل'
  ]),
  _NihssItem('تکلم', 'Dysarthria', Icons.chat_bubble_outline, [
    'تکلم طبیعی',
    'دیس‌آرتری خفیف تا متوسط',
    'دیس‌آرتری شدید یا غیرقابل فهم'
  ]),
  _NihssItem('بی‌توجهی و خاموشی', 'Extinction and Inattention',
      Icons.center_focus_weak, [
    'بدون بی‌توجهی',
    'بی‌توجهی در یک نوع تحریک',
    'بی‌توجهی شدید یا در بیش از یک نوع تحریک'
  ]),
];

class NihssScreen extends StatefulWidget {
  const NihssScreen({super.key, required this.patient, required this.onSubmit});

  final ModelPatient patient;
  final Future<PatientOperationResult> Function(List<Map<String, dynamic>>, int)
      onSubmit;

  @override
  State<NihssScreen> createState() => _NihssScreenState();
}

class _NihssScreenState extends State<NihssScreen> {
  late final List<int?> _answers;
  final Set<int> _expanded = {0, 1, 2};
  bool _submitting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final patient = widget.patient;
    final values = [
      patient.n_1_a,
      patient.n_1_b,
      patient.n_1_c,
      patient.n_2,
      patient.n_3,
      patient.n_4,
      patient.n_5_a,
      patient.n_5_b,
      patient.n_6_a,
      patient.n_6_b,
      patient.n_7,
      patient.n_8,
      patient.n_9,
      patient.n_10,
      patient.n_11
    ];
    _answers = List.generate(_items.length, (index) {
      if (!patient.nihsIsComplete) return null;
      final value = int.tryParse(values[index]);
      return value != null && value >= 0 && value < _items[index].options.length
          ? value
          : null;
    });
  }

  int get _score => _answers.fold(0, (total, value) => total + (value ?? 0));
  int get _completed => _answers.where((answer) => answer != null).length;

  Future<void> _submit() async {
    if (_submitting) return;
    if (_completed != _items.length) {
      setState(() => _error = 'برای ثبت ارزیابی، به همه ۱۵ بخش پاسخ دهید.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final result = await widget.onSubmit(
          _answers
              .map((answer) => <String, dynamic>{'selected_answer': answer})
              .toList(),
          _score);
      if (!mounted) return;
      if (result.success) {
        Navigator.of(context).pop(true);
      } else {
        setState(() => _error = result.message.isEmpty
            ? 'ثبت ارزیابی ناموفق بود.'
            : result.message);
      }
    } catch (_) {
      if (mounted) {
        setState(() => _error = 'ثبت ارزیابی ناموفق بود. دوباره تلاش کنید.');
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  Widget _card(int index) {
    final item = _items[index];
    final answer = _answers[index];
    final expanded = _expanded.contains(index);
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color:
              expanded && index >= 3 ? const Color(0xffeaf8f3) : Colors.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
              color: expanded && index >= 3
                  ? const Color(0xffa2ddce)
                  : const Color(0xffd6dfe6))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
            onTap: () => setState(() {
                  if (expanded) {
                    _expanded.remove(index);
                  } else {
                    _expanded.add(index);
                  }
                }),
            child: Row(children: [
              Icon(item.icon, color: const Color(0xff40516a), size: 25),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(item.title,
                        style: const TextStyle(
                            color: AppConfig.inkColorResident,
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    Text(item.english,
                        textDirection: TextDirection.ltr,
                        style: const TextStyle(
                            color: Color(0xff526073), fontSize: 12)),
                  ])),
              Icon(
                  expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: AppConfig.inkColorResident),
            ])),
        if (expanded) ...[
          if (answer != null)
            Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                            color: const Color(0xffd1f5df),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text(item.options[answer],
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff12664a)))))),
          const SizedBox(height: 8),
          Row(
              children: List.generate(
                  item.options.length,
                  (value) => Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: value == item.options.length - 1 ? 0 : 6),
                          child: Semantics(
                            button: true,
                            selected: value == answer,
                            label:
                                '${AppConfig.digits('$value')}، ${item.options[value]}',
                            child: OutlinedButton(
                                key: ValueKey('nihss-$index-$value'),
                                onPressed: _submitting
                                    ? null
                                    : () => setState(() {
                                          _answers[index] = value;
                                          _error = null;
                                        }),
                                style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: const Size(0, 36),
                                    backgroundColor: value == answer
                                        ? AppConfig.tealColorResident
                                        : Colors.white,
                                    foregroundColor: value == answer
                                        ? Colors.white
                                        : AppConfig.inkColorResident,
                                    side: BorderSide(
                                        color: value == answer
                                            ? AppConfig.tealColorResident
                                            : const Color(0xffccd6de))),
                                child: Text(AppConfig.digits('$value'),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold))),
                          ))))),
        ] else if (answer != null) ...[
          const SizedBox(height: 6),
          Text(
              'پاسخ انتخاب‌شده: ${AppConfig.digits('$answer')} · ${item.options[answer]}',
              style: const TextStyle(fontSize: 12, color: Color(0xff526073))),
        ],
      ]),
    );
  }

  @override
  Widget build(BuildContext context) => PopScope(
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
                                      child: Text('ارزیابی NIHSS',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppConfig.inkColorResident)))
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
                                                    color:
                                                        const Color(0xffe0f6ed),
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
                                                    '${widget.patient.fullName.isEmpty ? 'نام ثبت نشده' : widget.patient.fullName}  ·  ${widget.patient.age.isEmpty ? '—' : AppConfig.digits(widget.patient.age)} سال',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppConfig
                                                            .inkColorResident)))
                                          ]),
                                          const SizedBox(height: 16),
                                          Container(
                                              padding: const EdgeInsets.all(14),
                                              decoration: BoxDecoration(
                                                  color: AppConfig
                                                      .tealColorResident,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Row(children: [
                                                Column(children: [
                                                  const Text('امتیاز فعلی',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Text(
                                                      AppConfig.digits(
                                                          '$_score'),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 36,
                                                          fontWeight:
                                                              FontWeight.bold))
                                                ]),
                                                Container(
                                                    width: 1,
                                                    height: 64,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 16),
                                                    color: Colors.white54),
                                                Expanded(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                      Text(
                                                          _completed == 15
                                                              ? 'تکمیل شده'
                                                              : 'در حال تکمیل',
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                          '${AppConfig.digits('$_completed')} از ۱۵ بخش تکمیل شده',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      12)),
                                                      const SizedBox(height: 8),
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: LinearProgressIndicator(
                                                              value:
                                                                  _completed /
                                                                      15,
                                                              minHeight: 8,
                                                              color: const Color(
                                                                  0xff62d1ba),
                                                              backgroundColor:
                                                                  Colors.white))
                                                    ])),
                                              ])),
                                          const SizedBox(height: 14),
                                          for (var index = 0;
                                              index < _items.length;
                                              index++)
                                            _card(index),
                                          const Row(children: [
                                            Icon(Icons.info_outline,
                                                size: 18,
                                                color: Color(0xff607185)),
                                            SizedBox(width: 8),
                                            Expanded(
                                                child: Text(
                                                    'امتیاز بر اساس پاسخ‌های ثبت‌شده محاسبه می‌شود.',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff607185),
                                                        fontSize: 12)))
                                          ]),
                                          if (_error != null)
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Text(_error!,
                                                    style: const TextStyle(
                                                        color: Colors.red))),
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
                                              : Text(
                                                  widget.patient.nihsIsComplete
                                                      ? 'ثبت ویرایش NIHSS'
                                                      : 'ثبت ارزیابی NIHSS'))),
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
