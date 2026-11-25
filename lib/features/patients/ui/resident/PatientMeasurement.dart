import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';

class PatientMeasurement extends StatelessWidget {
  const PatientMeasurement(
      {super.key, required this.title, required this.value, this.onTap});
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
          height: 72,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xffe1f1ee),
              borderRadius: BorderRadius.circular(9)),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 12, color: AppConfig.inkColorResident)),
            Center(
                child: Text(value,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppConfig.inkColorResident))),
          ])));
}
