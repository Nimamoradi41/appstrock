

import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';

import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'PatientRecordBadge.dart';


class PatientIdentityCard extends StatelessWidget {
  const PatientIdentityCard(
      {super.key, required this.patient, required this.active});
  final ModelPatient patient;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final finished = patient.isFinished == true;
    final seenByAttend = patient.seenByAttend == true;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: AppConfig.box(
          color: finished ? AppConfig.successSurfaceResident : null,
          borderColor: finished ? AppConfig.successBorderResident : null),
      child: Row(children: [
        Expanded(
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(patient.withoutInfo ? 'بیمار مجهول‌الهویه' : patient.fullName.isEmpty ? 'نام ثبت نشده' : patient.fullName,
                  style: const TextStyle(
                      color: AppConfig.inkColorResident, fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                  '${patient.gender.isEmpty ? '—' : patient.gender}  •  ${patient.age.isEmpty ? '—' : AppConfig.digits(patient.age)} سال',
                  style: const TextStyle(color: Color(0xff4e5b6b), fontSize: 12)),
              Text(
                  'کد ملی: ${patient.nationalCode.isEmpty ? '—' : AppConfig.digits(patient.nationalCode)}',
                  style: const TextStyle(color: Color(0xff4e5b6b), fontSize: 12)),
              if (seenByAttend)
                const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Row(children: [
                      Icon(Icons.verified_outlined,
                          size: 15, color: AppConfig.successColorResident),
                      SizedBox(width: 4),
                      Expanded(
                          child: Text('دکتر متخصص مشاهده کرده',
                              style: TextStyle(
                                  color: AppConfig.successColorResident,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold))),
                    ])),
            ])),
        PatientRecordBadge(
            text: finished
                ? 'تکمیل شده'
                : patient.isNot724
                ? 'غیر ۷۲۴'
                : active
                ? 'کد ۷۲۴ فعال'
                : 'در انتظار بررسی',
            color: finished ? AppConfig.successColorResident : null,
            background: finished ? const Color(0xffd6f2e2) : null,
            outlined: !finished),
      ]));
  }
}
