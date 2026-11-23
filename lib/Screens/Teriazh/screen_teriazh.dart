import 'package:flutter/material.dart';
import '../PatientRegistration/model/patient_registration.dart';
import '../PatientRegistration/ui/patient_registration_screen.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../Ems/ApiServiceEms.dart';
import '../Reception/ApiServiceReception.dart';
import '../SplashScreen.dart';
import 'ProviderTeraizh.dart';
import 'notification_registration.dart';

class Screen_Teriazh extends StatefulWidget {


  @override
  State<Screen_Teriazh> createState() => _Screen_TeriazhState();
}

class _Screen_TeriazhState extends State<Screen_Teriazh> {
  bool _registeringNotifications = false;

  Future<void> _enableNotifications() async {
    if (_registeringNotifications) return;
    setState(() => _registeringNotifications = true);
    try {
      await registerNotificationToken();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اعلان‌ها با موفقیت فعال شدند')),
      );
    } catch (error) {
      if (!mounted) return;
      final message = error is StateError
          ? error.message.toString()
          : 'فعال‌سازی اعلان‌ها ناموفق بود؛ دوباره تلاش کنید';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } finally {
      if (mounted) setState(() => _registeringNotifications = false);
    }
  }

  bool status=false;

  var items = [
    'مرد',
    'زن',
  ];

  String dropdownvalue = 'مرد';


  Future   ChangShift(bool StatusNew,BuildContext context) async
  {


    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ChangeShiftStatus(context);
    print(Data.toJson());

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



  bool _containsNonEnglishCharacters(String input) {
    // Define a regular expression for English letters
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
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2,'0')}';
    // چاپ تاریخ جلالی با فرمت مورد نظر
    print('تاریخ جلالی فعلی: $formattedDate');
    ShowLoadingApp(context);
    var age=convertPersianNumbersToEnglish( TextConAge.text.toString());
    var  timestamp=DateTime.now().millisecondsSinceEpoch;
    var Data=await ApiServiceEms.AddPatient(TextConName.text,formattedDate,TextConCode.text.toString(),
        age,dropdownvalue=='مرد'?2:1,"1",context,timestamp);

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




  late var Notifi=ProviderTeraizh();

  var TextConName=TextEditingController();

  var TextConCode=TextEditingController();

  var TextConAge=TextEditingController();

  var TextConGender=TextEditingController();

  Future GetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isOnline')!=null)
    {
      status=prefs.getBool('isOnline')!;
      Notifi.setstatus(status);
    }
  }

  Future ClearAllDate()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    GoNextPageGameOver(context, SplashScreen());
  }
  @override
  void initState() {
    super.initState();
    GetInfo();
    syncNotificationTokenIfAllowed().catchError((Object error) {
      debugPrint('Notification token synchronization failed: $error');
    });
  }
  @override
  Widget build(BuildContext context) {
    Notifi = Provider.of<ProviderTeraizh>(context);
    return PatientRegistrationScreen(
      source: PatientRegistrationSource.triage,
      shiftActive: Notifi.status,
      onChangeShift: (value) => ChangShift(value, context),
      notificationButton: IconButton(
        tooltip: 'فعال‌سازی اعلان‌ها',
        onPressed: _registeringNotifications ? null : _enableNotifications,
        icon: _registeringNotifications
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.notifications_active_outlined),
      ),
      onExit: () async {
        final confirmed = await ShowAllow(context, "آیا از حساب خود خارج میشوید ؟");
        if (confirmed && mounted) ClearAllDate();
      },
    );
  }
}

