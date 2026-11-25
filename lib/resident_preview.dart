import 'package:flutter/material.dart';

import 'Screens/Resident/resident_patients_preview.dart';

void main() => runApp(const ResidentPreviewApp());

class ResidentPreviewApp extends StatelessWidget {
  const ResidentPreviewApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'iransans', useMaterial3: false),
        home: const ResidentPatientsPreview(),
      );
}
