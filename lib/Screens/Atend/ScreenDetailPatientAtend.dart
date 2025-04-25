import 'dart:async';

import 'package:appstrock/Screens/Atend/ScreenListImages.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../SignalRService.dart';
import '../../Widgets/TextApp.dart';
import '../../components/BoxInformation.dart';
import '../Laboratory/ScreenFormLaboratory.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/Model/ModelPatient.dart';
import '../Resident/ProviderResident/ProviderTimers.dart';
import '../Resident/ScreenFormBload724.dart';
import '../Resident/ScreenFormPreesBload724.dart';
import '../Resident/ScreenFormReasonInjection.dart';
import 'ProviderAtend/ProviderAtendDetaile.dart';




class ScreenDetailPatientAtend extends StatefulWidget {
  ScreenDetailPatientAtend(this.patientItem,this.MainCtx);
  ModelPatient patientItem;
  BuildContext MainCtx;
  @override
  State<ScreenDetailPatientAtend> createState() => _ScreenDetailPatientState();
}
class _ScreenDetailPatientState extends State<ScreenDetailPatientAtend> with WidgetsBindingObserver {


  Future NeedToCT(BuildContext context)async{


    DateTime? TimeStart;
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceResident.NeedToCT(widget.patientItem.id.toString(),context);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();

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
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }
  String    Convert_Time(String Hour,String Minute,String Seconds)
  {
    var temp_Hour="";
    var temp_Min="";
    var temp_Seconds="";
    if (Hour.length==1)
    {
      temp_Hour="0"+Hour;
    }else{
      temp_Hour=Hour;
    }
    if (Minute.length==1)
    {
      temp_Min="0"+Minute;
    }else{
      temp_Min=Minute;
    }

    if (Seconds.length==1)
    {
      temp_Seconds="0"+Seconds;
    }else{
      temp_Seconds=Seconds;
    }
    return  ("$temp_Hour:$temp_Min:$temp_Seconds").toString();


  }
  Future editNIHS(List<Map<String, dynamic>> Str,int score)async{

    ShowLoadingApp(context);
    var Data= await ApiServiceResident.editNihs(widget.patientItem.id.toString(),
        context,Str,score);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
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
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }


  }

  Future   seenByAtend(String id,BuildContext context) async
  {
    ShowLoadingApp(context);
    var Data= await ApiServiceReception.SeenByAtend(context,widget.patientItem.id.toString());
    print(Data.toJson());

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

    Navigator.pop(context);

  }
  Future   setInjectionTrue(String id,BuildContext context) async
  {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.SetInjectionStatus(context,widget.patientItem.id.toString(),true);
    print(Data.toJson());

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

    Navigator.pop(context);
  }


  Future   setInjectionReason(String id,BuildContext context,List<Map<String, dynamic>> Str) async
  {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.SetInjectionReason(context,widget.patientItem.id.toString(),Str);
    print(Data.toJson());

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

    Navigator.pop(context);
  }
  Future   setInjectionFalse(String id,BuildContext context) async
  {
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.SetInjectionStatus(context,widget.patientItem.id.toString(),false);
    print(Data.toJson());

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

    Navigator.pop(context);
  }

  void _formatElapsedTime() {
    int hours = _elapsedTime.inHours;
    int minutes = _elapsedTime.inMinutes % 60;
    int seconds = _elapsedTime.inSeconds % 60;
    providerTimer.updateTimerSymptomOnset(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  Duration _elapsedTime = Duration.zero;

  late var Notifi=ProviderAtendDetaile();
  // var TimeEffect=0.0;
  var TimeTaInjection=0.0;
  var TimeTaInjectionStr='0';
  var TimeEffectStr="0";
  var TimeAriveToHospital=0.0;
  var TimeAriveToHospitalStr="0";
  late Timer _timer;
  double FinalTime=0;
  double FinalTime2=0;
  Duration _elapsedTimeFss = Duration.zero;
   late DateTime TimeEffect;

  void _formatElapsedTimeFss() {
    int hours = _elapsedTimeFss.inHours;
    int minutes = _elapsedTimeFss.inMinutes % 60;
    int seconds = _elapsedTimeFss.inSeconds % 60;

    providerTimer.updateTimerSymptomRecognition(
        "${hours.abs()}:${minutes.abs()}:${seconds.abs()}");
  }

  void startTimer() {
    const oneSec =   Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        // TimeEffect=TimeEffect+1;
        TimeAriveToHospital=TimeAriveToHospital+1;

        // var date=Duration(seconds: TimeEffect.toInt());
        var date2=Duration(seconds: TimeAriveToHospital.toInt());

        int hours2 = date2.inSeconds ~/ 3600;
        int minutes2 = (date2.inSeconds % 3600) ~/ 60;
        int remainingSeconds2 = date2.inSeconds % 60;


        if( Notifi.patientItem.signsStartTS!=0)
        {
          var date=DateTime.fromMillisecondsSinceEpoch(widget.patientItem.signsStartTS!!);
          _elapsedTime   = DateTime.now().difference(date);
          _formatElapsedTime();
        }

        if(Notifi.patientItem.signsStartTSFSS!=0)
        {
          var date=DateTime.fromMillisecondsSinceEpoch(Notifi.patientItem.signsStartTSFSS!!);

          _elapsedTimeFss   = DateTime.now().difference(date);

          _formatElapsedTimeFss();
        }

        TimeAriveToHospitalStr =Convert_Time(hours2.toString(),minutes2.toString(),remainingSeconds2.toString());

        providerTimer.updateTimerArriveToHospital(TimeAriveToHospitalStr);

      },
    );
  }

  AddReasonInjection(){
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
                  child:   ScreenFormReasonInjection((pa)
                  async{
                    // AddResean(pa[0]['selected_answer']!,
                    //     pa[1]['selected_answer']!,
                    //     pa[2]['selected_answer']!);
                  },Notifi.patientItem.notInjectingIsComplete!,
                      Notifi.patientItem.c1!,
                      Notifi.patientItem.c2!,
                      Notifi.patientItem.c3!,
                      Notifi.patientItem.c4!,
                      Notifi.patientItem.c5!,
                      Notifi.patientItem.c6!,
                      Notifi.patientItem.c7!,
                      Notifi.patientItem.c8!,
                      Notifi.patientItem.c9!,
                      Notifi.patientItem.c10!,
                      Notifi.patientItem.c11!,
                      Notifi.patientItem.c12!,
                      Notifi.patientItem.c13!,
                      Notifi.patientItem.c14!,
                      Notifi.patientItem.c15!,
                      Notifi.patientItem.c16!,
                      Notifi.patientItem.c17!,
                      Notifi.patientItem.c18!,
                      Notifi.patientItem.c19!,
                      Notifi.patientItem.c20!,
                      Notifi.patientItem.c21!,
                      Notifi.patientItem.c22!
                  )),
            ],
          );

        });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    SignalRService().isPageActive = false;
    SignalRService().disconnect();

    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!SignalRService().isPageActive)
      return; // ❗ اگه صفحه بسته شده، هیچ کاری نکن

    if (state == AppLifecycleState.resumed) {
      print('صفحه برگشته به حالت فعال');
      SignalRService().initConnection();
    } else if (state == AppLifecycleState.paused) {
      print('صفحه رفته بک‌گراند');
      SignalRService().disconnect();
    }
  }


  late ProviderTimers providerTimer;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    DateTime now = new DateTime.now();

    providerTimer = Provider.of<ProviderTimers>(context, listen: false);
    Notifi = Provider.of<ProviderAtendDetaile>(context, listen: false);

    if( !widget.patientItem.isFinished!)
    {
      TimeAriveToHospital=((now.millisecondsSinceEpoch/1000)-(widget.patientItem.insertTimeTS!/1000));

      if(widget.patientItem.injectionTimeTS!=0)
      {
        TimeTaInjection=((now.millisecondsSinceEpoch/1000)-(widget.patientItem.injectionTimeTS!/1000));
      }

      if( widget.patientItem.signsStartTS!=0)
      {
        _formatElapsedTime();
      }


      startTimer();
    }

    getInfoOfPatient();


    // اتصال اولیه
    SignalRService().initConnection();

    // گوش دادن به پیام‌ها
    SignalRService().messageStream.listen((message) {
      getInfoOfPatient();
    });

  }

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
        getInfoOfPatient();
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }

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
        getInfoOfPatient();
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }


  }

  Future reset()async{
    ShowLoadingApp(context);
    var Data= await ApiServiceResident.reset(widget.patientItem.id.toString(),context);

    Navigator.pop(context);

    if(Data!=null)
    {
      if(Data.success)
      {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        Navigator.pop(context);
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }


  }

  bool isLoading=true;

  Future getInfoOfPatient()async{
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatientLab(formattedDate,context);


    if(Data!=null)
    {
      if(Data.success)
      {

        var finded=Data.data.firstWhere((element) => element.id==widget.patientItem.id);
        Notifi.setItems(finded);
        isLoading = false;
        setState(() {});

        if (Notifi.patientItem.signsStartTSFSS != 0) {
          _formatElapsedTimeFss();
        }

        if (Notifi.patientItem.signsStartTS != 0) {
          _formatElapsedTime();
        }

        Notifi.setLoading(false);

        if (!Notifi.patientItem.isFinished!) {
          startTimer();
        } else {
          if (_timer != null) {
            _timer!.cancel();
          }
        }

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
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();

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
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        getInfoOfPatient();
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    double hei=MediaQuery.of(context).size.height;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child:
          isLoading?
          const CircularProgressIndicator():
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
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 16,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                getInfoOfPatient();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.refresh,color: Colors.white,size: 30,),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                getInfoOfPatient();
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.settings_backup_restore,color: Colors.white,size: 30,),
                              ),
                            ),
                            !Notifi.patientItem.seenByAttend!!?
                              InkWell(
                              onTap: (){
                               seenByAtend(Notifi.patientItem.id.toString(), context);
                              },
                              child:   Padding(
                                padding: EdgeInsets.all(16.0),
                                child:  Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.remove_red_eye,color: Colors.black,),
                                  ),
                                )
                              ),
                            ):Container(),
                              const Expanded(child:
                              Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: Text(
                                      'اطلاعات بیمار',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12
                                      ),
                                    )

                                  // TextApp('فوریت های پزشکی', 16, Colors.white, true),
                                ),
                              ],
                            )),
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
                                padding: const EdgeInsets.only(right: 8.0,left: 8,top: 8),
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('کدملی', 10, ColorTitleText, false),
                                        SizedBox(height: 4,),
                                        TextApp(Notifi.patientItem.nationalCode.isEmpty  ? 'نامشخص':Notifi.patientItem.nationalCode, 12, ColorTextbody, true)
                                      ],
                                    )),
                                    SizedBox(width: 4,),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(width: 4,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('نام و نام خانوادگی', 10, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(Notifi.patientItem.fullName.isEmpty  ? 'نامشخص':Notifi.patientItem.fullName, 12, ColorTextbody, true)
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('سن', 12, ColorTitleText, false),
                                        SizedBox(height: 4,),
                                        TextApp(Notifi.patientItem.age.isEmpty  ? 'نامشخص':Notifi.patientItem.age, 14, ColorTextbody, true)
                                      ],
                                    )),
                                    SizedBox(width: 4,),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(width: 4,),
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
                        const SizedBox(height: 8,),
                        Expanded(
                          child: Container(
                            decoration: MainDecoration,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        BoxInformation(
                                            value: Notifi.patientItem.timeOfAddToSystem.isEmpty  ?
                                            'نامشخص':Notifi.patientItem.timeOfAddToSystem, title: ' :  زمان ثبت در سیستم'
                                        ),

                                        Notifi.patientItem.isFinished==false? Consumer<ProviderTimers>(
                                          builder: (context,
                                              provider, child) {
                                            return BoxInformation(
                                                value: provider
                                                    .timerArriveToHospital,
                                                title:
                                                ' :  تایمر بر اساس زمان ثبت در سیستم');
                                          },
                                        )
                                            : Container(),

                                        Notifi.patientItem.is724IsComplete!
                                            && !Notifi.patientItem.isFinished! &&
                                            Notifi.patientItem.signsStartTime!.isNotEmpty &&
                                            Notifi.patientItem.signsStartTSFSS==0?
                                        Consumer<ProviderTimers>(
                                          builder: (context,
                                              provider, child) {
                                            return Column(
                                              children: [
                                                BoxInformation(
                                                    value: provider
                                                        .timerTimerSymptomOnset,
                                                    title:
                                                    ' :  تایمر بر اساس زمان شروع علائم'),
                                              ],
                                            );
                                          },
                                        ) : Container(),

                                        Notifi.patientItem.is724IsComplete!
                                            && !Notifi.patientItem.isFinished! && Notifi.patientItem.signsStartTSFSS!=0  ?
                                        Consumer<ProviderTimers>(
                                          builder: (context,
                                              provider, child) {
                                            return BoxInformation(
                                                value: provider
                                                    .timerSymptomRecognition,
                                                title:
                                                ' :  تایمر بر اساس دیدن علائم');
                                          },
                                        )
                                            : Container(),


                                        Consumer<ProviderAtendDetaile>(
                                          builder:
                                              (context, provider, child) {
                                            return  Column(
                                              children: [
                                                BoxInformation(
                                                    value:Notifi.patientItem.dateOfAddToSystem == null ?
                                                    'نامشخص' : Notifi.patientItem.dateOfAddToSystem!,
                                                    title:' :  تاریخ ثبت در سیستم'),

                                                Notifi.patientItem.signsStartTime!.isNotEmpty?
                                                BoxInformation(
                                                    value:  "${Notifi.patientItem.signsStartTime} "
                                                        "${Notifi.patientItem.signsStartDate} ",
                                                    title:   ' :  زمان و تاریخ شروع علائم '
                                                ):Container(),

                                                Notifi.patientItem.dateFinishShamsi!.isNotEmpty?
                                                BoxInformation(value:  "${Notifi.patientItem.dateFinishShamsi} "
                                                    "${Notifi.patientItem.timeFinish} ",title:   ' :  زمان و تاریخ پایان کار '
                                                ):Container(),

                                                Notifi.patientItem.needToCT||Notifi.patientItem.needToMRI?
                                                BoxInformation(value:  Notifi.patientItem.needToCT?
                                                'CTScan': 'MRI', title:
                                                ' :  وضعیت'
                                                ):Container(),

                                                Notifi.patientItem.isNot724==false?
                                                BoxInformation(value:   !Notifi.patientItem.nihsIsComplete!?
                                                'تکمیل نشده است':
                                                Notifi.patientItem.nihsSubscore.toString(),
                                                  title:
                                                  ' :  وضعیت  NIHSS',
                                                  onTap: (){
                                                    if(Notifi.patientItem.is724IsComplete==false)
                                                    {
                                                      return ;
                                                    }

                                                    GoNextPage(context,ScreenFormNIHS((p0,s) {
                                                      Navigator.pop(context);
                                                      if(Notifi.patientItem.nihsIsComplete)
                                                      {
                                                        editNIHS(p0,s);
                                                      }else{
                                                        AddNIHS(p0,s);
                                                      }
                                                    },Notifi.patientItem.nihsIsComplete,
                                                      Notifi.patientItem.n_1_a,
                                                      Notifi.patientItem.n_1_b,
                                                      Notifi.patientItem.n_1_c,
                                                      Notifi.patientItem.n_2,
                                                      Notifi.patientItem.n_3,
                                                      Notifi.patientItem.n_4,
                                                      Notifi.patientItem.n_5_a,
                                                      Notifi.patientItem.n_5_b,
                                                      Notifi.patientItem.n_6_a,
                                                      Notifi.patientItem.n_6_b,
                                                      Notifi.patientItem.n_7,
                                                      Notifi.patientItem.n_8,
                                                      Notifi.patientItem.n_9,
                                                      Notifi.patientItem.n_10,
                                                      Notifi.patientItem.n_11,
                                                      false,
                                                      Notifi.patientItem.nihsSubscore,

                                                    ));
                                                  },
                                                ):Container(),

                                                Notifi.patientItem.signsStartTSFSS!=0 && Notifi.patientItem.lkwDate.isNotEmpty ?
                                                BoxInformation(value:   "${Notifi.patientItem.lkwDate} ${Notifi.patientItem.lkwTime}", title:
                                                ' :  LKW'
                                                ):Container(),

                                                Notifi.patientItem.injectionType!=0?
                                                BoxInformation(value:Notifi.patientItem.injectionType==1?
                                                'تزریق':
                                                'تزریق نشود', title:
                                                ' :  وضعیت تزریق'
                                                ):Container(),

                                                Notifi.patientItem.isNot724==false?
                                                BoxInformation(value:Notifi.patientItem.labIsComplete == null  ?'تکمیل نشده است' :
                                                Notifi.patientItem.labIsComplete! ?
                                                'تکمیل شده است':
                                                'تکمیل نشده است'
                                                  , title:
                                                  ' :  فرم آزمایشگاه',
                                                  onTap: (){
                                                    if(Notifi.patientItem.is724IsComplete==true)
                                                    {
                                                      GoNextPage(context,

                                                          ScreenFormLaboratory((p0){
                                                            Navigator.pop(context);
                                                            if(Notifi.patientItem.labIsComplete!!
                                                            )
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
                                                ):Container(),

                                                Notifi.patientItem.labIsComplete!?
                                                BoxInformation(value:"${Notifi.patientItem.labInsertDate} - "
                                                    "${Notifi.patientItem.labInsertTime}", title:
                                                ' : زمان ثبت  فرم آزمایشگاه'
                                                ):Container(),

                                                Notifi.patientItem.isNot724==false?
                                                BoxInformation(value:Notifi.patientItem.bs == 0  ?'تکمیل نشده است' :
                                                Notifi.patientItem.bs.toString()
                                                  , title:
                                                  ' :  قند خون',
                                                  onTap: (){
                                                    if( Notifi.patientItem.is724IsComplete==true
                                                    ){
                                                      GoNextPage(context,  ScreenFormBload724(
                                                          Notifi.patientItem.id.toString(),
                                                          false,(p0){
                                                        var item= p0[0]['bload'].toString();
                                                        RunBload(item);
                                                      }));
                                                    }
                                                  },
                                                ):Container(),

                                                Notifi.patientItem.isNot724==false?
                                                BoxInformation(value:Notifi.patientItem.bloodPressure1 == 0  ?'تکمیل نشده است' :
                                                "${Notifi.patientItem.bloodPressure1}/${
                                                    Notifi.patientItem.bloodPressure2}"
                                                  , title:
                                                  ' :  فشار خون',
                                                  onTap: (){
                                                    if( Notifi.patientItem.is724IsComplete==true
                                                    ){
                                                      GoNextPage(context,ScreenFormPreesBload724(
                                                          Notifi.patientItem.id.toString(),false,(p0){
                                                        var bload1= p0[0]['bload1'].toString();
                                                        var bload2= p0[0]['bload2'].toString();
                                                        RunPressBload(bload1,bload2);
                                                      }));
                                                    }
                                                  },
                                                ):Container(),

                                                Notifi.patientItem.isNot724==false?
                                                BoxInformation(value:Notifi.patientItem.timeOfInjection!.isEmpty  ?'تکمیل نشده است' :
                                                Notifi.patientItem.timeOfInjection.toString()
                                                  , title:
                                                  ' :  زمان تزریق',
                                                  onTap: null,
                                                ):Container(),

                                                Notifi.patientItem.otn.isEmpty?
                                                Container():
                                                BoxInformation(value:Notifi.patientItem.otn, title:
                                                ' :  OTN'
                                                ),

                                                Notifi.patientItem.dtn.isNotEmpty?
                                                BoxInformation(value:Notifi.patientItem.dtn, title:
                                                ' :  DTN'
                                                ):Container(),

                                                Notifi.patientItem.ftn.isNotEmpty?
                                                BoxInformation(value:Notifi.patientItem.ftn, title:
                                                ' :  FTN'
                                                ):Container(),


                                              ],
                                            );
                                          },
                                        ),


                                        Notifi.patientItem.is724IsComplete! &&
                                            !Notifi.patientItem.isNot724!  &&
                                            !Notifi.patientItem.needToMRI!  &&
                                            !Notifi.patientItem.needToCT! ?
                                        Row(
                                          children: [

                                            Expanded(child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: ElevatedButton(

                                                  onPressed: (){
                                                    NeedToCT(context);

                                                  },
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(BtnColorred),
                                                      padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          )
                                                      )
                                                  ),
                                                  child:const Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Text('CT',
                                                      style: TextStyle(color:Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold),),
                                                  )),
                                            )),
                                            Expanded(child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                              child: ElevatedButton(onPressed: (){
                                                NeedToMRI(context);
                                              },
                                                  style: ButtonStyle(
                                                      backgroundColor: MaterialStateProperty.all(BtnColorred),
                                                      padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                          RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          )
                                                      )
                                                  ),
                                                  child:Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text('MRI',
                                                      style: TextStyle(color:Colors.white,
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.bold),),
                                                  )),
                                            ))
                                          ],
                                        ):Container(),
                                        Container(),
                                      ],
                                    ),
                                  ),
                                ),


                                SizedBox(height: 8,),

                                Notifi.patientItem.injectionType==0 && (Notifi.patientItem.needToMRI || Notifi.patientItem.needToCT)?
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            setInjectionTrue(Notifi.patientItem.id.toString(),context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:MaterialStateProperty.all(ColorApp),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
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
                                          child:const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'تزریق',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                    SizedBox(width: 8,),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            setInjectionFalse(Notifi.patientItem.id.toString(),context);
                                           },
                                          style: ButtonStyle(
                                              backgroundColor:  MaterialStateProperty.all(ColorApp),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'عدم تزریق',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                  ],
                                ):Container(),
                                    !Notifi.patientItem.isNot724!  &&
                                    !Notifi.patientItem.needToMRI!  &&
                                    !Notifi.patientItem.needToCT! ?
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            NeedToCT(context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(BtnColorred),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('CT',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    )),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      child: ElevatedButton(onPressed: (){
                                        NeedToMRI(context);
                                      },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(BtnColorred),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('MRI',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ))
                                  ],
                                ):Container(),
                                SizedBox(height: 2,),
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            GoNextPage(context,ScreenListImages(Notifi.patientItem.id.toString()));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:  MaterialStateProperty.all(ColorApp),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text(
                                              'نمایش عکس های ارسال شده',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                  ],
                                ),

                                Notifi.patientItem.injectionType ==2 ?
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            GoNextPage(context, ScreenFormReasonInjection((p0) {
                                              setInjectionReason(widget.patientItem.id.toString(),context,p0);
                                            },
                                              Notifi.patientItem.injectionType!=0?true:false,
                                              Notifi.patientItem.c1!,
                                              Notifi.patientItem.c2!,
                                              Notifi.patientItem.c3!,
                                              Notifi.patientItem.c4!,
                                              Notifi.patientItem.c5!,
                                              Notifi.patientItem.c6!,
                                              Notifi.patientItem.c7!,
                                              Notifi.patientItem.c8!,
                                              Notifi.patientItem.c9!,
                                              Notifi.patientItem.c10!,
                                              Notifi.patientItem.c11!,
                                              Notifi.patientItem.c12!,
                                              Notifi.patientItem.c13!,
                                              Notifi.patientItem.c14!,
                                              Notifi.patientItem.c15!,
                                              Notifi.patientItem.c16!,
                                              Notifi.patientItem.c17!,
                                              Notifi.patientItem.c18!,
                                              Notifi.patientItem.c19!,
                                              Notifi.patientItem.c20!,
                                              Notifi.patientItem.c21!,
                                              Notifi.patientItem.c22!,
                                            ));
                                           },
                                          style: ButtonStyle(
                                              backgroundColor:  MaterialStateProperty.all(ColorApp),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              !Notifi.patientItem.notInjectingIsComplete!!?
                                              'ثبت دلایل رد تزریق':'نمایش دلایل رد تزریق',
                                              style: const TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                  ],
                                ):Container()


                                ,
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


