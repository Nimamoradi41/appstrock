import 'package:appstrock/Screens/Atend/ScreenAtend.dart';
import 'package:appstrock/Screens/Autentication/ApiServiceAutentication.dart';
import 'package:appstrock/features/authentication/ui/screen_login.dart';
import 'package:appstrock/features/patient_registration/ui/screen_ems.dart';
import 'package:appstrock/Screens/Reception/screen_reception.dart';
import 'package:appstrock/Screens/Resident/resident_patients_preview.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:flutter/material.dart';
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

    if(prefs.getBool("Login")!=null)
      {
        Login=prefs.getBool("Login")!;
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
                 GoNextPageGameOver(context,const ResidentPatientsPreview());
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
      backgroundColor: const Color(0xffedf3f8),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 464),
            child: Container(
              margin: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xfffafcfd),
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x160e3149),
                    blurRadius: 24,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  Container(
                    width: 124,
                    height: 124,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xffe5f5f1),
                      borderRadius: BorderRadius.circular(34),
                    ),
                    child: Image.asset('web/icons/Icon-512.png'),
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'استروک',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      color: Color(0xff102038),
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'مسیر روشن مراقبت از بیمار',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xff667589), fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(
                    width: 25,
                    height: 25,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Color(0xff007d83),
                      backgroundColor: Color(0xffd8eeeb),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'در حال آماده‌سازی',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xff667589), fontSize: 12),
                  ),
                  const Spacer(flex: 3),
                  const Text(
                    VersionApp,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: Color(0xff8996a5), fontSize: 11),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
