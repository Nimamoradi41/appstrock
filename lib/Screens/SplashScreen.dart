import 'package:appstrock/Screens/Atend/ScreenAtend.dart';
import 'package:appstrock/Screens/Autentication/ApiServiceAutentication.dart';
import 'package:appstrock/Screens/Autentication/ScreenLogin.dart';
import 'package:appstrock/Screens/Autentication/ScreenRigester.dart';
import 'package:appstrock/Screens/Ems/screen_ems.dart';
import 'package:appstrock/Screens/Reception/screen_reception.dart';
import 'package:appstrock/Screens/Resident/screen_resident.dart';
import 'package:appstrock/Screens/Strok/ScreenStrock.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import 'Laboratory/screen_Laboratory.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  Future Run()async{
     // اول چک بکنه که قبلا لاگین کرده با نه اگر بلگین کرده بود رکوست لاگین بزنه در غیر این صورت بعد یک تاخیر 2 ثانیه ببرش توی صفحه ثبت نام
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var Login=false;
    var TypeUser=1;

    if(prefs.getBool("Login")!=null)
      {
        Login=prefs.getBool("Login")!;
        TypeUser=prefs.getInt("TypeUser")!;
      }
    if(Login)
      {
        var Name=  prefs.getString("Name");
        var Code=prefs.getString("Code");
        var Pass=prefs.getString("Pass");
       // ignore: use_build_context_synchronously
       var LoginUser= await ApiServiceAutentication.Login(Name!, Code!,Pass!, context);
       if(LoginUser!=null)
         {
           if(LoginUser.success)
           {
               prefs.setBool("isOnline", LoginUser.data!.isOnline);
               if(LoginUser.data?.departmentId==1)
                 {
                   // ignore: use_build_context_synchronously
                   GoNextPageGameOver(context,ScreenEms(false));
                 }
               if(LoginUser.data?.departmentId==2)
               {
                 // ignore: use_build_context_synchronously
                 GoNextPageGameOver(context,Screen_Teriazh());
               }
               if(LoginUser.data?.departmentId==3)
               {
                 // ignore: use_build_context_synchronously
                 GoNextPageGameOver(context,ScreenReception());
               }

               if(LoginUser.data?.departmentId==5)
               {
                 // ignore: use_build_context_synchronously
                 GoNextPageGameOver(context,ScreenAtend());
               }

               if(LoginUser.data?.departmentId==7)
               {
                 // ignore: use_build_context_synchronously
                 GoNextPageGameOver(context,ScreenResident(context));
               }

               if(LoginUser.data?.departmentId==6)
               {
                 // ignore: use_build_context_synchronously
                 GoNextPageGameOver(context,ScreenLaboratory());
               }
               if(LoginUser.data?.departmentId==6)
               {
                 // ignore: use_build_context_synchronously
                 GoNextPageGameOver(context,ScreenLaboratory());
               }

             }
           else
           {
             GoNextPageGameOver(context, ScreenLogin());
           }
         }
      }else{
      Future.delayed(const Duration(seconds: 2), () {
        GoNextPageGameOver(context, ScreenLogin());
      });
    }

  }





  @override
  void initState() {
    super.initState();
    Run();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Lottie.asset(
              'assets/loadingsplash.json',
              width: 150,
              repeat: true,
              reverse: true,
              animate: true,
            ),
            SizedBox(height: 0,),
            TextAppStartfredoka('AppStrock', 24, Colors.black54, true),
            Spacer(),
            TextApp(VersionApp, 12, Colors.black54, true)

          ],
        ),
      ),
    );
  }
}
