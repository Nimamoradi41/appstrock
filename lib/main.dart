// import 'dart:js';

import 'package:appstrock/Screens/Ems/ProviderEms/ProviderEms.dart';
import 'package:appstrock/report/FirstReportScreen.dart';
import 'package:appstrock/report/ProviderFirstReport.dart';
import 'package:appstrock/testNotfication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'Screens/Atend/ScreenAtend.dart';
import 'features/patient_registration/ui/screen_ems.dart';
import 'Screens/Resident/screen_resident.dart';
import 'Screens/Teriazh/screen_teriazh.dart';
import 'firebase_web_messaging.dart';
import 'foreground_notification.dart';
import 'Screens/Teriazh/notification_registration.dart';

import 'Screens/Atend/ProviderAtend/ProviderAtend.dart';
import 'Screens/Atend/ProviderAtend/ProviderAtendDetaile.dart';
import 'Screens/Atend/ScreenFormMedicalInjection.dart';
import 'Screens/Laboratory/ProviderLaboratory/ProviderLaboratoryDetail.dart';
import 'Screens/Reception/ProviderReception/ProviderReception.dart';
import 'Screens/Resident/ProviderResident/ProviderResident.dart';
import 'Screens/Resident/ProviderResident/ProviderResidentDetaile.dart';
import 'Screens/Resident/ProviderResident/ProviderTimers.dart';
import 'Screens/SplashScreen.dart';
import 'Screens/Strok/ProviderStrok/ProviderStrok.dart';
import 'Screens/Teriazh/ProviderTeraizh.dart';
import 'Screens/sickcarrier/ProviderSickCarrier/ProviderSickCarrier.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    initializeFirebaseWebMessaging().catchError((Object error) {
      debugPrint('Firebase initialization failed: $error');
    });
    syncNotificationTokenIfAllowed().catchError((Object error) {
      debugPrint('Notification token synchronization failed: $error');
    });
  }
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
    ChangeNotifierProvider(create: (context) => ProviderFirstReport()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        scaffoldMessengerKey: notificationMessengerKey,
        theme: ThemeData(fontFamily: 'iransans'),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen()
        // home:     ScreenEms(false)
        // home:     Screen_Teriazh()
        // home:     ScreenResident(context)
        // home:   ScreenAtend()
        // home:  testNotfication()
        // home:   FirstReportScreen()
        // home: WebImagePicker('نیما','27','1742778887','مرد','541541')
        // home: ScreenRigester());
        // home: testt()
        );
  }

  void test() {}
}
