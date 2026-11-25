import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Constants.dart';
import '../../../Screens/Autentication/ApiServiceAutentication.dart';
import 'ScreenCodeOtp.dart';

const _navy = Color(0xff0c1b31);
const _teal = Color(0xff007d85);
const _background = Color(0xffedf3f8);
const _border = Color(0xffc5d1dc);

class ScreenRigester extends StatefulWidget {
  const ScreenRigester({super.key});

  @override
  State<ScreenRigester> createState() => _ScreenRigesterState();
}

class _ScreenRigesterState extends State<ScreenRigester> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _nationalCode = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  static const _roles = <String, int>{
    'پرستار استروک': 1,
    'تریاژ': 2,
    'دکتر متخصص': 5,
    'رزیدنت': 7,
  };
  String _role = 'پرستار استروک';
  bool _submitted = false;
  bool _loading = false;
  bool _showPassword = false;

  @override
  void dispose() {
    _name.dispose();
    _nationalCode.dispose();
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_loading) return;
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    final name = _name.text.trim();
    final nationalCode = _nationalCode.text;
    final phone = _phone.text;
    final password = _password.text;
    final role = _roles[_role]!;
    try {
      final result = await ApiServiceAutentication.Rigester(
        name,
        role.toString(),
        nationalCode,
        phone,
        password,
        context,
      );
      if (!mounted || result == null) return;
      if (!result.success) {
        ShowErrorMsg(context, result.message);
      } else if (result.data == null) {
        ShowErrorMsg(context, 'اطلاعات ثبت‌نام از سرور دریافت نشد');
      } else {
        GoNextPage(
            context,
            ScreenCodeOtp(
              phone,
              name,
              nationalCode,
              role,
              password,
              result.data!.id.toString(),
            ));
      }
    } finally {
      if (mounted) setState(() => _loading = false);
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
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
                              const SizedBox(height: 20),
                              const Text('ایجاد حساب کاربری',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: _navy,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              const Text(
                                  'برای ثبت‌نام اطلاعات خود را وارد کنید',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xff687785), fontSize: 13)),
                              const SizedBox(height: 28),
                              _label('نام کاربری'),
                              TextFormField(
                                controller: _name,
                                textDirection: TextDirection.ltr,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [AutofillHints.username],
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9.,?!@# ]'))
                                ],
                                decoration: _decoration(
                                    'نام کاربری خود را وارد کنید',
                                    Icons.person_outline),
                                validator: (value) =>
                                    value == null || value.trim().isEmpty
                                        ? 'نام کاربری را وارد کنید'
                                        : null,
                              ),
                              const SizedBox(height: 18),
                              _label('کد ملی'),
                              TextFormField(
                                controller: _nationalCode,
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                maxLength: 10,
                                inputFormatters: [_DigitsFormatter()],
                                decoration: _decoration(
                                        'کد ملی خود را وارد کنید',
                                        Icons.badge_outlined)
                                    .copyWith(counterText: ''),
                                validator: (value) =>
                                    value == null || value.length != 10
                                        ? 'کد ملی ۱۰ رقمی را وارد کنید'
                                        : null,
                              ),
                              const SizedBox(height: 18),
                              _label('نوع کاربر'),
                              DropdownButtonFormField<String>(
                                value: _role,
                                isExpanded: true,
                                decoration: _decoration(
                                    'نوع کاربر را انتخاب کنید',
                                    Icons.work_outline),
                                items: _roles.keys
                                    .map((role) => DropdownMenuItem(
                                        value: role, child: Text(role)))
                                    .toList(),
                                onChanged: _loading
                                    ? null
                                    : (value) {
                                        if (value != null) {
                                          setState(() => _role = value);
                                        }
                                      },
                              ),
                              const SizedBox(height: 18),
                              _label('شماره تلفن'),
                              TextFormField(
                                controller: _phone,
                                textDirection: TextDirection.ltr,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                autofillHints: const [
                                  AutofillHints.telephoneNumber
                                ],
                                maxLength: 11,
                                inputFormatters: [_DigitsFormatter()],
                                decoration: _decoration(
                                        'شماره تلفن همراه خود را وارد کنید',
                                        Icons.phone_outlined)
                                    .copyWith(counterText: ''),
                                validator: (value) => value == null ||
                                        value.length != 11 ||
                                        !value.startsWith('09')
                                    ? 'شماره تلفن همراه معتبر وارد کنید'
                                    : null,
                              ),
                              const SizedBox(height: 18),
                              _label('رمز عبور'),
                              TextFormField(
                                controller: _password,
                                textDirection: TextDirection.ltr,
                                textInputAction: TextInputAction.done,
                                obscureText: !_showPassword,
                                autocorrect: false,
                                enableSuggestions: false,
                                autofillHints: const [
                                  AutofillHints.newPassword
                                ],
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z0-9.,?!@# ]'))
                                ],
                                decoration: _decoration(
                                        'رمز عبور خود را وارد کنید',
                                        Icons.lock_outline)
                                    .copyWith(
                                  suffixIcon: IconButton(
                                    tooltip: _showPassword
                                        ? 'پنهان کردن رمز عبور'
                                        : 'نمایش رمز عبور',
                                    onPressed: () => setState(
                                        () => _showPassword = !_showPassword),
                                    icon: Icon(_showPassword
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined),
                                  ),
                                ),
                                validator: (value) =>
                                    value == null || value.isEmpty
                                        ? 'رمز عبور را وارد کنید'
                                        : null,
                                onFieldSubmitted: (_) => _register(),
                              ),
                              const SizedBox(height: 26),
                              SizedBox(
                                height: 54,
                                child: ElevatedButton(
                                  onPressed: _loading ? null : _register,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: _teal,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor:
                                          const Color(0xff5facb4),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12))),
                                  child: _loading
                                      ? const SizedBox(
                                          width: 22,
                                          height: 22,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              color: Colors.white))
                                      : const Text('ثبت‌نام',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextButton(
                                  onPressed: _loading
                                      ? null
                                      : () => Navigator.of(context).pop(),
                                  child: const Text('حساب کاربری دارید؟ ورود',
                                      style: TextStyle(color: _teal))),
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

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(
                color: _navy, fontSize: 14, fontWeight: FontWeight.bold)),
      );

  InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
        hintText: hint,
        hintTextDirection: TextDirection.rtl,
        hintStyle: const TextStyle(color: Color(0xff84919e), fontSize: 13),
        prefixIcon: Icon(icon, color: _navy),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: _teal, width: 2)),
      );
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
