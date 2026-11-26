import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/AppConfig.dart';
import '../../authentication/data/AuthenticationRepository.dart';
import '../../../core/api_exception.dart';
import '../model/patient_registration.dart';
import '../data/patient_repository.dart';
import '../viewmodel/patient_registration_view_model.dart';

const _navy = Color(0xff0c1b31);
const _teal = Color(0xff007d85);
const _background = Color(0xffedf3f8);
const _border = Color(0xffc5d1dc);

class _PersianRegistrationLocalizations extends PersianMaterialLocalizations {
  const _PersianRegistrationLocalizations();

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

class _PersianRegistrationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _PersianRegistrationDelegate();
  @override
  bool isSupported(Locale locale) => locale.languageCode == 'fa';
  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      SynchronousFuture<MaterialLocalizations>(
          const _PersianRegistrationLocalizations());
  @override
  bool shouldReload(_PersianRegistrationDelegate old) => false;
}

class PatientRegistrationScreen extends StatefulWidget {
  const PatientRegistrationScreen({
    super.key,
    required this.source,
    required this.shiftActive,
    required this.onChangeShift,
    required this.onExit,
    required this.onEditProfile,
    required this.notificationButton,
    this.repository,
    this.showBackButton = false,
  });

  final PatientRegistrationSource source;
  final bool shiftActive;
  final ValueChanged<bool> onChangeShift;
  final VoidCallback onExit;
  final VoidCallback onEditProfile;
  final Widget notificationButton;
  final PatientRepository? repository;
  final bool showBackButton;

  @override
  State<PatientRegistrationScreen> createState() =>
      _PatientRegistrationScreenState();
}

