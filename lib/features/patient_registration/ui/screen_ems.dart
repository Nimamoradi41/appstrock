import '../../authentication/ui/screen_EditProfile.dart';
import '../../../Widgets/notification_registration_button.dart';

import 'package:appstrock/Screens/Ems/ApiServiceEms.dart';
import 'package:appstrock/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import '../model/patient_registration.dart';
import 'patient_registration_screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Constants.dart';
import '../../../Screens/Reception/ApiServiceReception.dart';
import '../../../Screens/Ems/ProviderEms/ProviderEms.dart';

class ScreenEms extends StatefulWidget {
   late bool isAtend;

   ScreenEms(this.isAtend){}

   @override
  State<ScreenEms> createState() => _ScreenEmsState();

}

class _ScreenEmsState extends State<ScreenEms> {
   bool status=false;

   var items = [
     'مرد',
     'زن',
   ];

   late var Notifi=ProviderEms();

   bool _containsNonEnglishCharacters(String input) {
     RegExp _persianRegex = RegExp(r'^[\u0600-\u06FF\s]+$'); // محدوده کاراکترهای فارسی
     return _persianRegex.hasMatch(input);
   }

   Future RunAddP(BuildContext context)async{

     if(!Notifi.status)
       {
         showToast("ابتدا شیفت خود را فعال کنید",
             position: StyledToastPosition.top,
             context:context);
         return;
       }
     if(TextConName.text.isEmpty)
     {
       showToast("نام و نام خانوادگی را وارد کنید",
           position: StyledToastPosition.top,
           context:context);
       return;
     }

      if(!_containsNonEnglishCharacters(TextConName.text.toString()))
        {
          showToast("برای نام بیمار از کارکتر های انگلیسی استفاده نکنید",
              position: StyledToastPosition.top,
              context:context);
          return;
        }

     if(containsNumber(TextConName.text.toString()))
     {
       showToast("برای نام بیمار از اعداد استفاده نکنید",
           position: StyledToastPosition.top,
           context:context);
       return;
     }

     // var check=checkMeliCode(TextConCode.text.toString());
     // if(!check)
     // {
     //   ShowErrorMsg(context,'کدملی اشتباه است');
     //   return;
     // }

     Jalali date=Jalali.now();
     String formattedDate = '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
     // چاپ تاریخ جلالی با فرمت مورد نظر
     print('تاریخ جلالی فعلی: $formattedDate');
     ShowLoadingApp(context);

     var age=convertPersianNumbersToEnglish( TextConAge.text.toString());
     var  timestamp=DateTime.now().millisecondsSinceEpoch;


     var typeInput="2";

     if(widget.isAtend)
       {
         typeInput="3";
       }
     var Data=await ApiServiceEms.AddPatient(TextConName.text,formattedDate,TextConCode.text.toString(),age,Notifi.dropdownvalue=='مرد'?2:1,typeInput,context,timestamp);
     if(Data!=null)
     {
       if(Data.success)
       {
         // Ok Shode
         TextConAge.clear();
         TextConCode.clear();
         TextConName.clear();
         TextConGender.clear();
         Notifi.Refrsh();
         ShowSuccesMsg(context,'بیمار با موفقیت ثبت شد');
       }else{
         ShowErrorMsg(context, Data.message);
       }
     }
   }

   var TextConName=TextEditingController();

   var TextConCode=TextEditingController();

   var TextConAge=TextEditingController();

   var TextConGender=TextEditingController();

   Future   ChangShift(bool StatusNew,BuildContext context) async
   {

     ShowLoadingApp(context);
     // ignore: use_build_context_synchronously
     var Data= await ApiServiceReception.ChangeShiftStatus(context);

     if(Data!=null)
     {
       if(Data.success)
       {
         Notifi.setstatus(Data.data!.isOnline);
       }else{
         // ignore: use_build_context_synchronously
         ShowErrorMsg(context, Data.message);
       }
     }

     Navigator.pop(context);








   }

   Future ClearAllDate()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.clear();
     GoNextPageGameOver(context, SplashScreen());
   }

   Future GetInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if(prefs.getBool('isOnline')!=null)
       {
         status=prefs.getBool('isOnline')!;
         Notifi.setstatus(status);
       }

   }

   @override
  void initState() {
    super.initState();
    GetInfo();
  }

  @override
  Widget build(BuildContext context) {
    Notifi = Provider.of<ProviderEms>(context);
    return PatientRegistrationScreen(
      source: widget.isAtend
          ? PatientRegistrationSource.attending
          : PatientRegistrationSource.ems,
      shiftActive: Notifi.status,
      onChangeShift: Notifi.setstatus,
      notificationButton: const NotificationRegistrationButton(color: Color(0xff0c1b31), size: 24, icon: Icons.notifications_none_outlined),
      onEditProfile: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const screen_EditProfile())),
      onExit: () async {
        if (widget.isAtend) {
          Navigator.pop(context);
          return;
        }
        final confirmed = await ShowAllow(context, "آیا از حساب خود خارج میشوید ؟");
        if (confirmed && mounted) ClearAllDate();
      },
    );
  }
}

