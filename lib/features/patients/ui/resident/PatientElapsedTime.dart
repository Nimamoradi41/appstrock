
import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';



class PatientElapsedTime extends StatelessWidget {
  const PatientElapsedTime(
      {super.key, required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.access_time, size: 17, color: Color(0xff8998a9)),
      const SizedBox(width: 5),
      Text(label,
          style: const TextStyle(color: Color(0xff526073), fontSize: 11))
    ]),
    Text(value,
        textDirection: TextDirection.ltr,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: AppConfig.inkColorResident)),
  ]);
}