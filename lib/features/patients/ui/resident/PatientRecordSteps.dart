import 'package:flutter/material.dart';

import '../../../../core/AppConfig.dart';

class PatientRecordSteps extends StatelessWidget {
  const PatientRecordSteps(
      {super.key,
      required this.step,
      this.labels = const ['ثبت', 'ارزیابی', 'نظر اتند', 'اقدام'],
      this.completed = false});
  final int step;
  final List<String> labels;
  final bool completed;

  @override
  Widget build(BuildContext context) => Row(
          children: List.generate(labels.length, (index) {
        final position = index + 1;
        final done = position < step ||
            (completed && position == step) ||
            (labels.length == 4 && step == 4 && position == 4);
        final current = position == step && !done;
        return Expanded(
            child: Column(children: [
          Row(children: [
            Expanded(
                child: Container(
                    height: 2,
                    color: index == 0
                        ? Colors.transparent
                        : position <= step
                            ? const Color(0xff20aa7a)
                            : const Color(0xffbcc8d4))),
            Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: done
                        ? const Color(0xff17a672)
                        : current
                            ? AppConfig.tealColorResident
                            : const Color(0xffedf1f5),
                    border: Border.all(
                        color: done
                            ? const Color(0xff17a672)
                            : current
                                ? AppConfig.tealColorResident
                                : const Color(0xff9aa9b8),
                        width: 2)),
                child: done
                    ? const Icon(Icons.check, color: Colors.white, size: 15)
                    : current
                        ? const Center(
                            child: CircleAvatar(
                                radius: 3, backgroundColor: Colors.white))
                        : null),
            Expanded(
                child: Container(
                    height: 2,
                    color: index == labels.length - 1
                        ? Colors.transparent
                        : position < step
                            ? const Color(0xff20aa7a)
                            : const Color(0xffbcc8d4))),
          ]),
          const SizedBox(height: 4),
          Text(labels[index],
              style: TextStyle(
                  fontSize: 11,
                  color: AppConfig.inkColorResident,
                  fontWeight: current ? FontWeight.bold : FontWeight.normal)),
        ]));
      }));
}
