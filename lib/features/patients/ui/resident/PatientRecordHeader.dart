
import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';


class PatientRecordHeader extends StatelessWidget {
  const PatientRecordHeader({super.key});

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppConfig.borderColorResident))),
      child: Row(children: [
        Image.asset('web/icons/Icon-512.png', width: 29, height: 29),
        const SizedBox(width: 4),
        const Text('استروک',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 14, color: AppConfig.inkColorResident)),
      ]));
}