// import 'dart:js';

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
import 'Screens/Autentication/ScreenCodeOtp.dart';
import 'Screens/Autentication/ScreenLogin.dart';
import 'Screens/Ems/screen_ems.dart';
import 'Screens/Reception/ProviderReception/ProviderReception.dart';

import 'Screens/Resident/ProviderResident/ProviderResident.dart';
import 'Screens/Resident/ProviderResident/ProviderResidentDetaile.dart';
import 'Screens/Resident/ScreenDetailPatient.dart';
import 'Screens/Resident/ScreenFormNIHS.dart';
import 'Screens/sickcarrier/ProviderSickCarrier/ProviderSickCarrier.dart';
import 'Screens/sickcarrier/screen_sickcarrier.dart';
import 'Widgets/TextApp.dart';

void main() {
  runApp(  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderReception()),
        ChangeNotifierProvider(create: (context) => ProviderEms()),
        ChangeNotifierProvider(create: (context) => ProviderSickCarrier()),
        ChangeNotifierProvider(create: (context) => ProviderResident()),
        ChangeNotifierProvider(create: (context) => ProviderResidentDetaile()),
      ],
      child: MyApp()));
}

class MyApp extends StatefulWidget {


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'iransans'
      ),
      debugShowCheckedModeBanner: false,
      // home: ScreenLogin(),
      // home: ScreenRigester(),
      // home: ScreenResident(context),
        home: ScreenDetailPatient(
            ModelPatient(id: 14, fullName: 'Ahmad bagheri',
            nationalCode: '4845154444', age: '34', gender: 'Female',
            timeOfAddToSystem: '14:30', dateOfAddToSystem: '1402/01/01',
            needToMRI: false, isNot724: false, needToCT: true, IsNIHSS: false, IsLab: false),context)
        // home: ScreenFormNIHS((c){
        //
        //   print(c.toString());
        // })
      // home: test(),
      // home: ExamForm(),
      // home: Scaffold(
      //   body: Column(
      //     children: [
      //       Center(
      //         child: InkWell(
      //           onTap: (){
      //            Run(context);
      //           },
      //           child: Container(
      //             width: 100,
      //             height: 100,
      //             color: Colors.black87,
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // home: ScreenCodeOtp(),
      // home: scr(),
      // home: ScreenEms(),
      // home: ScreenEms(),
      // home: Screen_Teriazh(),
      // home: ScreenReception(),
      // home: ScreenResident(),
      // home: ScreenDetailPatient(),
      // home: ScreenSickCarrier(),
    );
  }
}

