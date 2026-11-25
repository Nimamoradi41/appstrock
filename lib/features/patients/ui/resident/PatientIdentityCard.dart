

import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../Screens/Resident/resident_patient_record.dart';
import 'PatientRecordBadge.dart';


class PatientIdentityCard extends StatelessWidget {
  const PatientIdentityCard(
      {super.key, required this.patient, required this.active});
  final ModelPatient patient;
  final bool active;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(14),
      decoration: AppConfig.box(),
      child: Row(children: [
        Expanded(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(patient.fullName.isEmpty ? 'نام ثبت نشده' : patient.fullName,
                  style: const TextStyle(
                      color: AppConfig.inkColorResident, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                  '${patient.gender.isEmpty ? '—' : patient.gender}  •  ${patient.age.isEmpty ? '—' : AppConfig.digits(patient.age)} سال',
                  style: const TextStyle(color: Color(0xff4e5b6b), fontSize: 12)),
              Text(
                  'کد ملی: ${patient.nationalCode.isEmpty ? '—' : AppConfig.digits(patient.nationalCode)}',
                  style: const TextStyle(color: Color(0xff4e5b6b), fontSize: 12)),
            ])),
        PatientRecordBadge(
            text: patient.isFinished == true
                ? 'تکمیل‌شده'
                : patient.isNot724
                ? 'غیر ۷۲۴'
                : active
                ? 'کد ۷۲۴ فعال'
                : 'در انتظار بررسی',
            outlined: true),
      ]));
}