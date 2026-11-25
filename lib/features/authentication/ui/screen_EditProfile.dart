import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/api_exception.dart';
import '../data/AuthenticationRepository.dart';
import 'screen_login.dart';

const _navy = Color(0xff0c1b31);
const _teal = Color(0xff007d85);
const _background = Color(0xffedf3f8);
const _border = Color(0xffc5d1dc);

// Kept for existing navigation from all user departments.
// ignore: camel_case_types
class screen_EditProfile extends StatefulWidget {
  const screen_EditProfile({super.key});

  @override
  State<screen_EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<screen_EditProfile> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _nationalCode = TextEditingController();
  final _password = TextEditingController();
  int? _userId;
  int? _role;
  bool _initializing = true;
  bool _loading = false;
  bool _submitted = false;
  bool _showPassword = false;
  String? _initializationError;

  static const _roles = <int, String>{
    1: 'پرستار استروک',
    2: 'تریاژ',
    3: 'پذیرش',
    4: 'بیماربر',
    5: 'دکتر متخصص',
    6: 'آزمایشگاه',
    7: 'رزیدنت',
    8: 'استروک',
    9: 'تصویر برداری',
    10: 'سوپروایزور',
  };

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;
      _name.text = prefs.getString('Name') ?? '';
      _nationalCode.text = prefs.getString('Code') ?? '';
      _password.text = prefs.getString('Pass') ?? '';
      setState(() {
        _userId = int.tryParse(prefs.getString('UserId') ?? '');
        _role = prefs.getInt('TypeUser');
        _initializing = false;
        if (_userId == null) {
          _initializationError = 'اطلاعات حساب در دسترس نیست؛ دوباره وارد شوید';
        }
      });
    } catch (_) {
      if (mounted) {
        setState(() {
          _initializing = false;
          _initializationError = 'خواندن اطلاعات حساب ناموفق بود';
        });
      }
    }
  }

  @override
  void dispose() {
    _name.dispose();
    _nationalCode.dispose();
    _password.dispose();
    super.dispose();
  }

  void _message(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text(message, textDirection: TextDirection.rtl)));
  }

  Future<void> _save() async {
    if (_loading || _initializing || _initializationError != null) return;
    setState(() => _submitted = true);
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    try {
      final result = await AuthenticationRepository().changeUserInfo(
        id: _userId!,
        name: _name.text.trim(),
        nationalCode: _nationalCode.text,
        departmentId: _role,
        password: _password.text,
      );
      if (!mounted) return;
      if (result['success'] != true) {
        _message(result['message'] is String
            ? result['message'] as String
            : 'ویرایش اطلاعات ناموفق بود');
        return;
      }
      final prefs = await SharedPreferences.getInstance();
      // Invalidate the old login before removing its credentials.
      await prefs.remove('Login');
      for (final key in [
        'Name',
        'Code',
        'Pass',
        'UserId',
        'TypeUser',
        'isOnline'
      ]) {
        await prefs.remove(key);
      }
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute<void>(builder: (_) => const ScreenLogin()),
        (_) => false,
      );
      _message('اطلاعات ویرایش شد؛ دوباره وارد حساب خود شوید');
    } on ApiException catch (error) {
      if (mounted && !error.isCancelled) _message(error.toString());
    } catch (_) {
      if (mounted) _message('ویرایش اطلاعات انجام نشد؛ دوباره تلاش کنید');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ProfileLayout(
      title: 'ویرایش اطلاعات کاربری',
      subtitle: 'اطلاعات حساب خود را بررسی و ویرایش کنید',
      child: _initializing
          ? const Center(child: CircularProgressIndicator(color: _teal))
          : Form(
              key: _form,
              autovalidateMode: _submitted
                  ? AutovalidateMode.onUserInteraction
                  : AutovalidateMode.disabled,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_initializationError != null) ...[
                      Text(_initializationError!,
                          style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                    ],
                    _label('نام کاربری'),
                    TextFormField(
                      controller: _name,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9.,?!@# ]'))
                      ],
                      decoration:
                          _decoration('نام کاربری', Icons.person_outline),
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
                      decoration: _decoration('کد ملی', Icons.badge_outlined)
                          .copyWith(counterText: ''),
                      validator: (value) => value != null &&
                              value.isNotEmpty &&
                              value.length != 10
                          ? 'کد ملی ۱۰ رقمی را وارد کنید'
                          : null,
                    ),
                    const SizedBox(height: 18),
                    _label('نوع کاربر'),
                    DropdownButtonFormField<int>(
                      value: _roles.containsKey(_role) ? _role : null,
                      isExpanded: true,
                      decoration: _decoration('نوع کاربر', Icons.work_outline),
                      items: _roles.entries
                          .where((entry) =>
                              const {1, 2, 5, 7}.contains(entry.key) ||
                              entry.key == _role)
                          .map((entry) => DropdownMenuItem(
                              value: entry.key, child: Text(entry.value)))
                          .toList(),
                      onChanged: _loading
                          ? null
                          : (value) => setState(() => _role = value),
                    ),
                    const SizedBox(height: 18),
                    _label('رمز عبور'),
                    TextFormField(
                      controller: _password,
                      textDirection: TextDirection.ltr,
                      obscureText: !_showPassword,
                      autocorrect: false,
                      enableSuggestions: false,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9.,?!@# ]'))
                      ],
                      decoration:
                          _decoration('رمز عبور', Icons.lock_outline).copyWith(
                        suffixIcon: IconButton(
                          tooltip: _showPassword
                              ? 'پنهان کردن رمز عبور'
                              : 'نمایش رمز عبور',
                          onPressed: () =>
                              setState(() => _showPassword = !_showPassword),
                          icon: Icon(_showPassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                        ),
                      ),
                      onFieldSubmitted: (_) => _save(),
                    ),
                    const SizedBox(height: 26),
                    _primaryButton('ذخیره تغییرات', _loading ? null : _save,
                        loading: _loading),
                    const SizedBox(height: 12),
                    TextButton.icon(
                      onPressed: _loading
                          ? null
                          : () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                  builder: (_) => const EditPhoneScreen())),
                      icon: const Icon(Icons.phone_outlined),
                      label: const Text('ویرایش شماره تلفن'),
                      style: TextButton.styleFrom(foregroundColor: _teal),
                    ),
                  ]),
            ),
    );
  }
}

