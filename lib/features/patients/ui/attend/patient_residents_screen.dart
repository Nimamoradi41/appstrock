import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';
import '../../../../report/model/ModelLogItemReport.dart';
import '../../data/resident_patient_repository.dart';

const _ink = Color(0xff0b1a35);
const _teal = Color(0xff007d7c);

class PatientResidentsScreen extends StatefulWidget {
  const PatientResidentsScreen(
      {super.key, required this.patient, this.repository});

  final ModelPatient patient;
  final ResidentPatientRepository? repository;

  @override
  State<PatientResidentsScreen> createState() => _PatientResidentsScreenState();
}

class _PatientResidentsScreenState extends State<PatientResidentsScreen> {
  late final ResidentPatientRepository _repository;
  late Future<List<ModelLogItemReport>> _activities;

  @override
  void initState() {
    super.initState();
    _repository = widget.repository ?? ResidentPatientRepository();
    _activities = _load();
  }

  Future<List<ModelLogItemReport>> _load() =>
      _repository.getPatientActivity(widget.patient.id.toString());

  Future<void> _refresh() async {
    final next = _load();
    setState(() => _activities = next);
    try {
      await next;
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.patient.withoutInfo
        ? 'بیمار مجهول‌الهویه'
        : widget.patient.fullName.trim().isEmpty
            ? 'نام ثبت نشده'
            : widget.patient.fullName;
    return Directionality(
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
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0x220f2943),
                          blurRadius: 14,
                          offset: Offset(0, 5))
                    ]),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                    child: Row(children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          tooltip: 'بازگشت',
                          icon: const Icon(Icons.arrow_forward, color: _ink)),
                      const Expanded(
                          child: Text('رزیدنت‌های بیمار',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _ink))),
                      const SizedBox(width: 48),
                    ]),
                  ),
                  const Divider(height: 1),
                  Expanded(
                    child: FutureBuilder<List<ModelLogItemReport>>(
                      future: _activities,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const Center(
                              child: CircularProgressIndicator(color: _teal));
                        }
                        if (snapshot.hasError) {
                          return _message(
                              Icons.cloud_off_outlined,
                              'دریافت فعالیت‌ها ناموفق بود',
                              'اتصال خود را بررسی کنید و دوباره تلاش کنید.',
                              retry: true);
                        }
                        final activities = snapshot.data ?? [];
                        final groups = <String, List<ModelLogItemReport>>{};
                        for (final item in activities) {
                          final resident = item.name.trim().isEmpty
                              ? 'نام ثبت نشده'
                              : item.name.trim();
                          groups.putIfAbsent(resident, () => []).add(item);
                        }
                        return RefreshIndicator(
                          onRefresh: _refresh,
                          color: _teal,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                    color: const Color(0xffe3f6f0),
                                    borderRadius: BorderRadius.circular(14)),
                                child: Row(children: [
                                  const Icon(Icons.person_outline,
                                      color: _teal),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                        const Text('پرونده بیمار',
                                            style: TextStyle(
                                                color: _teal, fontSize: 12)),
                                        const SizedBox(height: 4),
                                        Text(name,
                                            style: const TextStyle(
                                                color: _ink,
                                                fontWeight: FontWeight.bold)),
                                      ])),
                                ]),
                              ),
                              const SizedBox(height: 18),
                              if (groups.isEmpty)
                                _message(
                                    Icons.people_outline,
                                    'فعالیتی ثبت نشده است',
                                    'هنوز فعالیتی برای این بیمار ثبت نشده است.')
                              else ...[
                                Text(
                                    '${AppConfig.digits('${groups.length}')} رزیدنت',
                                    style: const TextStyle(
                                        color: _ink,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(height: 10),
                                for (final group in groups.entries)
                                  _residentCard(group.key, group.value),
                              ],
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _message(IconData icon, String title, String detail,
          {bool retry = false}) =>
      Center(
          child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: _teal, size: 42),
          const SizedBox(height: 12),
          Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: _ink, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(detail,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54)),
          if (retry) ...[
            const SizedBox(height: 12),
            FilledButton(
                onPressed: _refresh,
                style: FilledButton.styleFrom(backgroundColor: _teal),
                child: const Text('تلاش دوباره')),
          ],
        ]),
      ));

  Widget _residentCard(String name, List<ModelLogItemReport> activities) =>
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xffd6dde4)),
            borderRadius: BorderRadius.circular(14)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const CircleAvatar(
                backgroundColor: Color(0xffe3f6f0),
                child: Icon(Icons.person_outline, color: _teal)),
            const SizedBox(width: 10),
            Expanded(
                child: Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: _ink))),
            Text('${AppConfig.digits('${activities.length}')} فعالیت',
                style: const TextStyle(color: _teal, fontSize: 12)),
          ]),
          const Divider(height: 24),
          for (var index = 0; index < activities.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Icon(Icons.check_circle_outline, size: 18, color: _teal),
              const SizedBox(width: 8),
              Expanded(
                  child: Text(
                      activities[index].activity.trim().isEmpty
                          ? 'فعالیت نامشخص'
                          : activities[index].activity,
                      style: const TextStyle(color: _ink))),
              if (activities[index].time.trim().isNotEmpty) ...[
                const SizedBox(width: 8),
                Flexible(
                    child: Text(AppConfig.digits(activities[index].time),
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 12))),
              ],
            ]),
          ],
        ]),
      );
}
