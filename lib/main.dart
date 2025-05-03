// import 'dart:js';

import 'package:appstrock/Screens/Ems/ProviderEms/ProviderEms.dart';
import 'package:appstrock/report/FirstReportScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Atend/ProviderAtend/ProviderAtend.dart';
import 'Screens/Atend/ProviderAtend/ProviderAtendDetaile.dart';
import 'Screens/Laboratory/ProviderLaboratory/ProviderLaboratoryDetail.dart';
import 'Screens/Reception/ProviderReception/ProviderReception.dart';
import 'Screens/Resident/ProviderResident/ProviderResident.dart';
import 'Screens/Resident/ProviderResident/ProviderResidentDetaile.dart';
import 'Screens/Resident/ProviderResident/ProviderTimers.dart';
import 'Screens/Strok/ProviderStrok/ProviderStrok.dart';
import 'Screens/Teriazh/ProviderTeraizh.dart';
import 'Screens/sickcarrier/ProviderSickCarrier/ProviderSickCarrier.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProviderReception()),
    ChangeNotifierProvider(create: (context) => ProviderEms()),
    ChangeNotifierProvider(create: (context) => ProviderSickCarrier()),
    ChangeNotifierProvider(create: (context) => ProviderResident()),
    ChangeNotifierProvider(create: (context) => ProviderResidentDetaile()),
    ChangeNotifierProvider(create: (context) => ProviderLaboratoryDetail()),
    ChangeNotifierProvider(create: (context) => ProviderAtend()),
    ChangeNotifierProvider(create: (context) => ProviderAtendDetaile()),
    ChangeNotifierProvider(create: (context) => ProviderTeraizh()),
    ChangeNotifierProvider(create: (context) => ProviderStrok()),
    ChangeNotifierProvider(create: (context) => ProviderTimers()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: 'iransans'),
        debugShowCheckedModeBanner: false,
        // home: const SplashScreen()
        home: const FirstReportScreen()
        // home: WebImagePicker('نیما','27','1742778887','مرد','541541')
        // home: ScreenRigester());
        // home: testt()
        );
  }

  void test() {}
}
