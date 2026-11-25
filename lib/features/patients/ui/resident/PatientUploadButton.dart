
import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';




class PatientUploadButton extends StatelessWidget {
  const PatientUploadButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
      height: 50,
      child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
              backgroundColor: AppConfig.tealColorResident,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text('آپلود عکس',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))));
}