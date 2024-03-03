// import 'dart:js';

import 'package:appstrock/Profile/ScreenProfile.dart';
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
import 'Screens/Laboratory/ScreenLaboratoryDetailPatient.dart';
import 'Screens/Laboratory/screen_Laboratory.dart';
import 'Screens/Reception/ProviderReception/ProviderReception.dart';

import 'Screens/Resident/ProviderResident/ProviderResident.dart';
import 'Screens/Resident/ProviderResident/ProviderResidentDetaile.dart';
import 'Screens/Resident/ScreenDetailPatient.dart';
import 'Screens/Resident/ScreenFormImage724.dart';
import 'Screens/Resident/ScreenFormIs724.dart';
import 'Screens/Resident/ScreenFormIsNot724.dart';
import 'Screens/Resident/ScreenFormNIHS.dart';
import 'Screens/Teriazh/ProviderTeraizh.dart';
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
        ChangeNotifierProvider(create: (context) => ProviderLaboratoryDetail()),
        ChangeNotifierProvider(create: (context) => ProviderAtend()),
        ChangeNotifierProvider(create: (context) => ProviderAtendDetaile()),
        ChangeNotifierProvider(create: (context) => ProviderTeraizh()),
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
      // home: ScreenAtend(context));
      // home: ScreenProfile());
      // home: ScreenLaboratory(),
      home: ScreenDetailPatientAtend(
          ModelPatient(id: 10, fullName: 'Ahmad Bagheri',
              nationalCode: '548548548484', age: '45',
              gender: 'مرد',
              timeOfAddToSystem: '14:20',
              dateOfAddToSystem: '1402/02/02',
              needToMRI: false,
              isNot724: false,
              needToCT: false,
              IsNIHSS: false, IsLab: false, timeOfAddLabotory: '', ResonNot: 'nxfnxfgn', Is724: false, TimeFss: '',
              TimeLKW: '', DateFSS: '', DateLKW: '',
              IsUnknow: false, timeOfAddResident: '', dateOfAddToStart: '', AddReasonNot724: false,
              AtendSeen: false, Residents: '', Atends: ''), context));

      // home: ScreenResident(context));
      //   home: ScreenFormIs724((p){
      //
      //   }));
      //   home: ScreenFormImage724());
        // home: ScreenDetailPatient(
        //     ModelPatient(id: 14, fullName: 'Ahmad bagheri',
        //     nationalCode: '4845154444', age: '34', gender: 'Female',
        //     timeOfAddToSystem: '14:30', dateOfAddToSystem: '1402/01/01',
        //     needToMRI: false, isNot724: false,
        //         needToCT: false, IsNIHSS: false,
        //         IsLab: false, timeOfAddLabotory: '',
        //         ResonNot: '', Is724: false,
        //         AddReasonNot724: false,
        //         timeOfAddResident: '',
        //         TimeFss: '', TimeLKW: '',
        //         DateFSS: '', DateLKW: '', IsUnknow: false, dateOfAddToStart: '', AtendSeen: false),context));
      //   home: ScreenFormNIHS((c){
      //
      //
      //   },false));
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
      // home: ScreenEms('jbjb','55',true));
      // home: ScreenRigester());
      // home: ScreenEms(),
      // home: Screen_Teriazh());
      // home: ScreenReception('Nima','+6+6',true));
      // home: ScreenSickCarrier());
      // home: ScreenReception(),
      // home: ScreenResident(context));
      // home: ScreenLaboratory());
      // home: ScreenAtend(context));
      // home: ScreenDetailPatient(),
      // home: ScreenSickCarrier(),

  }
}

