import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../../core/api_exception.dart';
import '../../core/utils/persian_date_range_picker.dart';
import '../../Widgets/notification_registration_button.dart';
import '../../features/authentication/data/AuthenticationRepository.dart';
import '../../features/authentication/ui/screen_EditProfile.dart';
import '../../features/patient_registration/ui/screen_ems.dart';
import '../../features/patients/data/patient_repository.dart';
import '../../features/patients/viewmodel/attend_patients_view_model.dart';
import '../../report/FirstReportScreen.dart';
import 'package:appstrock/Screens/Atend/ScreenDetailPatientAtend.dart';
import 'package:appstrock/features/patients/ui/stroke_nurse/stroke_nurse_record.dart';
import '../../features/patient_registration/ui/patient_registration_screen.dart';
import '../../features/patient_registration/model/patient_registration.dart';
import '../SplashScreen.dart';
import '../Teriazh/notification_registration.dart';

const _navy = Color(0xff102038);
const _teal = Color(0xff007d83);
const _line = Color(0xffd3dde6);

class ScreenAtend extends StatefulWidget {
  const ScreenAtend({super.key, this.strokeNurse = false});
  final bool strokeNurse;
  @override
  State<ScreenAtend> createState() => _ScreenAtendState();
}

class _ScreenAtendState extends State<ScreenAtend>
    with WidgetsBindingObserver {
  late final AttendPatientsViewModel _viewModel;
  Timer? _refreshTimer;
  bool _detailOpen = false;
  bool _notificationsActive = false;
  bool _checkingNotifications = true;
  int _notificationCheck = 0;
  bool _shiftActive = false;
  bool _loadingShift = true;
  bool _changingShift = false;
  String _query = '';
  int _filter = 0;

  @override
  void initState() {
    super.initState();
    _viewModel = AttendPatientsViewModel(strokeNurse: widget.strokeNurse);
    WidgetsBinding.instance.addObserver(this);
    _loadShift();
    _checkNotifications();
    _viewModel.refresh();
    _startTimers();
  }

  void _startTimers() {
    _refreshTimer?.cancel();
    _refreshTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      if (!_detailOpen) _viewModel.refresh();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startTimers();
      _checkNotifications();
      if (!_detailOpen) _viewModel.refresh();
    } else {
      _refreshTimer?.cancel();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _refreshTimer?.cancel();
    _viewModel.dispose();
    super.dispose();
  }

  Future<void> _loadShift() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (mounted) setState(() => _shiftActive = prefs.getBool('isOnline') ?? false);
    } catch (_) {
      if (mounted) _message('خواندن وضعیت شیفت ناموفق بود');
    } finally {
      if (mounted) setState(() => _loadingShift = false);
    }
  }

  Future<void> _checkNotifications() async {
    final check = ++_notificationCheck;
    if (mounted) setState(() => _checkingNotifications = true);
    bool active = false;
    try { active = await notificationRegistrationIsActive(); } catch (_) { active = false; }
    if (mounted && check == _notificationCheck) setState(() { _notificationsActive = active; _checkingNotifications = false; });
  }

  Future<void> _changeShift() async {
    if (_loadingShift || _changingShift) return;
    setState(() => _changingShift = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('UserId');
      if (userId == null || userId.isEmpty) throw StateError('اطلاعات کاربر در دسترس نیست');
      final response = await AuthenticationRepository().changeShiftStatus(userId: userId);
      if (!response.success || response.data == null) {
        throw StateError(response.message.isEmpty ? 'تغییر وضعیت شیفت ناموفق بود' : response.message);
      }
      final active = response.data!.isOnline;
      if (mounted) setState(() => _shiftActive = active);
      try {
        await prefs.setBool('isOnline', active);
      } catch (_) {
        if (mounted) _message('شیفت تغییر کرد اما ذخیره وضعیت روی دستگاه ناموفق بود');
      }
    } on ApiException catch (error) {
      if (mounted && !error.isCancelled) _message(error.toString());
    } catch (e) {
      if (mounted) _message(e is StateError ? e.message.toString() : 'تغییر وضعیت شیفت ناموفق بود');
    } finally {
      if (mounted) setState(() => _changingShift = false);
    }
  }

  void _message(String text) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text, textDirection: TextDirection.rtl)));

  Future<void> _chooseDates() async {
    final range = await showPersianDateRangePicker(context,
        initialFrom: _viewModel.from, initialTo: _viewModel.to);
    if (range == null || !mounted) return;
    await _viewModel.setRange(range.from, range.to);
  }

  Future<void> _openPatient(PatientListEntry entry) async {
    _detailOpen = true;
    try {
      await Navigator.of(context).push(MaterialPageRoute<void>(builder: (ctx) =>
          widget.strokeNurse ? StrokeNurseRecord(patient: entry.patient,
              from: AttendPatientsViewModel.formatDate(_viewModel.from),
              to: AttendPatientsViewModel.formatDate(_viewModel.to)) : ScreenDetailPatientAtend(entry.patient, context,
              AttendPatientsViewModel.formatDate(_viewModel.from),
              AttendPatientsViewModel.formatDate(_viewModel.to))));
    } finally {
      _detailOpen = false;
      if (mounted) _viewModel.refresh();
    }
  }

  Future<void> _accountAction(String value) async {
    if (value == 'report' || value == 'add') {
      _detailOpen = true;
      try {
        await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) =>
            value == 'report' ? const FirstReportScreen() : widget.strokeNurse
                ? PatientRegistrationScreen(source: PatientRegistrationSource.ems,
                    shiftActive: _shiftActive, onChangeShift: (active) => setState(() => _shiftActive = active),
                    onExit: () => Navigator.of(_).pop(),
                    onEditProfile: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const screen_EditProfile())),
                    notificationButton: const NotificationRegistrationButton(color: _navy, size: 23, icon: Icons.notifications_none_outlined))
                : ScreenEms(true)));
      } finally {
        _detailOpen = false;
        if (mounted) _viewModel.refresh();
      }
      return;
    }
    if (value == 'profile') {
      await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const screen_EditProfile()));
      return;
    }
    final confirmed = await ShowAllow(context, 'آیا از حساب خود خارج می‌شوید؟');
    if (!confirmed || !mounted) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (mounted) GoNextPageGameOver(context, const SplashScreen());
  }

  String _normalize(String value) {
    const persian = '۰۱۲۳۴۵۶۷۸۹';
    const arabic = '٠١٢٣٤٥٦٧٨٩';
    for (var i = 0; i < 10; i++) {
      value = value.replaceAll(persian[i], '$i').replaceAll(arabic[i], '$i');
    }
    return value.replaceAll('ي', 'ی').replaceAll('ك', 'ک').trim();
  }

  String _digits(String input) {
    const digits = '۰۱۲۳۴۵۶۷۸۹';
    return input.replaceAllMapped(RegExp('[0-9]'), (m) => digits[int.parse(m[0]!)]);
  }

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Scaffold(
      backgroundColor: const Color(0xffeaf0f7),
      body: SafeArea(child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Container(
          margin: const EdgeInsets.all(8), clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xfffbfcfe), borderRadius: BorderRadius.circular(28)),
          child: Column(children: [
            _header(),
            Expanded(child: AnimatedBuilder(animation: _viewModel, builder: (context, _) {
              final all = _viewModel.patients;
              final query = _normalize(_query);
              final filtered = all.where((entry) {
                final p = entry.patient;
                final match = _normalize(p.fullName).contains(query) || _normalize(p.nationalCode).contains(query);
                final status = entry.status;
                return match && (_filter == 0 ||
                    (_filter == 1 && (widget.strokeNurse ? status != PatientStatus.finished : status == PatientStatus.active724)) ||
                    (_filter == 2 && status == PatientStatus.finished));
              }).toList();
              int count(PatientStatus status) => all.where((p) => p.status == status).length;
              return RefreshIndicator(onRefresh: _viewModel.refresh, child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(), slivers: [
                  SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.fromLTRB(14, 14, 14, 0), child: Column(children: [
                    _notificationBanner(),
                    const SizedBox(height: 20),
                    Row(children: [
                      Expanded(child: Text(_viewModel.isToday ? 'بیماران امروز' : 'فهرست بیماران', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: _navy))),
                      InkWell(onTap: _chooseDates, child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.calendar_today_outlined, size: 16, color: _teal), const SizedBox(width: 5),
                        Text(_digits(AttendPatientsViewModel.formatDate(_viewModel.from)) +
                            (_viewModel.from == _viewModel.to ? '' : ' تا ${_digits(AttendPatientsViewModel.formatDate(_viewModel.to))}'),
                            style: const TextStyle(fontSize: 11, color: Color(0xff667589))),
                      ])),
                    ]),
                    if (!_viewModel.isToday) Align(alignment: Alignment.centerLeft,
                      child: TextButton.icon(onPressed: _viewModel.showToday,
                        icon: const Icon(Icons.today, size: 16), label: const Text('بازگشت به امروز'))),
                    const SizedBox(height: 14),
                    Row(children: [
                      _summary(widget.strokeNurse ? all.where((entry) => !entry.isCompleted).length : count(PatientStatus.active724), widget.strokeNurse ? 'در حال اقدام' : 'کد ۷۲۴', Icons.bolt, const Color(0xffe5f5f2), const Color(0xff00a783)), const SizedBox(width: 8),
                      _summary(count(PatientStatus.finished), 'تکمیل شده', Icons.check_circle, const Color(0xffe2f4e8), const Color(0xff39ad70)),
                    ]),
                    const SizedBox(height: 18),
                    TextField(onChanged: (value) => setState(() => _query = value),
                      style: const TextStyle(fontSize: 14, color: _navy),
                      decoration: InputDecoration(hintText: 'جستجوی نام یا کد ملی',
                        prefixIcon: const Icon(Icons.search, color: Color(0xff657489)), isDense: true, filled: true,
                        fillColor: const Color(0xfff8fafc),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: _line)),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: _line)))),
                    const SizedBox(height: 14),
                    Row(children: [_filterChip('همه', 0), const SizedBox(width: 7), _filterChip(widget.strokeNurse ? 'در حال اقدام' : 'کد ۷۲۴', 1), const SizedBox(width: 7), _filterChip('تکمیل شده', 2)]),
                    const SizedBox(height: 16),
                    if (_viewModel.loading && all.isNotEmpty) const LinearProgressIndicator(minHeight: 2, color: _teal),
                    if (_viewModel.error != null) Padding(padding: const EdgeInsets.only(bottom: 10), child: Row(children: [
                      Expanded(child: Text(_viewModel.error!, style: const TextStyle(color: Colors.red, fontSize: 12))),
                      TextButton(onPressed: _viewModel.refresh, child: const Text('تلاش مجدد')),
                    ])),
                  ]))),
                  if (_viewModel.loading && all.isEmpty)
                    const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(30), child: Center(child: CircularProgressIndicator(color: _teal))))
                  else if (filtered.isEmpty && _viewModel.error == null)
                    SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(30), child: Center(child: Text(
                      _query.isNotEmpty || _filter != 0 ? 'بیماری با این جستجو یا فیلتر پیدا نشد' : 'بیماری برای نمایش در این بازه وجود ندارد',
                      textAlign: TextAlign.center, style: const TextStyle(color: Color(0xff667589))))))
                  else SliverPadding(padding: const EdgeInsets.fromLTRB(14, 0, 14, 20), sliver: SliverList(delegate: SliverChildBuilderDelegate(
                    (context, index) => _patientCard(filtered[index]), childCount: filtered.length))),
                ],
              ));
            })),
          ]),
        ),
      ))),
    ),
  );

  Widget _header() => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: _line))),
    child: Row(children: [
      Image.asset('web/icons/Icon-512.png', width: 28, height: 28), const SizedBox(width: 3),
      const Text('استروک', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: _navy)), const Spacer(),
      InkWell(onTap: _loadingShift || _changingShift ? null : _changeShift,
        child: _pill(_loadingShift ? 'وضعیت شیفت' : _shiftActive ? 'شیفت فعال' : 'شیفت غیرفعال',
          _loadingShift || _changingShift
              ? const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 2, color: _teal))
              : Icon(Icons.circle, size: 10, color: _shiftActive ? const Color(0xff4cb65a) : Colors.grey),
          const Color(0xffe8f5ef))),
      const SizedBox(width: 5),
      PopupMenuButton<String>(tooltip: 'حساب کاربری', onSelected: _accountAction,
        itemBuilder: (_) => [const PopupMenuItem(value: 'add', child: Text('ثبت بیمار')), if (!widget.strokeNurse) const PopupMenuItem(value: 'report', child: Text('گزارش‌ها')), const PopupMenuItem(value: 'profile', child: Text('ویرایش حساب کاربری')), const PopupMenuItem(value: 'exit', child: Text('خروج از حساب'))],
        child: _pill(widget.strokeNurse ? 'پرستار استروک' : 'متخصص', const Icon(Icons.person_outline, size: 18, color: _navy), const Color(0xffedf2f6))),
      NotificationRegistrationButton(color: _navy, size: 23, icon: Icons.notifications_none_outlined, onRegistered: _checkNotifications),
    ]));

  Widget _pill(String label, Widget icon, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(24)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [icon, const SizedBox(width: 4), Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _navy))]));

  Widget _notificationBanner() {
    final active = _notificationsActive;
    return Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(color: _checkingNotifications ? const Color(0xffedf2f6) : active ? const Color(0xffdff4ec) : const Color(0xffffe6e6), borderRadius: BorderRadius.circular(10)),
      child: Row(children: [Icon(active ? Icons.sensors : Icons.notifications_off_outlined, color: active ? const Color(0xff21a449) : const Color(0xffbd4040), size: 22), const SizedBox(width: 8),
        Expanded(child: Text(_checkingNotifications ? 'در حال بررسی وضعیت اعلان‌ها' : active ? 'اعلان‌ها فعال است' : 'اعلان‌ها فعال نیست؛ برای دریافت اعلان آن را روشن کنید',
          style: TextStyle(color: active ? const Color(0xff195e37) : const Color(0xff9d3232), fontWeight: FontWeight.bold, fontSize: 11)))]));
  }

  Widget _summary(int count, String title, IconData icon, Color bg, Color accent) => Expanded(child: Container(
    height: 82, padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: accent, size: 22), const SizedBox(width: 8), Text(_digits('$count'), style: TextStyle(color: accent, fontSize: 24, fontWeight: FontWeight.bold))]),
      FittedBox(child: Text(title, style: const TextStyle(color: _navy, fontSize: 12, fontWeight: FontWeight.bold)))])));

  Widget _filterChip(String title, int index) => Expanded(child: InkWell(onTap: () => setState(() => _filter = index),
    borderRadius: BorderRadius.circular(30), child: Container(padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: _filter == index ? _teal : const Color(0xfff5f8fb), borderRadius: BorderRadius.circular(30), border: Border.all(color: _filter == index ? _teal : _line)),
      child: Center(child: Text(title, style: TextStyle(color: _filter == index ? Colors.white : const Color(0xff536176), fontWeight: FontWeight.bold, fontSize: 11))))));

  Widget _patientCard(PatientListEntry entry) {
    final patient = entry.patient;
    final active = entry.status != PatientStatus.finished;
    final source = entry.source == '1' ? 'تریاژ' : entry.source == '2' ? 'پرستار استروک' : entry.source == '3' ? 'متخصص' : entry.source == '4' ? 'رزیدنت' : null;
    return InkWell(key: ValueKey(patient.id), onTap: () => _openPatient(entry), child: Container(
      margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: _line)),
      child: Column(children: [Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(patient.withoutInfo ? 'بیمار مجهول‌الهویه' : patient.fullName.isEmpty ? 'نام ثبت نشده' : patient.fullName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _navy)),
          Text('${patient.gender.isEmpty ? 'نامشخص' : patient.gender} • ${patient.age.isEmpty ? 'سن نامشخص' : '${_digits(patient.age)} سال'}', style: const TextStyle(fontSize: 12, color: Color(0xff58667a))),
          if (source != null) Text(source, style: const TextStyle(fontSize: 11, color: Color(0xff667589))),
        ])),
        _badge(active ? (widget.strokeNurse ? 'در حال اقدام' : 'کد ۷۲۴') : 'تکمیل شده', active ? Icons.bolt : Icons.check,
            active ? const Color(0xffdef8eb) : const Color(0xffe2f4e8), const Color(0xff087f58)),
      ]),
      const SizedBox(height: 10),
      const Row(children: [Spacer(), Text('مشاهده پرونده', style: TextStyle(color: _teal, fontWeight: FontWeight.bold, fontSize: 12)),
        SizedBox(width: 5), Icon(Icons.arrow_back, size: 17, color: _teal)]),
      ])));
  }

  Widget _badge(String title, IconData icon, Color background, Color color) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
    decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(9)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 17), const SizedBox(width: 4), Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11))]));
}
