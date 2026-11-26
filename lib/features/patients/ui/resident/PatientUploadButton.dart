
import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';




class PatientUploadButton extends StatelessWidget {
  const PatientUploadButton(
      {super.key, required this.onPressed, this.label = 'آپلود عکس'});
  final VoidCallback onPressed;
  final String label;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 50,
      child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
              backgroundColor: AppConfig.tealColorResident,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(label,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold))));
}
