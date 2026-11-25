import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Constants.dart';
import '../../../Screens/Atend/ScreenAtend.dart';
import '../../patient_registration/ui/screen_ems.dart';
import '../../../Screens/Laboratory/screen_Laboratory.dart';
import '../../../Screens/Reception/screen_reception.dart';
import '../../../Screens/Resident/resident_patients_preview.dart';
import '../../../Screens/SplashScreen.dart';
import '../../../Screens/Strok/ScreenStrock.dart';
import '../../../Screens/Teriazh/screen_teriazh.dart';
import '../../../Screens/sickcarrier/screen_sickcarrier.dart';
import '../../../Screens/Autentication/ApiServiceAutentication.dart';

const _navy = Color(0xff0c1b31);
const _teal = Color(0xff007d85);
const _background = Color(0xffedf3f8);
const _border = Color(0xffc5d1dc);

class ScreenCodeOtp extends StatefulWidget {
  const ScreenCodeOtp(this.number, this.name, this.nationalCode, this.userType,
      this.password, this.id,
      {super.key, this.preview = false});

  final String number;
  final String name;
  final String nationalCode;
  final int userType;
  final String password;
  final String id;
  final bool preview;

  @override
  State<ScreenCodeOtp> createState() => _ScreenCodeOtpState();
}

class _ScreenCodeOtpState extends State<ScreenCodeOtp> {
  final _formKey = GlobalKey<FormState>();
  final _code = TextEditingController();
  Timer? _timer;
  int _seconds = 60;
  bool _busy = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_seconds > 0) _seconds--;
        if (_seconds == 0) timer.cancel();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _code.dispose();
    super.dispose();
  }

  Future<void> _verify() async {
    if (_busy) return;
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    if (widget.preview) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('حالت آزمایشی: کد به سرور ارسال نشد',
            textDirection: TextDirection.rtl),
      ));
      return;
    }
    setState(() => _busy = true);
    try {
      final result = await ApiServiceAutentication.CheckConfirmCode(
          widget.id, _code.text, context);
      if (!mounted || result == null) return;
      if (!result.success) {
        ShowErrorMsg(context, result.message);
        return;
      }
      await LoginInApp(widget.name, widget.nationalCode, widget.userType, true,
          widget.password, widget.id, false);
      if (!mounted) return;
      switch (widget.userType) {
        case 1:
          GoNextPageGameOver(context, ScreenEms(false));
          break;
        case 2:
          GoNextPageGameOver(context, Screen_Teriazh());
          break;
        case 3:
          GoNextPageGameOver(context, ScreenReception());
          break;
        case 4:
          GoNextPage(context, ScreenSickCarrier());
          break;
        case 5:
          GoNextPageGameOver(context, ScreenAtend());
          break;
        case 6:
          GoNextPageGameOver(context, ScreenLaboratory());
          break;
        case 7:
          GoNextPageGameOver(context, const ResidentPatientsPreview());
          break;
        case 8:
          GoNextPageGameOver(context, ScreenStrock());
          break;
        case 9:
        case 10:
          GoNextPageGameOver(context, const SplashScreen());
          break;
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _resend() async {
    if (_busy || _seconds > 0) return;
    if (widget.preview) {
      setState(_startTimer);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('حالت آزمایشی: پیامکی ارسال نشد',
            textDirection: TextDirection.rtl),
      ));
      return;
    }
    setState(() => _busy = true);
    try {
      final result = await ApiServiceAutentication.SendAgain(
          widget.id, widget.number, context);
      if (!mounted || result == null) return;
      if (result.success) {
        setState(_startTimer);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('کد تأیید دوباره ارسال شد',
              textDirection: TextDirection.rtl),
        ));
      } else {
        ShowErrorMsg(context, result.message);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _background,
        body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      (constraints.maxHeight - 48).clamp(0.0, double.infinity),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 460),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0x160e3149),
                              blurRadius: 24,
                              offset: Offset(0, 8))
                        ],
                      ),
                      child: AutofillGroup(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _submitted
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.asset(
                                          'web/icons/Icon-512.png',
                                          width: 82,
                                          height: 82))),
                              const SizedBox(height: 8),
                              const Text('استروک',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _navy,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              Center(
                                  child: Container(
                                      width: 48,
                                      height: 4,
                                      decoration: BoxDecoration(
                                          color: const Color(0xffa2decf),
                                          borderRadius:
                                              BorderRadius.circular(4)))),
                              const SizedBox(height: 24),
                              if (widget.preview)
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 12),
                                  child: Text('پیش‌نمایش آزمایشی',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: _teal,
                                          fontWeight: FontWeight.bold)),
                                ),
                              const Text('تأیید شماره تلفن',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _navy,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 10),
                              const Text(
                                  'کد تأیید ۵ رقمی ارسال‌شده به شماره زیر را وارد کنید',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff687785), fontSize: 13)),
                              const SizedBox(height: 8),
                              Text(widget.number,
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: _navy,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 28),
                              const Text('کد تأیید',
                                  style: TextStyle(
                                      color: _navy,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _code,
                                enabled: !_busy,
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [
                                  AutofillHints.oneTimeCode
                                ],
                                maxLength: 5,
                                inputFormatters: [_DigitsFormatter()],
                                style: const TextStyle(
                                    color: _navy,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 8),
                                decoration: InputDecoration(
                                  hintText: '– – – – –',
                                  hintStyle: const TextStyle(
                                      color: Color(0xffa8b5c0),
                                      fontSize: 20,
                                      letterSpacing: 2),
                                  counterText: '',
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 16),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide:
                                          const BorderSide(color: _border)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: _teal, width: 2)),
                                ),
                                validator: (value) =>
                                    value == null || value.length != 5
                                        ? 'کد تأیید ۵ رقمی را وارد کنید'
                                        : null,
                                onFieldSubmitted: (_) => _verify(),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: _busy ? null : _verify,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: _teal,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor:
                                          const Color(0xff5facb4),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  child: _busy
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white))
                                      : const Text('تأیید و ادامه',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                  _seconds > 0
                                      ? 'امکان ارسال مجدد تا $_seconds ثانیه دیگر'
                                      : 'کد را دریافت نکردید؟',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Color(0xff687785), fontSize: 13)),
                              TextButton(
                                  onPressed:
                                      _busy || _seconds > 0 ? null : _resend,
                                  child: Text('ارسال مجدد کد',
                                      style: TextStyle(
                                          color: _busy || _seconds > 0
                                              ? const Color(0xffa8b5c0)
                                              : _teal))),
                              TextButton(
                                  onPressed: _busy
                                      ? null
                                      : () => Navigator.of(context).pop(),
                                  child: Text(
                                      widget.preview
                                          ? 'بازگشت به ورود'
                                          : 'بازگشت به ثبت‌نام',
                                      style: const TextStyle(color: _teal))),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _DigitsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final buffer = StringBuffer();
    var offset = 0;
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
        if (i < newValue.selection.baseOffset) offset++;
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: offset));
  }
}
