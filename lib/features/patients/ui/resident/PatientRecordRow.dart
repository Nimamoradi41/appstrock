
import 'package:flutter/material.dart';

import '../../../../Screens/Resident/resident_patient_record.dart';
import '../../../../core/AppConfig.dart';
import 'PatientRecordBadge.dart';


class PatientRecordRow extends StatelessWidget {
  const PatientRecordRow(
      {super.key,
        required this.title,
        required this.status,
        required this.action,
        required this.onTap,
        this.statusComplete,
        this.last = false});
  final String title;
  final String status;
  final String action;
  final VoidCallback onTap;
  final bool? statusComplete;
  final bool last;

  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
              border: last
                  ? null
                  : const Border(bottom: BorderSide(color: AppConfig.borderColorResident))),
          child: Row(children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold, color: AppConfig.inkColorResident)),
            const Spacer(),
            if (status.isNotEmpty)
              statusComplete != null
                  ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                      color: statusComplete!
                          ? const Color(0xffdff3e7)
                          : const Color(0xffffeac4),
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(status,
                      style: TextStyle(
                          fontSize: 10,
                          color: statusComplete!
                              ? const Color(0xff168251)
                              : const Color(0xffa35c00))))
                  : PatientRecordBadge(text: status),
            const Spacer(),
            Flexible(
                child: Text(action,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10,
                        color: AppConfig.tealColorResident,
                        fontWeight: FontWeight.bold))),
            const Icon(Icons.chevron_left, size: 18, color: AppConfig.tealColorResident),
          ])));
}