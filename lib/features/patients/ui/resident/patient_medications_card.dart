import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import '../../../../core/AppConfig.dart';

class PatientMedicationsCard extends StatelessWidget {
  const PatientMedicationsCard(
      {super.key, required this.patient, this.showInjectionTime = true});

  final ModelPatient patient;
  final bool showInjectionTime;

  String _medicineName(int? medicine) {
    switch (medicine) {
      case null:
      case 0:
        return 'ثبت نشده';
      case 1:
        return 'آلتپلاز';
      case 2:
        return 'تنکتپلاز';
      case 3:
        return 'آلتلایز (ایرانی)';
      default:
        return 'نامشخص';
    }
  }

  Widget _row(String title, int? medicine) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 9),
        child: Row(children: [
          Expanded(
              child: Text(title,
                  style:
                      const TextStyle(fontSize: 13, color: Color(0xff526073)))),
          const SizedBox(width: 10),
          Flexible(
              child: Text(_medicineName(medicine),
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: medicine == null || medicine == 0
                          ? const Color(0xff718093)
                          : AppConfig.inkColorResident))),
        ]),
      );

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: const Color(0xfffbfcfe),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppConfig.borderColorResident)),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Row(children: [
            Icon(Icons.medication_outlined, color: AppConfig.tealColorResident),
            SizedBox(width: 8),
            Text('داروهای پرونده',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppConfig.inkColorResident)),
          ]),
          const SizedBox(height: 5),
          _row('داروی پیشنهادی متخصص', patient.recommendedMedication),
          const Divider(height: 1, color: AppConfig.borderColorResident),
          _row('داروی تزریق‌شده', patient.medicine),
          if (showInjectionTime &&
              (patient.timeOfInjection?.trim() ?? '').isNotEmpty) ...[
            const Divider(height: 1, color: AppConfig.borderColorResident),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 9),
              child: Row(children: [
                const Expanded(
                    child: Text('زمان تزریق',
                        style:
                            TextStyle(fontSize: 13, color: Color(0xff526073)))),
                Text(AppConfig.digits(patient.timeOfInjection!.trim()),
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.inkColorResident)),
              ]),
            ),
          ],
        ]),
      );
}
