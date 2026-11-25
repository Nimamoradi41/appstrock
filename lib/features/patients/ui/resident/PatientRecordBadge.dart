
import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';

class PatientRecordBadge extends StatelessWidget {
  const PatientRecordBadge(
      {super.key, required this.text, this.outlined = false});
  final String text;
  final bool outlined;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: const Color(0xffe7f6f3),
          borderRadius: BorderRadius.circular(10),
          border: outlined ? Border.all(color: AppConfig.tealColorResident) : null),
      child: Text(text,
          style: const TextStyle(
              color: AppConfig.tealColorResident, fontSize: 11, fontWeight: FontWeight.bold)));
}