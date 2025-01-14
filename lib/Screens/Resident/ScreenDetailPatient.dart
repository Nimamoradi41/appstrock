import 'dart:async';
import 'package:appstrock/Screens/Laboratory/ScreenFormLaboratory.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormBload724.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:appstrock/Screens/Resident/ScreenFormTimeInjection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/Model/ModelPatient.dart';
import 'ProviderResident/ProviderResidentDetaile.dart';
import 'ScreenFormImage724.dart';
import 'ScreenFormIs724.dart';
import 'ScreenFormIsNot724.dart';
import 'ScreenFormPreesBload724.dart';



class ScreenDetailPatient extends StatefulWidget {

  ScreenDetailPatient(this.patientItem,this.MainCtx);
  ModelPatient patientItem;
  BuildContext MainCtx;
  @override
  State<ScreenDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenDetailPatient> with SingleTickerProviderStateMixin{
  late var Notifi=ProviderResidentDetaile();

  // Future NeedToCT(BuildContext context)async{
  Future NeedToCT(BuildContext context)async{


    DateTime? TimeStart;
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceResident.NeedToCT(widget.patientItem.id.toString(),context);

    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.needToCT=true;
        Notifi.setItems(Notifi.patientItem);
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

      }
  Future NeedToMRI(BuildContext context)async{

    ShowLoadingApp(context);
    // Future.delayed(Duration(seconds: 3),(){
    //   widget.modelPatient.needToMRI=true;
    //   Notifi.setItems(widget.modelPatient);
    //   Navigator.pop(context);
    //   // ignore: use_build_context_synchronously
    //   ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
    // });

    // ignore: use_build_context_synchronously
    var Data= await ApiServiceResident.NeedToMRI(widget.patientItem.id.toString(),context);

    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.needToMRI=true;
        Notifi.setItems(Notifi.patientItem);
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }
  Future AddNIHS(List<Map<String, dynamic>> Str,int score)async{

    ShowLoadingApp(context);
    var Data= await ApiServiceResident.AddNihs(widget.patientItem.id.toString(),
        context,Str,score);

    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.nihsIsComplete=true;
        Notifi.patientItem.n_1_a=Str[0]['selected_answer'].toString();
        Notifi.patientItem.n_1_b=Str[1]['selected_answer'].toString();
        Notifi.patientItem.n_1_c=Str[2]['selected_answer'].toString();
        Notifi.patientItem.n_2=Str[3]['selected_answer'].toString();
        Notifi.patientItem.n_3=Str[4]['selected_answer'].toString();
        Notifi.patientItem.n_4=Str[5]['selected_answer'].toString();
        Notifi.patientItem.n_5_a=Str[6]['selected_answer'].toString();
        Notifi.patientItem.n_5_b=Str[7]['selected_answer'].toString();
        Notifi.patientItem.n_6_a=Str[8]['selected_answer'].toString();
        Notifi.patientItem.n_6_b=Str[9]['selected_answer'].toString();
        Notifi.patientItem.n_6_b=Str[9]['selected_answer'].toString();
        Notifi.patientItem.n_7=Str[10]['selected_answer'].toString();
        Notifi.patientItem.n_8=Str[11]['selected_answer'].toString();
        Notifi.patientItem.n_9=Str[12]['selected_answer'].toString();
        Notifi.patientItem.n_10=Str[13]['selected_answer'].toString();
        Notifi.patientItem.n_11=Str[14]['selected_answer'].toString();
        Notifi.patientItem.nihsSubscore=int.parse(score.toString());
        Notifi.setItems(Notifi.patientItem);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }


  }
  Future editNIHS(List<Map<String, dynamic>> Str,int score)async{

    ShowLoadingApp(context);
    var Data= await ApiServiceResident.editNihs(widget.patientItem.id.toString(),
        context,Str,score);



    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.nihsIsComplete=true;
        Notifi.patientItem.n_1_a=Str[0]['selected_answer'].toString();
        Notifi.patientItem.n_1_b=Str[1]['selected_answer'].toString();
        Notifi.patientItem.n_1_c=Str[2]['selected_answer'].toString();
        Notifi.patientItem.n_2=Str[3]['selected_answer'].toString();
        Notifi.patientItem.n_3=Str[4]['selected_answer'].toString();
        Notifi.patientItem.n_4=Str[5]['selected_answer'].toString();
        Notifi.patientItem.n_5_a=Str[6]['selected_answer'].toString();
        Notifi.patientItem.n_5_b=Str[7]['selected_answer'].toString();
        Notifi.patientItem.n_6_a=Str[8]['selected_answer'].toString();
        Notifi.patientItem.n_6_b=Str[9]['selected_answer'].toString();
        Notifi.patientItem.n_6_b=Str[9]['selected_answer'].toString();
        Notifi.patientItem.n_7=Str[10]['selected_answer'].toString();
        Notifi.patientItem.n_8=Str[11]['selected_answer'].toString();
        Notifi.patientItem.n_9=Str[12]['selected_answer'].toString();
        Notifi.patientItem.n_10=Str[13]['selected_answer'].toString();
        Notifi.patientItem.n_11=Str[14]['selected_answer'].toString();
        Notifi.patientItem.nihsSubscore=int.parse(score.toString());
        Notifi.setItems(Notifi.patientItem);
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }


  }
  Future IsNot724()async{





    var  timestamp=DateTime.now().millisecondsSinceEpoch;
    var Data= await ApiServiceResident.SetNot724(widget.patientItem.id.toString(),
        context,false,timestamp.toString());
    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.isNot724=true;
        Notifi.patientItem.is724IsComplete=true;
        Notifi.patientItem.isFinished=true;
        Notifi.patientItem.isNot724IsComplete=true;
        Notifi.setItems(Notifi.patientItem);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }
  Future AddResean(bool MisdiagnosisOfTriage,bool MisdiagnosisOfEms,bool OverTime)async{
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously

    var Data= await ApiServiceResident.ReasonsForIsNot724(
      widget.patientItem.id.toString(),
        context,MisdiagnosisOfTriage,MisdiagnosisOfEms,OverTime);
    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.isNot724=true;
        Notifi.patientItem.is724IsComplete=true;
        Notifi.setItems(Notifi.patientItem);
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Navigator.pop(context);
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }
  AddReasonNot724(){
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx){
      return  Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              margin: EdgeInsets.only(top: 16),
              child:   ScreenFormIsNot724((pa)
              async{
                AddResean(pa[0]['selected_answer']!,
                    pa[1]['selected_answer']!,
                    pa[2]['selected_answer']!);
              } ,   Notifi.patientItem.isNot724IsComplete!,
                  Notifi.patientItem.misdiagnosisOfTriage!,
                  Notifi.patientItem.misdiagnosisOfEms!,
                  Notifi.patientItem.overTime!
              )),
        ],
      );

    });
  }



  void _formatElapsedTime() {
    int hours = _elapsedTime.inHours;
    int minutes = _elapsedTime.inMinutes % 60;
    int seconds = _elapsedTime.inSeconds % 60;

    Notifi.setTimeEffect("${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  Duration _elapsedTime = Duration.zero;
  late DateTime TimeEffect;






Future  AddRequestIs724(bool IsUnkown,String TimeStart,String DateStart
    ,String TimeFssStart,String DateFSSStart,String TimeLKWStart,String DateLKWStart, String timestamp)async{


  ShowLoadingApp(context);
  // ignore: use_build_context_synchronously
  var Data= await ApiServiceResident.Set724(widget.patientItem.id.toString(),
  context,IsUnkown,TimeStart,DateStart,TimeFssStart,
      DateFSSStart,TimeLKWStart,DateLKWStart,true,timestamp);
  Navigator.pop(context);
  if(Data!=null)
  {
    if(Data.success)
    {
      Notifi.patientItem.is724IsComplete=true;
      Notifi.patientItem.isNot724=false;
      if(IsUnkown)
        {
          Notifi.patientItem.signsStartIsUnknown=true;
          Notifi.patientItem.fssTime=TimeFssStart;
          Notifi.patientItem.lkwTime=TimeLKWStart;
          Notifi.patientItem.fssDate=DateFSSStart;
          Notifi.patientItem.lkwDate=DateLKWStart;
        }else{
        Notifi.patientItem.signsStartIsUnknown=false;
        Notifi.patientItem.signsStartTime=TimeStart;
        Notifi.patientItem.signsStartDate=DateStart;
      }

      Notifi.setItems(Notifi.patientItem);


      // ignore: use_build_context_synchronously
      ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
    }else{
      // ignore: use_build_context_synchronously
      ShowErrorMsg(context, Data.message);
    }
  }
}
  Add724(){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx){
          return  Container(
              margin: EdgeInsets.only(top: 16),
              child:   ScreenFormIs724((p) async{
                var Know=p[0]['Know'];
                String Time='';
                String TimeFss='';
                String TimeLKW='';
                String Date='';
                String DateFSS='';
                String DateLKW='';
                String timestamp='';
                Navigator.pop(context);
                ShowLoadingApp(context);
                await Future.delayed(Duration(seconds: 2));
                if(Know=='false')
                  {
                      Time=p[1]['Time']!;
                      Date=p[2]['Date']!;
                      timestamp=p[3]['timestamp']!;
                      print(Time);
                      print(Date);
                      print(timestamp);
                      AddRequestIs724(false, Time, Date, '', '', '', '',timestamp);
                  }else{
                  TimeFss=p[3]['TimeFss']!;
                  TimeLKW=p[1]['TimeLKW']!;
                  DateFSS=p[4]['DateFss']!;
                  DateLKW=p[2]['DateLKW']!;
                  timestamp=p[5]['timestamp']!;

                  AddRequestIs724(true, '', '', TimeFss, DateFSS, TimeLKW, DateLKW,timestamp);





                }







                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
              }));

        });
  }
  late Timer _timer;
  late Timer _timer2;
  // var TimeEffect=0.0;

  // var TimeTaInjection=0.0;
  var TimeTaInjectionStr='0';
  var TimeEffectStr="0";
  var TimeAriveToHospital=0.0;
  var TimeAriveToHospitalStr="0";
  String    Convert_Time(String Hour,String Minute,String Seconds)
  {
    var temp_Hour="";
    var temp_Min="";
    var temp_Seconds="";
    if (Hour.length==1)
    {
      temp_Hour="0$Hour";
    }else{
      temp_Hour=Hour;
    }
    if (Minute.length==1)
    {
      temp_Min="0$Minute";
    }else{
      temp_Min=Minute;
    }

    if (Seconds.length==1)
    {
      temp_Seconds="0$Seconds";
    }else{
      temp_Seconds=Seconds;
    }
    return  ("$temp_Hour:$temp_Min:$temp_Seconds").toString();


  }
  void startTimerEffect() {
    const oneSec =   Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        // TimeEffect=TimeEffect+1;
        TimeAriveToHospital=TimeAriveToHospital+1;
        // TimeTaInjection=TimeTaInjection+1;
        // var date=Duration(seconds: TimeEffect.toInt());
        var date2=Duration(seconds: TimeAriveToHospital.toInt());
        // var date3=Duration(seconds: TimeTaInjection.toInt());
        // int hours = date.inSeconds ~/ 3600;
        // int minutes = (date.inSeconds % 3600) ~/ 60;
        // int remainingSeconds = date.inSeconds % 60;

        int hours2 = date2.inSeconds ~/ 3600;
        int minutes2 = (date2.inSeconds % 3600) ~/ 60;
        int remainingSeconds2 = date2.inSeconds % 60;

        // int hours3 = date3.inSeconds ~/ 3600;
        // int minutes3 = (date3.inSeconds % 3600) ~/ 60;
        // int remainingSeconds3 = date3.inSeconds % 60;

        // if(Notifi.patientItem.injectionTimeTS!=0)
        // {
        //   TimeTaInjectionStr =Convert_Time(hours3.toString(),minutes3.toString(),remainingSeconds3.toString());
        //   Notifi.setTimeInjection(TimeTaInjectionStr);
        // }

        if( Notifi.patientItem.signsStartTS!=0)
        {
          // TimeEffectStr =Convert_Time(hours.toString(),minutes.toString(),remainingSeconds.toString());

          var date=DateTime.fromMillisecondsSinceEpoch(widget.patientItem.signsStartTS!!);
          // var date=DateTime.fromMillisecondsSinceEpoch(1731018000000);

          _elapsedTime   = DateTime.now().difference(date);
          // _elapsedTime   = DateTime.fromMillisecondsSinceEpoch(1731011100000).difference(date);

          _formatElapsedTime();
        }

        TimeAriveToHospitalStr =Convert_Time(hours2.toString(),minutes2.toString(),remainingSeconds2.toString());


        Notifi.setTimeAriveToHospital(TimeAriveToHospitalStr);

      },
    );
  }
  void startTimerAriveToHospital() {
    const oneSec =   Duration(seconds: 1);
    _timer2 = Timer.periodic(
      oneSec,
          (Timer timer) {
        TimeAriveToHospital=TimeAriveToHospital+1;
        var date=Duration(seconds: TimeAriveToHospital.toInt());
        int hours = date.inSeconds ~/ 3600;
        int minutes = (date.inSeconds % 3600) ~/ 60;
        int remainingSeconds = date.inSeconds % 60;
        TimeAriveToHospitalStr =Convert_Time(hours.toString(),minutes.toString(),remainingSeconds.toString());
        Notifi.setTimeAriveToHospital(TimeAriveToHospitalStr);
      },
    );
  }
  @override
  void dispose() {
    _controller.dispose(); // رها کردن منابع انیمیشن کنترلر
    _timer.cancel();
    super.dispose();

  }
  late AnimationController _controller;
  late Animation<Color?> _colorAnimationRed;
  late Animation<Color?> _colorAnimationGreen;
  Future RunPressBload(String Blod1,String Blod2)async{

    ShowLoadingApp(context);

    var Data= await ApiServiceResident.PressBlod(widget.patientItem.id.toString()
        ,context,Blod1,Blod2);

    Navigator.pop(context);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Notifi.patientItem.bloodPressure1= int.parse(Blod1);
        Notifi.patientItem.bloodPressure2=int.parse(Blod2);
        Notifi.setItems(Notifi.patientItem);
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

  }
  Future AddLab(List<Map<String, dynamic>> Str)async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.AddLab(widget.patientItem.id.toString(),context,Str);
    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.labIsComplete=true;
        Notifi.patientItem.bun=Str[0]['selected_answer'].toString();
        Notifi.patientItem.cr=Str[1]['selected_answer'].toString();
        Notifi.patientItem.plt=Str[2]['selected_answer'].toString();
        Notifi.patientItem.pt=Str[3]['selected_answer'].toString();
        Notifi.patientItem.inr=Str[4]['selected_answer'].toString();
        Notifi.patientItem.hb=Str[5]['selected_answer'].toString();
        Notifi.patientItem.wbc=Str[6]['selected_answer'].toString();
        Notifi.patientItem.trop=Str[7]['selected_answer'].toString()=='0'?false:true;



        Notifi.setItems(Notifi.patientItem);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Navigator.pop(context);

      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }
  Future editLab(List<Map<String, dynamic>> Str)async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.editLab(widget.patientItem.id.toString(),context,Str);
    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.patientItem.labIsComplete=true;
        Notifi.patientItem.bun=Str[0]['selected_answer'].toString();
        Notifi.patientItem.cr=Str[1]['selected_answer'].toString();
        Notifi.patientItem.plt=Str[2]['selected_answer'].toString();
        Notifi.patientItem.pt=Str[3]['selected_answer'].toString();
        Notifi.patientItem.inr=Str[4]['selected_answer'].toString();
        Notifi.patientItem.hb=Str[5]['selected_answer'].toString();
        Notifi.patientItem.wbc=Str[6]['selected_answer'].toString();
        Notifi.patientItem.trop=Str[7]['selected_answer'].toString()=='0'?false:true;
        Notifi.setItems(Notifi.patientItem);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Navigator.pop(context);

      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  var isLoading=true;

  @override
  void initState() {
    super.initState();
    // تنظیم کردن یک انیمیشن کنترلر با مدت زمان ۱ ثانیه
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    // تنظیم کردن انیمیشن برای تغییر رنگ جراغ
    _colorAnimationRed = ColorTween(
      begin: Colors.red,
      end: Colors.black12,
    ).animate(_controller);

    _colorAnimationGreen = ColorTween(
      begin: Colors.green,
      end: Colors.black12,
    ).animate(_controller);

    DateTime now = new DateTime.now();
    // if(widget.patientItem.signsStartTS!=0  &&  !widget.patientItem.isFinished!)
    if( !widget.patientItem.isFinished!)
    {


      TimeAriveToHospital=((now.millisecondsSinceEpoch/1000)-(widget.patientItem.insertTimeTS!/1000));

      // if(widget.patientItem.injectionTimeTS!=0)
      // {
      //   TimeTaInjection=((now.millisecondsSinceEpoch/1000)-(widget.patientItem.injectionTimeTS!/1000));
      // }

      // if( widget.patientItem.signsStartTS!=0)
      // {
      //   TimeEffect=((now.millisecondsSinceEpoch/1000)-(widget.patientItem.signsStartTS!/1000));
      // }

      if( Notifi.patientItem.signsStartTS!=0)
      {
        // TimeEffectStr =Convert_Time(hours.toString(),minutes.toString(),remainingSeconds.toString());
        _formatElapsedTime();
        // Notifi.setTimeEffect(TimeEffectStr);
      }


      startTimerEffect();
    }


    getInfoOfPatient();

  }
  Future RunBload(String Blod)async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.Blod(widget.patientItem.id.toString(),context,Blod);

    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Notifi.patientItem.bs= int.parse(Blod);
        Notifi.setItems(Notifi.patientItem);
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }


  }
  Future  RequestAddTimeInjection(String Time)async{
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var  timestamp=DateTime.now().millisecondsSinceEpoch;
    var Data= await ApiServiceResident.TimeOfInjection(widget.patientItem.id.toString(),context,Time,timestamp);
    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {

        Notifi.patientItem.timeOfInjection=Time;
        Notifi.setItems(Notifi.patientItem);
        // ignore: use_build_context_synchronously
        getInfoOfPatient();
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

  }

  Future uploadImage(String idPa)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String UserId='';

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }
    final String url = 'https://web.appstrok.ir/UploadFile?UserId=$UserId&PatientId=$idPa';

    // const url = 'https://web.appstrok.ir/UploadFile?UserId=$UserId&PatientId='+86;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  AddTimeInjection(){
    showModalBottomSheet(context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
        ),
        builder: (ctx){
          return  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  margin: EdgeInsets.only(top: 16),
                  child:   ScreenFormTimeInjection((pa)
                  async{
                    RequestAddTimeInjection(pa[0]['selected_answer'].toString());

                  })),
            ],
          );

        });
  }


   Future getInfoOfPatient()async{
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatient(formattedDate,context);


    print(Data.toString());
    if(Data!=null)
    {
      if(Data.success)
      {
        var finded=Data.data.firstWhere((element) => element.id==widget.patientItem.id);

        Notifi.setItems(finded);
        isLoading=false;
         print(Notifi.patientItem.dtn);
        print(Notifi.patientItem.otn);
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderResidentDetaile>(context);
    double wid=MediaQuery.of(context).size.width;
    double hei=MediaQuery.of(context).size.height;
    wid=wid>600?600:wid;
    return

      SafeArea(
      child:
      Scaffold(
        body: Center(
          child:
          isLoading ?
          const CircularProgressIndicator() :
          Container(
            width: wid,
            height: double.infinity,
            color: BackGroundApp,
            child: Stack(
              children: [
                Container(
                  width: wid,
                  height: wid*0.25,
                  color: ColorApp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:   [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                getInfoOfPatient();
                              },
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.refresh,color: Colors.white,size: 30,),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Notifi.patientItem!.is724IsComplete! && !Notifi.patientItem!.isNot724?
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(width: 4,),
                                          AnimatedBuilder(
                                            animation:  Notifi.patientItem!.seenByAttend! ?

                                            _colorAnimationGreen:
                                            _colorAnimationRed
                                            ,
                                            builder: (context, child) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color:  Notifi.patientItem!.seenByAttend! ? _colorAnimationGreen.value:_colorAnimationRed.value,
                                                    shape: BoxShape.circle
                                                ),
                                                width: 10,
                                                height: 10,

                                              );
                                            },
                                          ),
                                          SizedBox(width: 8,),
                                          TextApp(  Notifi.patientItem!.seenByAttend!?
                                          'دکتر متخصص مشاهده کرده است'
                                              : 'دکتر متخصص مشاهده نکرده است', 10,
                                              Notifi.patientItem!.seenByAttend!? Colors.green :
                                              Colors.red, true),
                                          SizedBox(width: 4,)
                                        ],
                                      ),
                                    ),
                                  ):
                                  Container() ,
                                  const Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Text(
                                        'اطلاعات بیمار',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16
                                        ),
                                      )

                                    // TextApp('فوریت های پزشکی', 16, Colors.white, true),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: wid*0.14,
                  right: 16,
                  left: 16,
                  child: Container(
                    width: wid*0.85,
                    height: hei*0.88,
                    child: Column(
                      children: [
                        Container(
                          decoration: MainDecoration,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('کدملی', 12, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(Notifi.patientItem.nationalCode.isEmpty  ? 'نامشخص':Notifi.patientItem.nationalCode, 14, ColorTextbody, true)
                                      ],
                                    )),
                                    SizedBox(width: 8,),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('نام و نام خانوادگی', 12, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(Notifi.patientItem.fullName.isEmpty  ? 'نامشخص':Notifi.patientItem.fullName, 14, ColorTextbody, true)
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('سن', 12, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(Notifi.patientItem.age.isEmpty  ? 'نامشخص':Notifi.patientItem.age, 14, ColorTextbody, true)
                                      ],
                                    )),
                                    SizedBox(width: 8,),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(width: 8,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('جنسیت', 12, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(Notifi.patientItem.gender.isEmpty  ? 'نامشخص':Notifi.patientItem.gender, 14, ColorTextbody, true)
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 8,),
                        Expanded(
                          child: Container(
                            decoration: MainDecoration,
                            child: Column(
                              children: [
                                 Expanded(
                                   child: SingleChildScrollView(
                                     child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(Notifi.patientItem!.timeOfAddToSystem.isEmpty  ?
                                              'نامشخص':Notifi.patientItem!.timeOfAddToSystem, 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان ثبت در سیستم', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(Notifi.patientItem.dateOfAddToSystem == null ?
                                              'نامشخص' : Notifi.patientItem.dateOfAddToSystem!,
                                                  14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  تاریخ ثبت در سیستم', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Notifi.patientItem.signsStartTime!.isNotEmpty?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp("${Notifi.patientItem.signsStartTime} "
                                                  "${Notifi.patientItem.signsStartDate} ", 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان و تاریخ شروع علائم ', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),

                                        Notifi.patientItem.dateFinishShamsi!.isNotEmpty?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp("${Notifi.patientItem.dateFinishShamsi} "
                                                  "${Notifi.patientItem.timeFinish} ", 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان و تاریخ پایان کار ', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),

                                        Notifi.patientItem.needToCT||Notifi.patientItem.needToMRI?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(
                                                  Notifi.patientItem.needToCT?
                                                      'CT':
                                                      'MRI'
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  وضعیت', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(
                                                  !Notifi.patientItem.nihsIsComplete!?
                                                  'تکمیل نشده است':
                                                  Notifi.patientItem.nihsSubscore.toString()


                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فرم NIHSS', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Notifi.patientItem.injectionType!=0?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(  Notifi.patientItem.injectionType==1?
                                              'تزریق بشود':
                                              'تزریق نشود'
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  وضعیت تزریق', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),

                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if(Notifi.patientItem.is724IsComplete==true)
                                                    {
                                                      GoNextPage(context,

                                                          ScreenFormLaboratory((p0){
                                                        Navigator.pop(context);
                                                        if(Notifi.patientItem!.labIsComplete!!)
                                                          {
                                                            editLab(p0);
                                                          }else{
                                                          AddLab(p0);
                                                        }

                                                      },Notifi.patientItem.labIsComplete!!,
                                                          Notifi.patientItem.bun.toString(),
                                                          Notifi.patientItem.cr.toString(),
                                                          Notifi.patientItem.plt.toString(),
                                                          Notifi.patientItem.pt.toString(),
                                                          Notifi.patientItem.inr.toString(),
                                                          Notifi.patientItem.trop.toString(),
                                                          Notifi.patientItem.hb.toString(),
                                                          Notifi.patientItem.wbc.toString(),
                                                          false
                                                      ));
                                                    }

                                                },
                                                child: TextApp(Notifi.patientItem.labIsComplete == null  ?'تکمیل نشده است' :
                                                Notifi.patientItem.labIsComplete! ?
                                                'تکمیل شده است':
                                                'تکمیل نشده است'

                                                    , 14, ColorTextbody, true),
                                              ),
                                              Expanded(child:
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فرم آزمایشگاه', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Notifi.patientItem.labIsComplete!?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(
                                                  "${Notifi.patientItem.labInsertDate} - "
                                                      "${Notifi.patientItem.labInsertTime}"
                                                  , 14, ColorTextbody, true),
                                              Expanded(child:
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' : زمان ثبت  فرم آزمایشگاه', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),
                                        InkWell(
                                          onTap: (){
                                           if(Notifi.patientItem.timeOfInjection!.isEmpty&&Notifi.patientItem.is724IsComplete!)
                                             {
                                               AddTimeInjection();
                                             }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                            child: Row(
                                              children: [
                                                TextApp(Notifi.patientItem.timeOfInjection!.isEmpty  ?'تکمیل نشده است' :
                                                Notifi.patientItem.timeOfInjection.toString()
                                                    , 14, ColorTextbody, true),
                                                Expanded(child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: TextApp(' :  زمان تزریق', 12, ColorTitleText, false))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if( Notifi.patientItem.is724IsComplete==true&&
                                                      Notifi.patientItem.bs==0
                                                  ){
                                                    GoNextPage(context,  ScreenFormBload724(
                                                        Notifi.patientItem.id.toString(),
                                                        false,(p0){
                                                           var item= p0[0]['bload'].toString();
                                                           RunBload(item);
                                                        }));
                                                  }
                                                },
                                                child: TextApp(Notifi.patientItem.bs == 0  ?'تکمیل نشده است' :
                                                Notifi.patientItem.bs.toString()
                                                    , 14, ColorTextbody, true),
                                              ),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  قند خون', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if( Notifi.patientItem.is724IsComplete==true&&
                                                      Notifi.patientItem.bloodPressure1==0
                                                  ){
                                                    GoNextPage(context,ScreenFormPreesBload724(
                                                        Notifi.patientItem.id.toString(),false,(p0){
                                                          print(p0);
                                                      var bload1= p0[0]['bload1'].toString();
                                                      var bload2= p0[0]['bload2'].toString();

                                                      RunPressBload(bload1,bload2);
                                                    }));
                                                  }
                                                },
                                                child: TextApp( Notifi.patientItem.bloodPressure1 == 0  ?'تکمیل نشده است' :
                                                "${Notifi.patientItem.bloodPressure1}/${
                                                    Notifi.patientItem.bloodPressure2}"
                                                    , 14, ColorTextbody, true),
                                              ),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فشار خون', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),



                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(Notifi.oldTime2
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  تایمر بر اساس زمان ثبت در سیستم', 12,
                                                      ColorTitleText, false))),
                                            ],
                                          ),
                                        ),

                                        Notifi.patientItem.otn.isEmpty?
                                        Container():
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(Notifi.patientItem.otn
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  OTN', 12,
                                                      ColorTitleText, false))),
                                            ],
                                          ),
                                        ),

                                        Notifi.patientItem.dtn.isNotEmpty?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(Notifi.patientItem.dtn
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  DTN', 12,
                                                      ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),

                                        Notifi.patientItem.is724IsComplete!
                                         // && !Notifi.patientItem.isNot724
                                            && !Notifi.patientItem.isFinished!  ?
                                         Column(
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                               child: Row(
                                                 children: [
                                                   TextApp(Notifi.oldTime
                                                       , 14, ColorTextbody, true),
                                                   Expanded(child: Align(
                                                       alignment: Alignment.centerRight,
                                                       child: TextApp(' :  تایمر بر اساس زمان شروع علائم', 12,
                                                           ColorTitleText, false))),
                                                 ],
                                               ),
                                             ),







                                           ],
                                         ):Container()
                                      ],
                                     ),
                                   ),
                                 ),


                                !Notifi.patientItem.is724IsComplete! && !Notifi.patientItem.isNot724!  ?
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            IsNot724();
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(BtnColorgreen),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text('کد 724 نیست',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    )),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ElevatedButton(onPressed: (){
                                        Add724();
                                      },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(BtnColorred),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text('کد 724 است',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ))
                                  ],
                                ):Container(),
                                const SizedBox(height: 8,),
                                Container(),

                                Notifi.patientItem.is724IsComplete! &&
                                    !Notifi.patientItem.isNot724!  ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                       GoNextPage(context, ScreenFormNIHS((p0,s) {
                                         Navigator.pop(context);

                                         if(Notifi.patientItem!.nihsIsComplete!!)
                                           {
                                             editNIHS(p0,s);
                                           }else{
                                           AddNIHS(p0,s);
                                         }

                                       },Notifi.patientItem.nihsIsComplete!,
                                         Notifi.patientItem.n_1_a!,
                                         Notifi.patientItem.n_1_b!,
                                         Notifi.patientItem.n_1_c!,
                                         Notifi.patientItem.n_2!,
                                         Notifi.patientItem.n_3!,
                                         Notifi.patientItem.n_4!,
                                         Notifi.patientItem.n_5_a!,
                                         Notifi.patientItem.n_5_b!,
                                         Notifi.patientItem.n_6_a!,
                                         Notifi.patientItem.n_6_b!,
                                         Notifi.patientItem.n_7!,
                                         Notifi.patientItem.n_8!,
                                         Notifi.patientItem.n_9!,
                                         Notifi.patientItem.n_10!,
                                         Notifi.patientItem.n_11!,
                                           false,
                                         Notifi.patientItem.nihsSubscore!!,

                                       ));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: Notifi.patientItem.nihsIsComplete==true?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              Notifi.patientItem.nihsIsComplete ==true ?
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ):
                                              Notifi.patientItem.nihsIsComplete==true ?
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side:  const BorderSide(color: ColorApp,width: 2)
                                              ):
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              )
                                          )
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text( Notifi.patientItem.nihsIsComplete ==false?
                                        'NIHSS':
                                        'NIHSS',
                                          style: TextStyle(
                                              color:
                                              Notifi.patientItem.nihsIsComplete==false ?Colors.white:
                                              ColorApp ,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),


                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: () async{
                                        uploadImage(Notifi.patientItem.id.toString());
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              )
                                          )
                                      ),
                                      child:const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(   'آپلود عکس',

                                          style: TextStyle(
                                              color:
                                        Colors.white
                                               ,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ),

                                Notifi.patientItem.is724IsComplete!
                                    && Notifi.patientItem.isNot724!  ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        AddReasonNot724();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: !Notifi.patientItem.isNot724IsComplete! ?
                                          MaterialStateProperty.all(ColorApp):
                                          MaterialStateProperty.all(Colors.white),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              !Notifi.patientItem.isNot724IsComplete! ?
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ):
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side:  const BorderSide(color: ColorApp,width: 2)
                                              )
                                          )
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text( Notifi.patientItem.isNot724IsComplete ==null?
                                        'تکمیل دلایل رد کد 724':
                                        Notifi.patientItem.isNot724IsComplete!
                                            ?'نمایش دلایل رد کد 724':'تکمیل دلایل رد کد 724',
                                          style: TextStyle(
                                              color:
                                              Notifi.patientItem.isNot724IsComplete==null ?Colors.white:
                                              Notifi.patientItem.isNot724IsComplete!?
                                              ColorApp : Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),
                                Notifi.patientItem.is724IsComplete!
                                    && !Notifi.patientItem.isNot724!?
                                Row(
                                  children: [


                                  ],
                                ):Container(),
                                SizedBox(height: 16,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}


