import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../../../../core/AppConfig.dart';
import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../data/resident_patient_repository.dart';

class _PersianLocalizations extends PersianMaterialLocalizations {
  const _PersianLocalizations();

  @override
  String formatDecimal(int number) =>
      AppConfig.digits(super.formatDecimal(number));
  @override
  String formatYear(DateTime date) => AppConfig.digits(super.formatYear(date));
  @override
  String formatMediumDate(DateTime date) =>
      AppConfig.digits(super.formatMediumDate(date));
  @override
  String formatShortDate(DateTime date) =>
      AppConfig.digits(super.formatShortDate(date));
  @override
  String formatMonthYear(DateTime date) =>
      AppConfig.digits(super.formatMonthYear(date));
}

class _PersianDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const _PersianDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'fa';
  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(const _PersianLocalizations());
  @override
  bool shouldReload(_PersianDelegate old) => false;
}

class _Moment {
  _Moment(DateTime now)
      : date = Jalali.fromDateTime(now),
        time = TimeOfDay.fromDateTime(now);

  Jalali date;
  TimeOfDay time;

  String get dateText =>
      '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  String get timeText =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  DateTime get value {
    final gregorian = date.toGregorian();
    return DateTime(
        gregorian.year, gregorian.month, gregorian.day, time.hour, time.minute);
  }
}

class Activation724Form extends StatefulWidget {
  const Activation724Form(
      {super.key, required this.patient, required this.onSubmit});

  final ModelPatient patient;

  final Future<PatientOperationResult> Function({
    required bool unknown,
    required String startTime,
    required String startDate,
    required String fssTime,
    required String fssDate,
    required String lkwTime,
    required String lkwDate,
    required String timestamp,
    required String lkwTimestamp,
    required String fssTimestamp,
  }) onSubmit;

  @override
  State<Activation724Form> createState() => _Activation724FormState();
}

