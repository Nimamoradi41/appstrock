import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';

class PatientRecordDates extends StatelessWidget {
  const PatientRecordDates({super.key, required this.patient});

  final ModelPatient patient;

  String _value(String? input) {
    final value = input?.trim() ?? '';
    return value.isEmpty ? 'نامشخص' : AppConfig.digits(value);
  }

  @override
  Widget build(BuildContext context) {
    final finishDate = patient.dateFinishShamsi?.trim() ?? '';
    final finishTime = patient.timeFinish?.trim() ?? '';
    final finish = finishDate.isEmpty
        ? 'ثبت نشده'
        : '${_value(finishDate)}  •  ${_value(finishTime)}';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xfffbfcfe),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConfig.borderColorResident),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Row(children: [
          Icon(Icons.schedule_outlined, color: AppConfig.tealColorResident),
          SizedBox(width: 8),
          Text('زمان‌های پرونده', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppConfig.inkColorResident)),
        ]),
        const SizedBox(height: 8),
        PatientRecordDateRow(label: 'زمان ثبت در سیستم', value: _value(patient.timeOfAddToSystem)),
        PatientRecordDateRow(label: 'تاریخ ثبت در سیستم', value: _value(patient.dateOfAddToSystem)),
        PatientRecordDateRow(label: 'زمان و تاریخ پایان کار', value: finish, last: true),
      ]),
    );
  }
}

class PatientRecordDateRow extends StatelessWidget {
  const PatientRecordDateRow({super.key, required this.label, required this.value, this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(border: last ? null : const Border(bottom: BorderSide(color: AppConfig.borderColorResident))),
        child: Row(children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xff526073)))),
          const SizedBox(width: 8),
          Flexible(child: Text(value, textAlign: TextAlign.end, textDirection: TextDirection.ltr, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppConfig.inkColorResident))),
        ]),
      );
}
