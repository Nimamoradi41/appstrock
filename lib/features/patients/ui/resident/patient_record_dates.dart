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
    final startTime = patient.signsStartTime?.trim() ?? '';
    final finish = finishDate.isEmpty
        ? 'ثبت نشده'
        : '${_value(finishDate)}  •  ${_value(finishTime)}';

    final rows = <PatientRecordDateRow>[
      PatientRecordDateRow(
          label: 'زمان ثبت در سیستم', value: _value(patient.timeOfAddToSystem)),
      PatientRecordDateRow(
          label: 'تاریخ ثبت در سیستم',
          value: _value(patient.dateOfAddToSystem)),
      if (startTime.isNotEmpty)
        PatientRecordDateRow(
            label: 'زمان و تاریخ شروع علائم',
            value:
                '${_value(patient.signsStartDate)}  •  ${_value(startTime)}'),
      if (patient.labIsComplete)
        PatientRecordDateRow(
            label: 'زمان ثبت فرم آزمایشگاه',
            value:
                '${_value(patient.labInsertDate)}  •  ${_value(patient.labInsertTime)}'),
      if (patient.otn.trim().isNotEmpty)
        PatientRecordDateRow(label: 'OTN', value: _value(patient.otn)),
      if (patient.dtn.trim().isNotEmpty)
        PatientRecordDateRow(label: 'DTN', value: _value(patient.dtn)),
      if (patient.isNot724 || finishDate.isNotEmpty)
        PatientRecordDateRow(label: 'زمان و تاریخ پایان کار', value: finish),
    ];

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
          Text('زمان‌های پرونده',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppConfig.inkColorResident)),
        ]),
        const SizedBox(height: 8),
        for (var index = 0; index < rows.length; index++)
          PatientRecordDateRow(
              label: rows[index].label,
              value: rows[index].value,
              last: index == rows.length - 1),
      ]),
    );
  }
}

class PatientRecordDateRow extends StatelessWidget {
  const PatientRecordDateRow(
      {super.key, required this.label, required this.value, this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            border: last
                ? null
                : const Border(
                    bottom: BorderSide(color: AppConfig.borderColorResident))),
        child: Row(children: [
          Expanded(
              child: Text(label,
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xff526073)))),
          const SizedBox(width: 8),
          Flexible(
              child: Text(value,
                  textAlign: TextAlign.end,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppConfig.inkColorResident))),
        ]),
      );
}
