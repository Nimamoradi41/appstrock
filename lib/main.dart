import 'package:appstrock/ScreenRegister.dart';
import 'package:flutter/material.dart';

import 'ScreenLogin.dart';
import 'Screens/Ems/screen_ems.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'iransans'
      ),
      debugShowCheckedModeBanner: false,
      // home: ScreenLogin(),
      // home: ScreenRegister(),
      home: ScreenEms(),
    );
  }
}

