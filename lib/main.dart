// import 'dart:js';

import 'package:appstrock/Profile/ScreenProfile.dart';
import 'package:appstrock/Screens/Atend/ScreenListImages.dart';
import 'package:appstrock/Screens/Autentication/ScreenRigester.dart';
import 'package:appstrock/Screens/Ems/ProviderEms/ProviderEms.dart';
import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:appstrock/Screens/Reception/screen_reception.dart';
import 'package:appstrock/Screens/Resident/screen_resident.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:appstrock/scr.dart';
import 'package:appstrock/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Constants.dart';
import 'Screens/Atend/ProviderAtend/ProviderAtend.dart';
import 'Screens/Atend/ProviderAtend/ProviderAtendDetaile.dart';
import 'Screens/Atend/ScreenAtend.dart';
import 'Screens/Atend/ScreenDetailPatientAtend.dart';
import 'Screens/Autentication/ScreenCodeOtp.dart';
import 'Screens/Autentication/ScreenLogin.dart';
import 'Screens/Ems/screen_ems.dart';
import 'Screens/Laboratory/ProviderLaboratory/ProviderLaboratoryDetail.dart';
import 'Screens/Laboratory/ScreenFormLaboratory.dart';
import 'Screens/Laboratory/ScreenLaboratoryDetailPatient.dart';
import 'Screens/Laboratory/screen_Laboratory.dart';
import 'Screens/Reception/ProviderReception/ProviderReception.dart';
import 'Screens/Resident/ApiServiceResident.dart';
import 'Screens/Resident/ProviderResident/ProviderResident.dart';
import 'Screens/Resident/ProviderResident/ProviderResidentDetaile.dart';
import 'Screens/Resident/ProviderResident/ProviderTimers.dart';
import 'Screens/Resident/ScreenDetailPatient.dart';
import 'Screens/Resident/ScreenFormImage724.dart';
import 'Screens/Resident/ScreenFormIs724.dart';
import 'Screens/Resident/ScreenFormIsNot724.dart';
import 'Screens/Resident/ScreenFormNIHS.dart';
import 'Screens/Resident/ScreenFormReasonInjection.dart';
import 'Screens/SignalRService.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/Strok/ProviderStrok/ProviderStrok.dart';
import 'Screens/Teriazh/ProviderTeraizh.dart';
import 'Screens/sickcarrier/ProviderSickCarrier/ProviderSickCarrier.dart';
import 'Screens/sickcarrier/screen_sickcarrier.dart';
import 'Widgets/StaticWidget.dart';
import 'Widgets/TextApp.dart';
import 'Widgets/testt.dart';

void main() {
  runApp(  MultiProvider(
      providers: [
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
      ],
      child: MyApp()));
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
    // SignalRService().initConnection();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'iransans'
      ),
      debugShowCheckedModeBanner: false,
        routes: {
          '/home': (context) => SplashScreen(),    // صفحه اصلی
          '/screen': (context) => staticWidget2(), // صفحه دوم
        },
      home: SplashScreen()
      // home: ScreenRigester());
      // home: testt()
    );

  }

  void test()
  {

  }
}

