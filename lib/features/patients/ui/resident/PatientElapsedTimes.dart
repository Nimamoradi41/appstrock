
import 'dart:async';

import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';

import '../../../../Screens/Reception/Model/ModelPatient.dart';
import 'PatientElapsedTime.dart';



class PatientElapsedTimes extends StatefulWidget {
  const PatientElapsedTimes(
      {super.key,
        required this.patient,
        required this.elapsedSinceRegistration,
        required this.elapsedSinceSymptoms});
  final ModelPatient patient;
  final Duration elapsedSinceRegistration;
  final Duration elapsedSinceSymptoms;

  @override
  State<PatientElapsedTimes> createState() => _PatientElapsedTimesState();
}

class _PatientElapsedTimesState extends State<PatientElapsedTimes> {
  final ValueNotifier<DateTime> _clock = ValueNotifier(DateTime.now());
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTimer();
  }

  @override
  void didUpdateWidget(covariant PatientElapsedTimes oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.patient.isFinished != widget.patient.isFinished) {
      _updateTimer();
    }
  }

  void _updateTimer() {
    _timer?.cancel();
    if (widget.patient.isFinished != true) {
      _clock.value = DateTime.now();
      _timer = Timer.periodic(
          const Duration(seconds: 1), (_) => _clock.value = DateTime.now());
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _clock.dispose();
    super.dispose();
  }

  String _elapsed(int? timestamp, Duration fallback, DateTime now) {
    if (timestamp == null || timestamp <= 0) return '—';
    if (widget.patient.isFinished == true && fallback == Duration.zero) {
      return '—';
    }
    final duration = widget.patient.isFinished == true
        ? fallback
        : now.difference(DateTime.fromMillisecondsSinceEpoch(timestamp));
    if (duration.isNegative) return '—';
    return AppConfig.digits(
        '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}');
  }

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<DateTime>(
      valueListenable: _clock,
      builder: (context, now, child) => Container(
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
              color: const Color(0xffeef2f6),
              borderRadius: BorderRadius.circular(10)),
          child: Row(children: [
            Expanded(
                child: PatientElapsedTime(
                    label: 'از ثبت',
                    value: _elapsed(widget.patient.insertTimeTS,
                        widget.elapsedSinceRegistration, now))),
            Container(width: 1, height: 43, color: const Color(0xffbdc9d5)),
            Expanded(
                child: PatientElapsedTime(
                    label: 'از شروع علائم',
                    value: _elapsed(widget.patient.signsStartTS,
                        widget.elapsedSinceSymptoms, now))),
          ])));
}