class _Activation724FormState extends State<Activation724Form> {
  late final _Moment _start;
  late final _Moment _lkw;
  late final _Moment _fss;
  bool _unknown = false;
  bool _review = false;
  bool _submitting = false;
  bool _explanationExpanded = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _start = _Moment(now);
    _lkw = _Moment(now);
    _fss = _Moment(now);
    _unknown = widget.patient.signsStartIsUnknown == true;
    _restoreMoment(_start, widget.patient.signsStartTS);
    _restoreMoment(_lkw, widget.patient.signsStartTSLKW);
    _restoreMoment(_fss, widget.patient.signsStartTSFSS);
  }

  void _restoreMoment(_Moment moment, int? timestamp) {
    if (timestamp == null || timestamp <= 0) return;
    final value = DateTime.fromMillisecondsSinceEpoch(timestamp);
    moment.date = Jalali.fromDateTime(value);
    moment.time = TimeOfDay.fromDateTime(value);
  }

  Widget _localized(BuildContext context, Widget? child) =>
      Localizations.override(
        context: context,
        locale: const Locale('fa', 'IR'),
        delegates: const [_PersianDelegate()],
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        ),
      );

  Future<void> _pickDate(_Moment moment) async {
    final picked = await showPersianDatePicker(
      context: context,
      initialDate: moment.date,
      firstDate: Jalali(1300, 1, 1),
      lastDate: Jalali.now(),
      builder: _localized,
    );
    if (picked != null && mounted) {
      setState(() {
        moment.date = picked;
        _error = null;
      });
    }
  }

  Future<void> _pickTime(_Moment moment) async {
    final picked = await showTimePicker(
        context: context, initialTime: moment.time, builder: _localized);
    if (picked != null && mounted) {
      setState(() {
        moment.time = picked;
        _error = null;
      });
    }
  }

  Future<void> _next() async {
    final now = DateTime.now();
    if ((_unknown ? [_lkw, _fss] : [_start])
        .any((moment) => moment.value.isAfter(now))) {
      setState(() => _error = 'زمان انتخاب‌شده نمی‌تواند در آینده باشد.');
      return;
    }
    if (_unknown && _lkw.value.isAfter(_fss.value)) {
      setState(() => _error =
          'آخرین زمان بدون علامت باید پیش از اولین مشاهده علائم باشد.');
      return;
    }
    setState(() {
      _error = null;
      _review = true;
    });
  }

  Future<void> _submit() async {
    if (_submitting) return;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final result = await widget.onSubmit(
        unknown: _unknown,
        startTime: _unknown ? '' : _start.timeText,
        startDate: _unknown ? '' : _start.dateText,
        fssTime: _unknown ? _fss.timeText : '',
        fssDate: _unknown ? _fss.dateText : '',
        lkwTime: _unknown ? _lkw.timeText : '',
        lkwDate: _unknown ? _lkw.dateText : '',
        timestamp: _unknown ? '' : '${_start.value.millisecondsSinceEpoch}',
        lkwTimestamp: _unknown ? '${_lkw.value.millisecondsSinceEpoch}' : '',
        fssTimestamp: _unknown ? '${_fss.value.millisecondsSinceEpoch}' : '',
      );
      if (!mounted) return;
      if (result.success) {
        Navigator.pop(context, true);
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

  Widget _field(
          String label, String value, IconData icon, VoidCallback onTap) =>
      Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9),
            side: const BorderSide(color: Color(0xffdce3e8))),
        child: InkWell(
          borderRadius: BorderRadius.circular(9),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(children: [
              Icon(icon, size: 21, color: AppConfig.inkColorResident),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 13))),
              Text(AppConfig.digits(value),
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ]),
          ),
        ),
      );

  Widget _momentFields(_Moment moment, String suffix) => Column(children: [
        _field('تاریخ $suffix', moment.dateText, Icons.calendar_month_outlined,
            () => _pickDate(moment)),
        const SizedBox(height: 7),
        _field('ساعت $suffix', moment.timeText, Icons.access_time,
            () => _pickTime(moment)),
      ]);

  Widget _choice(bool unknown) {
    final selected = _unknown == unknown;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: selected ? const Color(0xffe2f7f0) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
            color: selected
                ? AppConfig.tealColorResident
                : const Color(0xffd2dbe3)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InkWell(
          onTap: () => setState(() {
            _unknown = unknown;
            _error = null;
          }),
          child: Row(children: [
            Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked,
                color: selected
                    ? AppConfig.tealColorResident
                    : const Color(0xff929da9),
                size: 22),
            const SizedBox(width: 9),
            Expanded(
                child: Text(
                    unknown ? 'زمان شروع مشخص نیست' : 'زمان شروع مشخص است',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15))),
          ]),
        ),
        if (selected) ...[
          const SizedBox(height: 12),
          if (!unknown)
            _momentFields(_start, 'شروع علائم')
          else ...[
            const Text('آخرین زمانی که بیمار بدون علامت دیده شده است (LKW)',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            _momentFields(_lkw, 'LKW'),
            const SizedBox(height: 14),
            const Text(
                'اولین زمانی که علائم توسط بیمار یا اطرافیان مشاهده شده است (FSS)',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 8),
            _momentFields(_fss, 'FSS'),
          ],
        ],
      ]),
    );
  }

  Widget _steps() => Row(
          children: List.generate(3, (index) {
        final current = (_review ? 1 : 0) == index;
        return Expanded(
            child: Column(children: [
          Row(children: [
            Expanded(
                child: Container(
                    height: 1.5,
                    color: index == 0
                        ? Colors.transparent
                        : const Color(0xffaab6c1))),
            Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: current ? AppConfig.tealColorResident : Colors.white,
                    border: Border.all(
                        color: current
                            ? AppConfig.tealColorResident
                            : const Color(0xffaab6c1))),
                child: Text(AppConfig.digits('${index + 1}'),
                    style: TextStyle(
                        color: current ? Colors.white : const Color(0xff526073),
                        fontWeight: FontWeight.bold))),
            Expanded(
                child: Container(
                    height: 1.5,
                    color: index == 2
                        ? Colors.transparent
                        : const Color(0xffaab6c1))),
          ]),
          const SizedBox(height: 4),
          Text(['زمان علائم', 'مرور', 'ثبت'][index],
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: current ? FontWeight.bold : FontWeight.normal)),
        ]));
      }));

  Widget _explanation() => Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xffd1dce6))),
        child: Column(children: [
          Material(
              color: const Color(0xffeaf0f6),
              child: InkWell(
                onTap: () => setState(
                    () => _explanationExpanded = !_explanationExpanded),
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    child: Row(children: [
                      const Expanded(
                          child: Text('اگر زمان شروع نامشخص باشد',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      Icon(_explanationExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ])),
              )),
          if (_explanationExpanded) ...[
            _explanationRow(Icons.person_outline,
                'LKW · آخرین زمانی که بیمار بدون علامت دیده شده است'),
            const Divider(height: 1),
            _explanationRow(Icons.visibility_outlined,
                'FSS · اولین زمانی که علائم توسط بیمار یا اطرافیان مشاهده شده است'),
          ],
        ]),
      );

  Widget _explanationRow(IconData icon, String text) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(children: [
          Icon(icon, color: const Color(0xff40516a)),
          const SizedBox(width: 10),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)))
        ]),
      );

  @override
  Widget build(BuildContext context) {
    final patient = widget.patient;
    final overTime =
        DateTime.now().difference(_unknown ? _lkw.value : _start.value) >
            const Duration(hours: 4, minutes: 30);
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
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                      child: Row(children: [
                        IconButton(
                            onPressed: _submitting
                                ? null
                                : () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_forward),
                            tooltip: 'بازگشت'),
                        const Expanded(
                            child: Text('فعال‌سازی کد ۷۲۴',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppConfig.inkColorResident))),
                      ])),
                  const Divider(height: 1),
                  Expanded(
                      child: SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffe0f6ed),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Icon(Icons.person_outline,
                                          color: AppConfig.inkColorResident)),
                                  const SizedBox(width: 12),
                                  Expanded(
                                      child: Text(
                                          '${patient.fullName.isEmpty ? 'نام ثبت نشده' : patient.fullName}  ·  ${patient.age.isEmpty ? '—' : AppConfig.digits(patient.age)} سال',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  AppConfig.inkColorResident))),
                                ]),
                                const SizedBox(height: 20),
                                _steps(),
                                const SizedBox(height: 18),
                                Text(
                                    _review
                                        ? 'مرور اطلاعات'
                                        : 'شروع علائم چه زمانی بوده؟',
                                    style: const TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: AppConfig.inkColorResident)),
                                const SizedBox(height: 5),
                                Text(
                                    _review
                                        ? 'اطلاعات را پیش از ثبت بررسی کنید.'
                                        : 'زمان‌ها را بر اساس اطلاعات بیمار ثبت کنید.',
                                    style: const TextStyle(
                                        color: Color(0xff526073),
                                        fontSize: 13)),
                                const SizedBox(height: 14),
                                if (!_review) ...[
                                  _choice(false),
                                  const SizedBox(height: 8),
                                  _choice(true),
                                  const SizedBox(height: 12),
                                  Row(children: [
                                    const Icon(Icons.access_time,
                                        size: 18, color: Color(0xff607185)),
                                    const SizedBox(width: 8),
                                    Text(
                                        'زمان ثبت بیمار: ${patient.timeOfAddToSystem.isEmpty ? 'نامشخص' : AppConfig.digits(patient.timeOfAddToSystem)}',
                                        style: const TextStyle(
                                            color: Color(0xff526073),
                                            fontSize: 12))
                                  ]),
                                  const SizedBox(height: 16),
                                  _explanation(),
                                ] else ...[
                                  Container(
                                      padding: const EdgeInsets.all(14),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffe2f7f0),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color:
                                                  AppConfig.tealColorResident)),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                                _unknown
                                                    ? 'زمان شروع مشخص نیست'
                                                    : 'زمان شروع مشخص است',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 10),
                                            if (_unknown) ...[
                                              Text(
                                                  'LKW: ${AppConfig.digits(_lkw.dateText)}  ${AppConfig.digits(_lkw.timeText)}'),
                                              const SizedBox(height: 8),
                                              Text(
                                                  'FSS: ${AppConfig.digits(_fss.dateText)}  ${AppConfig.digits(_fss.timeText)}'),
                                            ] else
                                              Text(
                                                  'شروع علائم: ${AppConfig.digits(_start.dateText)}  ${AppConfig.digits(_start.timeText)}'),
                                          ])),
                                  if (overTime)
                                    const Padding(
                                        padding: EdgeInsets.only(top: 12),
                                        child: Text(
                                            'بیش از ۴ ساعت و نیم از زمان انتخاب‌شده گذشته است. پیش از ثبت، زمان را بررسی کنید.',
                                            style: TextStyle(
                                                color: Color(0xffa75c00),
                                                fontWeight: FontWeight.w600))),
                                ],
                                const SizedBox(height: 14),
                                Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: const Color(0xffe2effb),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: const Color(0xffc7def5))),
                                    child: const Row(children: [
                                      Icon(Icons.info_outline,
                                          color: Color(0xff2059a2)),
                                      SizedBox(width: 8),
                                      Expanded(
                                          child: Text(
                                              'با ثبت کد، پرونده برای بررسی اتند آماده می‌شود.',
                                              style: TextStyle(fontSize: 13)))
                                    ])),
                                if (_error != null)
                                  Padding(
                                      padding: const EdgeInsets.only(top: 12),
                                      child: Text(_error!,
                                          style: const TextStyle(
                                              color: Colors.red))),
                              ]))),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                      child: Row(children: [
                        Expanded(
                            flex: 3,
                            child: FilledButton(
                                onPressed: _submitting
                                    ? null
                                    : (_review ? _submit : _next),
                                style: FilledButton.styleFrom(
                                    backgroundColor:
                                        AppConfig.tealColorResident,
                                    minimumSize: const Size(0, 48)),
                                child: _submitting
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                            strokeWidth: 2))
                                    : Text(_review
                                        ? 'ثبت'
                                        : 'مرور و ثبت'))),
                        const SizedBox(width: 10),
                        Expanded(
                            flex: 2,
                            child: OutlinedButton(
                                onPressed: _submitting
                                    ? null
                                    : () {
                                        if (_review) {
                                          setState(() {
                                            _review = false;
                                            _error = null;
                                          });
                                        } else {
                                          Navigator.pop(context);
                                        }
                                      },
                                style: OutlinedButton.styleFrom(
                                    foregroundColor: AppConfig.inkColorResident,
                                    minimumSize: const Size(0, 48)),
                                child: Text(
                                    _review
                                        ? 'ویرایش اطلاعات'
                                        : 'بازگشت به پرونده',
                                    textAlign: TextAlign.center))),
                      ])),
                ]),
              ),
            ))),
          )),
    );
  }
}
