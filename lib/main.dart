import 'package:appstrock/ScreenRegister.dart';
import 'package:appstrock/Screens/Reception/screen_reception.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:flutter/material.dart';

import 'ScreenLogin.dart';
import 'Screens/Ems/screen_ems.dart';
import 'Screens/sickcarrier/screen_sickcarrier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'iransans'
      ),
      debugShowCheckedModeBanner: false,
      // home: ScreenLogin(),
      home: ScreenRegister(),
      // home: ScreenEms(),
      // home: Screen_Teriazh(),
      // home: ScreenReception(),
      // home: ScreenSickCarrier(),
    );
  }
}

