
import 'package:appstrock/core/AppConfig.dart';
import 'package:flutter/material.dart';


class PatientCodeDecision extends StatelessWidget {
  const PatientCodeDecision({
    super.key,
    required this.onIs724,
    required this.onIsNot724,
    this.submitting = false,
  });

  final VoidCallback onIs724;
  final VoidCallback onIsNot724;
  final bool submitting;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xffedf7f5),
      border: Border.all(color: const Color(0xffc9e6e0)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('تعیین وضعیت بیمار',
          style: TextStyle(
              color: AppConfig.inkColorResident, fontWeight: FontWeight.bold, fontSize: 13)),
      const SizedBox(height: 4),
      const Text('پس از بررسی، وضعیت کد ۷۲۴ را انتخاب کنید.',
          style: TextStyle(color: Color(0xff526073), fontSize: 11)),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: submitting ? null : onIs724,
            icon: const Icon(Icons.bolt, size: 19),
            label: const Text('کد ۷۲۴ است'),
            style: FilledButton.styleFrom(
              backgroundColor: AppConfig.tealColorResident,
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 6),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            onPressed: submitting ? null : onIsNot724,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppConfig.tealColorResident,
              side: const BorderSide(color: AppConfig.tealColorResident),
              minimumSize: const Size(0, 44),
              padding: const EdgeInsets.symmetric(horizontal: 6),
            ),
            child: submitting
                ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2))
                : const Text('کد ۷۲۴ نیست'),
          ),
        ),
      ]),
    ]),
  );
}