class EditPhoneScreen extends StatefulWidget {
  const EditPhoneScreen({super.key});

  @override
  State<EditPhoneScreen> createState() => _EditPhoneScreenState();
}

class _EditPhoneScreenState extends State<EditPhoneScreen> {
  final _form = GlobalKey<FormState>();
  final _phone = TextEditingController();
  bool _loading = false;
  bool _submitted = false;

  Future<void> _save() async {
    if (_loading) return;
    setState(() => _submitted = true);
    if (!_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = int.tryParse(prefs.getString('UserId') ?? '');
      if (!mounted) return;
      if (id == null) {
        _message('اطلاعات حساب در دسترس نیست؛ دوباره وارد شوید');
        return;
      }
      final result = await AuthenticationRepository().changeMobileNumber(
        id: id,
        mobileNumber: _phone.text,
      );
      if (!mounted) return;
      if (result['success'] != true) {
        _message(result['message'] is String
            ? result['message'] as String
            : 'تغییر شماره تلفن ناموفق بود');
        return;
      }
      _message(result['message'] is String &&
              (result['message'] as String).isNotEmpty
          ? result['message'] as String
          : 'شماره تلفن با موفقیت تغییر کرد');
      Navigator.of(context).pop();
    } on ApiException catch (error) {
      if (mounted && !error.isCancelled) _message(error.toString());
    } on FormatException {
      if (mounted) _message('ساختار پاسخ دریافتی از سرور نامعتبر است');
    } catch (_) {
      if (mounted) _message('تغییر شماره تلفن انجام نشد؛ دوباره تلاش کنید');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _message(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
          SnackBar(content: Text(message, textDirection: TextDirection.rtl)));
  }

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _ProfileLayout(
        title: 'ویرایش شماره تلفن',
        subtitle: 'شماره تلفن همراه جدید خود را وارد کنید',
        child: Form(
          key: _form,
          autovalidateMode: _submitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            _label('شماره تلفن همراه جدید'),
            TextFormField(
              controller: _phone,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              enabled: !_loading,
              inputFormatters: [_DigitsFormatter()],
              decoration:
                  _decoration('شماره تلفن همراه جدید', Icons.phone_outlined)
                      .copyWith(counterText: ''),
              validator: (value) =>
                  value == null || value.length != 11 || !value.startsWith('09')
                      ? 'شماره تلفن همراه معتبر وارد کنید'
                      : null,
              onFieldSubmitted: (_) => _save(),
            ),
            const SizedBox(height: 24),
            _primaryButton('ذخیره شماره تلفن', _loading ? null : _save,
                loading: _loading),
          ]),
        ),
      );
}

class _ProfileLayout extends StatelessWidget {
  const _ProfileLayout(
      {required this.title, required this.subtitle, required this.child});
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: _background,
          body: SafeArea(
              child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 24),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: (constraints.maxHeight - 48)
                                  .clamp(0.0, double.infinity)),
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
                                  ]),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            icon: const Icon(Icons.arrow_back,
                                                color: _navy),
                                            tooltip: 'بازگشت')),
                                    Center(
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(18),
                                            child: Image.asset(
                                                'web/icons/Icon-512.png',
                                                width: 72,
                                                height: 72))),
                                    const SizedBox(height: 12),
                                    Text(title,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: _navy,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 8),
                                    Text(subtitle,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color: Color(0xff687785),
                                            fontSize: 13)),
                                    const SizedBox(height: 28),
                                    child,
                                  ]),
                            ),
                          )),
                        ),
                      ))),
        ),
      );
}

Widget _label(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(text,
        style: const TextStyle(
            color: _navy, fontSize: 14, fontWeight: FontWeight.bold)));

InputDecoration _decoration(String hint, IconData icon) => InputDecoration(
      hintText: hint,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(color: Color(0xff84919e), fontSize: 13),
      prefixIcon: Icon(icon, color: _navy),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _border)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: _teal, width: 2)),
    );

Widget _primaryButton(String text, VoidCallback? onPressed,
        {bool loading = false}) =>
    SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: _teal,
            foregroundColor: Colors.white,
            disabledBackgroundColor: const Color(0xffa8b5c0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : Text(text,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    );

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
