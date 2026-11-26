
import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';

class PatientRecordBadge extends StatelessWidget {
  const PatientRecordBadge(
      {super.key,
      required this.text,
      this.outlined = false,
      this.color,
      this.background});
  final String text;
  final bool outlined;
  final Color? color;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final foreground = color ?? AppConfig.tealColorResident;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
            color: background ?? const Color(0xffe7f6f3),
            borderRadius: BorderRadius.circular(10),
            border: outlined ? Border.all(color: foreground) : null),
        child: Text(text,
            style: TextStyle(
                color: foreground,
                fontSize: 11,
                fontWeight: FontWeight.bold)));
  }
}