class _PatientRegistrationScreenState extends State<PatientRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _nationalCode = TextEditingController();
  final _age = TextEditingController();
  late final PatientRegistrationViewModel _viewModel;
  bool _submitted = false;
  bool _preparing = false;
  bool _changingShift = false;
  int _gender = 2;
  bool _withoutInfo = false;
  bool _manualTime = false;
  Jalali? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _timeError;
  @override
  void initState() {
    super.initState();
    _viewModel = PatientRegistrationViewModel(repository: widget.repository);
  }
  @override
  void dispose() {
    _name.dispose();
    _nationalCode.dispose();
    _age.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  String _date(DateTime value) {
    final date = Jalali.fromDateTime(value);
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _changeShift() async {
    if (_changingShift || _preparing || _viewModel.isLoading) return;
    setState(() => _changingShift = true);
    try {
      final preferences = await SharedPreferences.getInstance();
      final userId = preferences.getString('UserId');
      if (userId == null || userId.isEmpty) {
        if (mounted) {
          _message('اطلاعات کاربر در دسترس نیست؛ دوباره وارد حساب کاربری شوید');
        }
        return;
      }
      final result =
          await AuthenticationRepository().changeShiftStatus(userId: userId);
      if (!mounted) return;
      if (!result.success || result.data == null) {
        _message(result.message.isEmpty
            ? 'تغییر وضعیت شیفت ناموفق بود'
            : result.message);
        return;
      }
      final isOnline = result.data!.isOnline;
      widget.onChangeShift(isOnline);
      await preferences.setBool('isOnline', isOnline);
    } on ApiException catch (error) {
      if (mounted && !error.isCancelled) _message(error.toString());
    } catch (_) {
      if (mounted) _message('تغییر وضعیت شیفت ناموفق بود؛ دوباره تلاش کنید');
    } finally {
      if (mounted) setState(() => _changingShift = false);
    }
  }

  Future<void> _register() async {
    if (_preparing || _viewModel.isLoading || _changingShift) return;
    if (!widget.shiftActive) {
      _message('برای ثبت بیمار ابتدا شیفت خود را فعال کنید');
      return;
    }
    setState(() => _submitted = true);
    if (!_withoutInfo && !_formKey.currentState!.validate()) return;

    final pressedAt = DateTime.now();
    DateTime registeredAt = pressedAt;
    if (_manualTime) {
      if (_selectedDate == null || _selectedTime == null) {
        setState(() => _timeError = 'تاریخ و ساعت ثبت را انتخاب کنید.');
        return;
      }
      final date = _selectedDate!.toGregorian();
      registeredAt = DateTime(date.year, date.month, date.day,
          _selectedTime!.hour, _selectedTime!.minute);
      if (registeredAt.isAfter(pressedAt)) {
        setState(() => _timeError = 'زمان ثبت نمی‌تواند در آینده باشد.');
        return;
      }
    }

    setState(() => _preparing = true);
    String? userId;
    try {
      final preferences = await SharedPreferences.getInstance();
      userId = preferences.getString('UserId');
    } catch (_) {
      if (mounted) {
        setState(() => _preparing = false);
        _message('خواندن اطلاعات کاربر ناموفق بود؛ دوباره تلاش کنید');
      }
      return;
    }
    if (!mounted) return;
    if (userId == null || userId.isEmpty) {
      setState(() => _preparing = false);
      _message('اطلاعات کاربر در دسترس نیست؛ دوباره وارد حساب کاربری شوید');
      return;
    }
    final patient = PatientRegistration(
      fullName: _name.text.trim(),
      nationalCode: _nationalCode.text,
      age: _age.text,
      genderId: _gender,
      source: widget.source,
      registeredDate: _date(registeredAt),
      registeredAt: registeredAt,
      registeredBy: userId,
      withoutInfo: _withoutInfo,
    );
    final success = await _viewModel.register(patient);
    if (!mounted) return;
    setState(() => _preparing = false);
    if (success) {
      FocusScope.of(context).unfocus();
      _name.clear();
      _nationalCode.clear();
      _age.clear();
      setState(() {
        _gender = 2;
        _withoutInfo = false;
        _submitted = false;
        _manualTime = false;
        _selectedDate = null;
        _selectedTime = null;
        _timeError = null;
      });
      _message('بیمار با موفقیت ثبت شد');
    } else if (_viewModel.errorMessage != null) {
      _message(_viewModel.errorMessage!.isEmpty
          ? 'ثبت بیمار ناموفق بود؛ دوباره تلاش کنید'
          : _viewModel.errorMessage!);
    }
  }

  void _message(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text(text, textDirection: TextDirection.rtl)));
  }

  @override
  Widget build(BuildContext context) {
    final sourceTitle = widget.source == PatientRegistrationSource.attending
        ? 'دکتر متخصص'
        : widget.source == PatientRegistrationSource.resident
            ? 'رزیدنت'
            : 'تریاژ / پرستار استروک';
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) {
        final busy = _preparing || _viewModel.isLoading || _changingShift;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: _background,
            body: SafeArea(
                child: Center(
                    child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 464),
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: const Color(0xfffafbfc),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x260b2c4b),
                          blurRadius: 14,
                          offset: Offset(0, 5))
                    ],
                  ),
                  child: Column(children: [
                    _header(sourceTitle),
                    Expanded(
                        child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(18, 17, 18, 24),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text('ثبت بیمار جدید',
                                style: TextStyle(
                                    color: _navy,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900)),
                            const SizedBox(height: 4),
                            const Text('اطلاعات اولیه را وارد کنید',
                                style: TextStyle(
                                    color: Color(0xff5d6775),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                            const SizedBox(height: 22),
                            _label('منبع پذیرش'),
                            _sourceSelector(),
                            const SizedBox(height: 19),
                            SwitchListTile.adaptive(
                              key: const ValueKey('without-info'),
                              contentPadding: EdgeInsets.zero,
                              title: const Text('بیمار مجهول‌الهویه', style: TextStyle(fontWeight: FontWeight.bold, color: _navy)),
                              subtitle: const Text('ثبت بیمار بدون اطلاعات هویتی', style: TextStyle(fontSize: 12)),
                              value: _withoutInfo,
                              onChanged: busy ? null : (value) => setState(() { _withoutInfo = value; _submitted = false; }),
                            ),
                            if (!_withoutInfo) _patientForm(),
                            if (widget.source !=
                                PatientRegistrationSource.attending) ...[
                              const SizedBox(height: 20),
                              _registrationTimeSelector(busy),
                            ],
                            const SizedBox(height: 22),
                            _notice(
                                icon: Icons.info_outline,
                                text:
                                    'پس از ثبت، بیمار در مسیر بررسی رزیدنت قرار می‌گیرد.',
                                color: const Color(0xffd7efed),
                                textColor: _navy),
                            const SizedBox(height: 24),
                            SizedBox(
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: busy ? null : _register,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: _teal,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor:
                                          const Color(0xffc7d5d8),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(9))),
                                  child: busy
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white))
                                      : const Text('ثبت و اطلاع به رزیدنت',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17)),
                                )),
                          ]),
                    )),
                  ])),
            ))),
          ),
        );
      },
    );
  }

  Widget _header(String title) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xffe0e6ec)))),
        child: Row(children: [
          if (widget.showBackButton)
            IconButton(onPressed: _preparing || _viewModel.isLoading || _changingShift ? null : () => Navigator.pop(context),
                tooltip: 'بازگشت', icon: const Icon(Icons.arrow_forward, color: _navy)),
          Image.asset('web/icons/Icon-512.png', height: 30, width: 30),
          const SizedBox(width: 3),
          const Text('استروک',
              style: TextStyle(
                  color: _navy, fontSize: 14, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Spacer(),
          InkWell(
            onTap: _preparing || _viewModel.isLoading || _changingShift
                ? null
                : _changeShift,
            borderRadius: BorderRadius.circular(24),
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: BoxDecoration(
                    color: const Color(0xffe8f4ef),
                    borderRadius: BorderRadius.circular(24)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.circle,
                      size: 10,
                      color: widget.shiftActive
                          ? const Color(0xff4caf50)
                          : Colors.grey),
                  const SizedBox(width: 4),
                  Text(widget.shiftActive ? 'شیفت فعال' : 'شیفت غیرفعال',
                      style: const TextStyle(
                          color: _navy,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ])),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: PopupMenuButton<String>(
              tooltip: 'حساب کاربری',
              onSelected: (value) {
                if (value == 'edit') {
                  widget.onEditProfile();
                } else {
                  widget.onExit();
                }
              },
              itemBuilder: (_) => [
                const PopupMenuItem(
                    value: 'edit', child: Text('ویرایش حساب کاربری')),
                const PopupMenuItem(value: 'exit', child: Text('خروج از حساب'))
              ],
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                decoration: BoxDecoration(
                    color: const Color(0xffeaf0f5),
                    borderRadius: BorderRadius.circular(24)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(Icons.person_outline, size: 17, color: _navy),
                  const SizedBox(width: 3),
                  Flexible(
                      child: Text(title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: _navy,
                              fontSize: 10,
                              fontWeight: FontWeight.bold))),
                ]),
              ),
            ),
          ),
          IconButtonTheme(
            data: IconButtonThemeData(
                style: IconButton.styleFrom(
                    minimumSize: const Size(36, 40),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap)),
            child: IconTheme(
                data: const IconThemeData(color: _navy, size: 22),
                child: widget.notificationButton),
          ),
        ]),
      );

  Widget _label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(text,
          style: const TextStyle(
              color: _navy, fontWeight: FontWeight.w900, fontSize: 15)));

  Widget _localizedPicker(BuildContext context, Widget? child) =>
      Localizations.override(
          context: context,
          locale: const Locale('fa', 'IR'),
          delegates: const [_PersianRegistrationDelegate()],
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: true),
                  child: child!)));

  Future<void> _pickRegistrationDate() async {
    final today = Jalali.now();
    final picked = await showPersianDatePicker(
        context: context,
        initialDate: _selectedDate ?? today,
        firstDate: Jalali(1300, 1, 1),
        lastDate: today,
        builder: _localizedPicker);
    if (picked != null && mounted) {
      setState(() {
        _selectedDate = picked;
        _timeError = null;
      });
    }
  }

  Future<void> _pickRegistrationTime() async {
    final picked = await showTimePicker(
        context: context,
        initialTime: _selectedTime ?? TimeOfDay.now(),
        builder: _localizedPicker);
    if (picked != null && mounted) {
      setState(() {
        _selectedTime = picked;
        _timeError = null;
      });
    }
  }

  Widget _registrationTimeSelector(bool busy) {
    final date = _selectedDate;
    final time = _selectedTime;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      _label('زمان ثبت بیمار'),
      _timeMode(
          'زمان فعلی', 'تاریخ و ساعت در لحظه ثبت ذخیره می‌شود.', false, busy),
      const SizedBox(height: 8),
      _timeMode('انتخاب تاریخ و ساعت', 'زمان ثبت را به‌صورت دستی مشخص کنید.',
          true, busy),
      if (_manualTime) ...[
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
              child: OutlinedButton.icon(
                  key: const ValueKey('registration-date'),
                  onPressed: busy ? null : _pickRegistrationDate,
                  icon: const Icon(Icons.calendar_today_outlined, size: 18),
                  label: Text(date == null
                      ? 'انتخاب تاریخ'
                      : AppConfig.digits(
                          '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}')),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: _teal, minimumSize: const Size(0, 48)))),
          const SizedBox(width: 8),
          Expanded(
              child: OutlinedButton.icon(
                  key: const ValueKey('registration-time'),
                  onPressed: busy ? null : _pickRegistrationTime,
                  icon: const Icon(Icons.access_time, size: 18),
                  label: Text(time == null
                      ? 'انتخاب ساعت'
                      : AppConfig.digits(
                          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}')),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: _teal, minimumSize: const Size(0, 48)))),
        ]),
      ],
      if (_timeError != null)
        Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(_timeError!,
                style: const TextStyle(color: Colors.red, fontSize: 12))),
    ]);
  }

  Widget _timeMode(String title, String description, bool manual, bool busy) =>
      Material(
          color: _manualTime == manual ? const Color(0xffe0f3ef) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          child: RadioListTile<bool>(
              value: manual,
              groupValue: _manualTime,
              onChanged: busy
                  ? null
                  : (value) => setState(() {
                        _manualTime = value!;
                        _timeError = null;
                      }),
              activeColor: _teal,
              dense: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: _manualTime == manual ? _teal : _border)),
              title: Text(title,
                  style: const TextStyle(
                      color: _navy, fontWeight: FontWeight.bold, fontSize: 14)),
              subtitle: Text(description,
                  style: const TextStyle(
                      color: Color(0xff5d6775), fontSize: 12))));

  Widget _sourceSelector() =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Container(
            decoration: BoxDecoration(
                color: const Color(0xfff2f5f8),
                borderRadius: BorderRadius.circular(9),
                border: Border.all(color: _border)),
            child: Row(children: [
              _sourceItem(
                  'تریاژ', widget.source == PatientRegistrationSource.triage),
              _sourceItem('پرستار استروک',
                  widget.source == PatientRegistrationSource.ems),
              _sourceItem('رزیدنت', widget.source == PatientRegistrationSource.resident),
            ])),
        if (widget.source == PatientRegistrationSource.attending)
          const Padding(
              padding: EdgeInsets.only(top: 8),
              child:
                  Text('منبع ثبت: دکتر متخصص', style: TextStyle(color: _teal))),
      ]);

  Widget _sourceItem(String label, bool selected) => Expanded(
          child: Container(
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: selected ? _teal : Colors.transparent,
            borderRadius: BorderRadius.circular(8)),
        child: FittedBox(fit: BoxFit.scaleDown, child: Text(label,
            style: TextStyle(
                color: selected ? Colors.white : _navy,
                fontSize: 14,
                fontWeight: FontWeight.bold))),
      ));

  Widget _patientForm() => Form(
        key: _formKey,
        autovalidateMode: _submitted
            ? AutovalidateMode.onUserInteraction
            : AutovalidateMode.disabled,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          _label('نام و نام خانوادگی'),
          TextFormField(
            controller: _name,
            readOnly: _preparing || _viewModel.isLoading,
            textInputAction: TextInputAction.next,
            decoration: _input('نام بیمار را وارد کنید'),
            validator: (value) {
              final text = value?.trim() ?? '';
              if (text.isEmpty) return 'نام و نام خانوادگی را وارد کنید';
              if (!RegExp(r'^[\u0600-\u06FF\s]+$').hasMatch(text) ||
                  RegExp(r'[0-9۰-۹٠-٩]').hasMatch(text)) {
                return 'نام بیمار را با حروف فارسی وارد کنید';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),
          _label('کد ملی'),
          TextFormField(
            controller: _nationalCode,
            readOnly: _preparing || _viewModel.isLoading,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.right,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            maxLength: 10,
            inputFormatters: [
              _DigitFormatter(),
              LengthLimitingTextInputFormatter(10)
            ],
            decoration: _input('کد ملی بیمار').copyWith(counterText: ''),
          ),
          const SizedBox(height: 14),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  _label('جنسیت'),
                  Row(children: [
                    _genderItem('مرد', 2),
                    const SizedBox(width: 6),
                    _genderItem('زن', 1)
                  ]),
                ])),
            const SizedBox(width: 12),
            SizedBox(
                width: 100,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _label('سن'),
                      TextFormField(
                          controller: _age,
                          readOnly: _preparing || _viewModel.isLoading,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          inputFormatters: [
                            _DigitFormatter(),
                            LengthLimitingTextInputFormatter(3)
                          ],
                          decoration: _input('سن')),
                    ])),
          ]),
        ]),
      );

  Widget _genderItem(String text, int value) => Expanded(
        child: InkWell(
          onTap: _preparing || _viewModel.isLoading
              ? null
              : () => setState(() => _gender = value),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:
                    _gender == value ? const Color(0xffe0f3ef) : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _gender == value ? _teal : _border)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (_gender == value) ...[
                const Icon(Icons.check, size: 18, color: _teal),
                const SizedBox(width: 8)
              ],
              Text(text,
                  style: const TextStyle(
                      color: _navy, fontWeight: FontWeight.bold)),
            ]),
          ),
        ),
      );

  InputDecoration _input(String hint) => InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(color: Color(0xff8998a5), fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: _teal, width: 2)),
      );

  Widget _notice(
          {required IconData icon,
          required String text,
          required Color color,
          required Color textColor}) =>
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: 10),
          Expanded(
              child:
                  Text(text, style: TextStyle(color: textColor, fontSize: 13))),
        ]),
      );
}

class _DigitFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final buffer = StringBuffer();
    var selection = 0;
    for (var i = 0; i < newValue.text.length; i++) {
      final code = newValue.text.codeUnitAt(i);
      final digit = code >= 0x06f0 && code <= 0x06f9
          ? code - 0x06f0
          : code >= 0x0660 && code <= 0x0669
              ? code - 0x0660
              : code >= 0x30 && code <= 0x39
                  ? code - 0x30
                  : null;
      if (digit != null) {
        buffer.write(digit);
        if (i < newValue.selection.baseOffset) selection++;
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: selection));
  }
}
