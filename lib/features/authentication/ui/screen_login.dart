import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../Constants.dart';
import 'ScreenCodeOtp.dart';
import 'ScreenRigester.dart';
import 'login_navigation.dart';
import '../viewmodel/login_view_model.dart';

const _navy = Color(0xff13283b);
const _teal = Color(0xff087f8c);
const _background = Color(0xffedf3f8);
const _border = Color(0xffb8c4d0);

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _nationalCodeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameFocus = FocusNode();
  final _nationalCodeFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _viewModel = LoginViewModel();
  bool _showPassword = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _nationalCodeController.dispose();
    _passwordController.dispose();
    _nameFocus.dispose();
    _nationalCodeFocus.dispose();
    _passwordFocus.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_viewModel.isLoading) return;
    setState(() => _submitted = true);
    if (!_formKey.currentState!.validate()) {
      if (_nameController.text.trim().isEmpty) {
        _nameFocus.requestFocus();
      } else if (_nationalCodeController.text.length != 10) {
        _nationalCodeFocus.requestFocus();
      } else {
        _passwordFocus.requestFocus();
      }
      return;
    }

    FocusScope.of(context).unfocus();
    final success = await _viewModel.login(
      name: _nameController.text.trim(),
      nationalCode: _nationalCodeController.text,
      password: _passwordController.text,
    );
    if (!mounted) return;

    if (success) {
      TextInput.finishAutofillContext();
      openLoginHome(context, _viewModel.user!.departmentId);
    } else if (_viewModel.errorMessage != null) {
      ShowErrorMsg(context, _viewModel.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewModel,
      builder: (context, _) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: _background,
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 48)
                        .clamp(0.0, double.infinity),
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
                                offset: Offset(0, 8)),
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
                                    child: Image.asset('web/icons/Icon-512.png',
                                        width: 82, height: 82),
                                  ),
                                ),
                                const SizedBox(height: 4),
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
                                const Text('خوش آمدید',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: _navy,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 8),
                                const Text(
                                    'برای ادامه وارد حساب کاربری خود شوید',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff687785),
                                        fontSize: 13)),
                                const SizedBox(height: 28),
                                _fieldLabel('نام کاربری'),
                                TextFormField(
                                  controller: _nameController,
                                  focusNode: _nameFocus,
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.username],
                                  autocorrect: false,
                                  enableSuggestions: false,
                                  decoration: _decoration(
                                      'نام کاربری خود را وارد کنید',
                                      Icons.person_outline),
                                  validator: (value) =>
                                      value == null || value.trim().isEmpty
                                          ? 'نام کاربری را وارد کنید'
                                          : null,
                                  onFieldSubmitted: (_) =>
                                      _nationalCodeFocus.requestFocus(),
                                ),
                                const SizedBox(height: 18),
                                _fieldLabel('کد ملی'),
                                TextFormField(
                                  controller: _nationalCodeController,
                                  focusNode: _nationalCodeFocus,
                                  textDirection: TextDirection.ltr,
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.next,
                                  maxLength: 10,
                                  inputFormatters: [
                                    _NationalCodeFormatter(),
                                    LengthLimitingTextInputFormatter(10)
                                  ],
                                  decoration: _decoration(
                                          'کد ملی خود را وارد کنید',
                                          Icons.badge_outlined)
                                      .copyWith(
                                          helperText: 'کد ملی ۱۰ رقمی',
                                          counterText: ''),
                                  validator: (value) =>
                                      value == null || value.length != 10
                                          ? 'کد ملی ۱۰ رقمی را وارد کنید'
                                          : null,
                                  onFieldSubmitted: (_) =>
                                      _passwordFocus.requestFocus(),
                                ),
                                const SizedBox(height: 14),
                                _fieldLabel('رمز عبور'),
                                TextFormField(
                                  controller: _passwordController,
                                  focusNode: _passwordFocus,
                                  textDirection: TextDirection.ltr,
                                  textInputAction: TextInputAction.done,
                                  autofillHints: const [AutofillHints.password],
                                  obscureText: !_showPassword,
                                  autocorrect: false,
                                  enableSuggestions: false,
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
                                  onFieldSubmitted: (_) => _login(),
                                ),
                                const SizedBox(height: 26),
                                SizedBox(
                                  height: 54,
                                  child: ElevatedButton(
                                    onPressed:
                                        _viewModel.isLoading ? null : _login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _teal,
                                      foregroundColor: Colors.white,
                                      disabledBackgroundColor:
                                          const Color(0xff5facb4),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 0,
                                    ),
                                    child: _viewModel.isLoading
                                        ? const SizedBox(
                                            width: 22,
                                            height: 22,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white))
                                        : const Text('ورود به سامانه',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                TextButton(
                                  onPressed: _viewModel.isLoading
                                      ? null
                                      : () => GoNextPage(
                                          context, const ScreenRigester()),
                                  child: const Text(
                                      'حساب کاربری ندارید؟ ثبت‌نام',
                                      style: TextStyle(color: _teal)),
                                ),
                                if (kDebugMode)
                                  TextButton(
                                    onPressed: _viewModel.isLoading
                                        ? null
                                        : () => GoNextPage(
                                            context,
                                            const ScreenCodeOtp('09123456789',
                                                '', '', 1, '', '',
                                                preview: true)),
                                    child: const Text(
                                        'پیش‌نمایش صفحه کد تأیید (آزمایشی)',
                                        style: TextStyle(color: _teal)),
                                  ),
                                const SizedBox(height: 8),
                                const Text(
                                    'برای دریافت دسترسی با مدیر سامانه تماس بگیرید',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xff687785),
                                        fontSize: 11)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fieldLabel(String label) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(label,
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

class _NationalCodeFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final buffer = StringBuffer();
    var selectionOffset = 0;
    for (var index = 0; index < newValue.text.length; index++) {
      final code = newValue.text.codeUnitAt(index);
      final digit = code >= 0x06f0 && code <= 0x06f9
          ? code - 0x06f0
          : code >= 0x0660 && code <= 0x0669
              ? code - 0x0660
              : code >= 0x30 && code <= 0x39
                  ? code - 0x30
                  : null;
      if (digit != null) {
        buffer.write(digit);
        if (index < newValue.selection.baseOffset) selectionOffset++;
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: selectionOffset));
  }
}
