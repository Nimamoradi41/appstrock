import 'dart:async';

import 'package:appstrock/Screens/Laboratory/ScreenFormLaboratory.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormBload724.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:appstrock/Screens/Resident/ScreenFormTimeInjection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Reception/Model/ModelPatient.dart';
import 'ProviderResident/ProviderResidentDetaile.dart';
import 'ScreenFormImage724.dart';
import 'ScreenFormIs724.dart';
import 'ScreenFormIsNot724.dart';
import 'ScreenFormPreesBload724.dart';



class ScreenDetailPatient extends StatefulWidget {

  ScreenDetailPatient(this.modelPatient,this.MainCtx);
  ModelPatient modelPatient;
  BuildContext MainCtx;
  @override
  State<ScreenDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenDetailPatient> with SingleTickerProviderStateMixin{
  late var Notifi=ProviderResidentDetaile();

  // Future NeedToCT(BuildContext context)async{
  Future NeedToCT(BuildContext context)async{


    DateTime? TimeStart;
    var Flag= await  ShowAllow(context,'آیا   مطمئن هستید ؟ ');
    if(Flag)
      {
        ShowLoadingApp(context);
        // ignore: use_build_context_synchronously
        var Data= await ApiServiceResident.NeedToCT(widget.modelPatient.id.toString(),context);

        if(Data!=null)
        {
          if(Data.success)
          {
            widget.modelPatient.needToCT=true;
            Notifi.setItems(widget.modelPatient);
            Navigator.pop(context);
            // ignore: use_build_context_synchronously
            ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
          }else{
            // ignore: use_build_context_synchronously
            ShowErrorMsg(context, Data.message);
          }
        }


      }

      }
  Future NeedToMRI(BuildContext context)async{

    var Res=await ShowAllow(context,'آیا از تصمیم خود مطمئن هستید ؟');
    if(Res)
    {
      ShowLoadingApp(context);
      // Future.delayed(Duration(seconds: 3),(){
      //   widget.modelPatient.needToMRI=true;
      //   Notifi.setItems(widget.modelPatient);
      //   Navigator.pop(context);
      //   // ignore: use_build_context_synchronously
      //   ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
      // });

      // ignore: use_build_context_synchronously
      var Data= await ApiServiceResident.NeedToMRI(widget.modelPatient.id.toString(),context);

      if(Data!=null)
      {
        if(Data.success)
        {
          widget.modelPatient.needToMRI=true;
          Notifi.setItems(widget.modelPatient);
          Navigator.pop(context);
          // ignore: use_build_context_synchronously
          ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }



    }
  }
  Future AddNIHS(List<Map<String, dynamic>> Str)async{

    ShowLoadingApp(context);
    var Data= await ApiServiceResident.AddNihs(widget.modelPatient.id.toString(),context,Str);



    if(Data!=null)
    {
      if(Data.success)
      {
        widget.modelPatient.nihsIsComplete=true;
        Notifi.setItems(widget.modelPatient);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }


  }
  Future IsNot724()async{





    var Res=await ShowAllow(context,'آیا از تصمیم خود مطمئن هستید ؟');
    if(Res)
    {
      // ignore: use_build_context_synchronously
      var  timestamp=DateTime.now().millisecondsSinceEpoch;
      var Data= await ApiServiceResident.SetNot724(widget.modelPatient.id.toString(),
          context,false,timestamp.toString());
      Navigator.pop(context);
      if(Data!=null)
      {
        if(Data.success)
        {
          widget.modelPatient.isNot724=true;
          widget.modelPatient.is724IsComplete=true;
          widget.modelPatient.isFinished=true;
          widget.modelPatient.isNot724IsComplete=true;
          Notifi.setItems(widget.modelPatient);
          // ignore: use_build_context_synchronously
          ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }




    }
  }
  Future AddResean(bool MisdiagnosisOfTriage,bool MisdiagnosisOfEms,bool OverTime)async{
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously

    var Data= await ApiServiceResident.ReasonsForIsNot724(
      widget.modelPatient.id.toString(),
        context,MisdiagnosisOfTriage,MisdiagnosisOfEms,OverTime);
    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        widget.modelPatient.isNot724=true;
        widget.modelPatient.is724IsComplete=true;
        Notifi.setItems(widget.modelPatient);
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
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
              } ,   widget.modelPatient.isNot724IsComplete!,
                  widget.modelPatient.misdiagnosisOfTriage!,
                  widget.modelPatient.misdiagnosisOfEms!,
                widget.modelPatient.overTime!
              )),
        ],
      );

    });
  }







Future  AddRequestIs724(bool IsUnkown,String TimeStart,String DateStart
    ,String TimeFssStart,String DateFSSStart,String TimeLKWStart,String DateLKWStart, String timestamp)async{


  ShowLoadingApp(context);
  // ignore: use_build_context_synchronously
  var Data= await ApiServiceResident.Set724(widget.modelPatient.id.toString(),
  context,IsUnkown,TimeStart,DateStart,TimeFssStart,
      DateFSSStart,TimeLKWStart,DateLKWStart,true,timestamp);
  Navigator.pop(context);
  if(Data!=null)
  {
    if(Data.success)
    {
      widget.modelPatient.is724IsComplete=true;
      widget.modelPatient.isNot724=false;
      if(IsUnkown)
        {
          widget.modelPatient.signsStartIsUnknown=true;
          widget.modelPatient.fssTime=TimeFssStart;
          widget.modelPatient.lkwTime=TimeLKWStart;
          widget.modelPatient.fssDate=DateFSSStart;
          widget.modelPatient.lkwDate=DateLKWStart;
        }else{
        widget.modelPatient.signsStartIsUnknown=false;
        widget.modelPatient.signsStartTime=TimeStart;
        widget.modelPatient.signsStartDate=DateStart;
      }

      Notifi.setItems(widget.modelPatient);


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
  var TimeEffect=0.0;
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
  void startTimerEffect() {
    const oneSec =   Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        TimeEffect=TimeEffect+1;
        var date=Duration(seconds: TimeEffect.toInt());
        int hours = date.inSeconds ~/ 3600;
        int minutes = (date.inSeconds % 3600) ~/ 60;
        int remainingSeconds = date.inSeconds % 60;
        TimeEffectStr =Convert_Time(hours.toString(),minutes.toString(),remainingSeconds.toString());
        Notifi.setTimeEffect(TimeEffectStr);
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
    try{
      _timer.cancel();
    }catch(s){

    }

    super.dispose();
  }
  late AnimationController _controller;
  late Animation<Color?> _colorAnimationRed;
  late Animation<Color?> _colorAnimationGreen;

  Future RunPressBload(String Blod1,String Blod2)async{

    var Res=await ShowAllow(context,'آیا از تکمیل فرم مطمئن هستید ؟');
    if(Res)
    {
      ShowLoadingApp(context);

      var Data= await ApiServiceResident.PressBlod(widget.modelPatient.id.toString()
          ,context,Blod1,Blod2);

      Navigator.pop(context);

      if(Data!=null)
      {
        if(Data.success)
        {
          ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
          widget.modelPatient.bloodPressure1= int.parse(Blod1);
          widget.modelPatient.bloodPressure2=int.parse(Blod2);
          Notifi.setItems(widget.modelPatient);
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }
    }

  }



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
    if(widget.modelPatient.signsStartTS!=0&&!widget.modelPatient.isFinished!)
    {
      // TimeEffect=((now.millisecondsSinceEpoch/1000)-(1721047260000/1000));
      TimeEffect=((now.millisecondsSinceEpoch/1000)-(widget.modelPatient.signsStartTS!/1000));
      startTimerEffect();
    }
  }
  Future RunBload(String Blod)async{
    var Res=await ShowAllow(context,'آیا مطمئن هستید ؟');
    if(Res)
    {
      ShowLoadingApp(context);
      var Data= await ApiServiceResident.Blod(widget.modelPatient.id.toString(),context,Blod);

      Navigator.pop(context);
      if(Data!=null)
      {
        if(Data.success)
        {
          ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
          widget.modelPatient.bs= int.parse(Blod);
          Notifi.setItems(widget.modelPatient);
        }else{
          ShowErrorMsg(context, Data.message);
        }
      }
      // ignore: use_build_context_synchronously
    }


  }
  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderResidentDetaile>(context);
    double wid=MediaQuery.of(context).size.width;
    double hei=MediaQuery.of(context).size.height;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
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
                            Spacer(),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  widget.modelPatient!.is724IsComplete! && !widget.modelPatient!.isNot724?
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
                                            animation:  Notifi.PatientItem!.seenByAttend! ?

                                            _colorAnimationGreen:
                                            _colorAnimationRed
                                            ,
                                            builder: (context, child) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color:  Notifi.PatientItem!.seenByAttend! ? _colorAnimationGreen.value:_colorAnimationRed.value,
                                                    shape: BoxShape.circle
                                                ),
                                                width: 10,
                                                height: 10,

                                              );
                                            },
                                          ),
                                          SizedBox(width: 8,),
                                          TextApp(  widget.modelPatient!.seenByAttend!?
                                          'دکتر متخصص مشاهده کرده است'
                                              : 'دکتر متخصص مشاهده نکرده است', 10,
                                              widget.modelPatient!.seenByAttend!? Colors.green :
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
                                        TextApp(widget.modelPatient.nationalCode.isEmpty  ? 'نامشخص':widget.modelPatient.nationalCode, 14, ColorTextbody, true)
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
                                        TextApp(widget.modelPatient.fullName.isEmpty  ? 'نامشخص':widget.modelPatient.fullName, 14, ColorTextbody, true)
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
                                        TextApp(widget.modelPatient.age.isEmpty  ? 'نامشخص':widget.modelPatient.age, 14, ColorTextbody, true)
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
                                        TextApp(widget.modelPatient.gender.isEmpty  ? 'نامشخص':widget.modelPatient.gender, 14, ColorTextbody, true)
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
                                              TextApp(widget.modelPatient.timeOfAddToSystem.isEmpty  ?
                                              'نامشخص':widget.modelPatient.timeOfAddToSystem, 14, ColorTextbody, true),
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
                                              TextApp(widget.modelPatient.dateOfAddToSystem == null ?
                                              'نامشخص' : widget.modelPatient.dateOfAddToSystem!, 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  تاریخ ثبت در سیستم', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        widget.modelPatient.signsStartTime!.isNotEmpty?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp("${widget.modelPatient.signsStartTime} "
                                                  "${widget.modelPatient.signsStartDate} ", 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان و شروع تاریخ علائم ', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),
                                        widget.modelPatient.needToCT||widget.modelPatient.needToMRI?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(
                                                  widget.modelPatient.needToCT?
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
                                                  widget.modelPatient.nihsIsComplete== null ?
                                                  'تکمیل نشده است':
                                                  widget.modelPatient.nihsIsComplete!?
                                                   'تکمیل شده است':
                                                  'تکمیل نشده است'

                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فرم NIHSS', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if(widget.modelPatient.is724IsComplete==true)
                                                    {
                                                      GoNextPage(context, ScreenFormLaboratory((p0){

                                                      },false,
                                                          widget.modelPatient.bun.toString(),
                                                          widget.modelPatient.cr.toString(),
                                                          widget.modelPatient.plt.toString(),
                                                          widget.modelPatient.pt.toString(),
                                                          widget.modelPatient.inr.toString(),
                                                          widget.modelPatient.trop.toString(),
                                                          true
                                                      ));
                                                    }

                                                },
                                                child: TextApp(widget.modelPatient.labIsComplete == null  ?'تکمیل نشده است' :
                                                widget.modelPatient.labIsComplete! ?
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
                                        widget.modelPatient.labIsComplete!?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(
                                                  "${widget.modelPatient.labInsertDate} - "
                                                      "${widget.modelPatient.labInsertTime}"
                                                  , 14, ColorTextbody, true),
                                              Expanded(child:
                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' : زمان ثبت  فرم آزمایشگاه', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(widget.modelPatient.timeOfInjection!.isEmpty  ?'تکمیل نشده است' :
                                              widget.modelPatient.timeOfInjection.toString()
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان تزریق', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if( widget.modelPatient.is724IsComplete==true&&
                                                      widget.modelPatient.bs==0
                                                  ){
                                                    GoNextPage(context,  ScreenFormBload724(widget.modelPatient.id.toString(),
                                                        false,(p0){
                                                           var item= p0[0]['bload'].toString();
                                                           RunBload(item);
                                                        }));
                                                  }
                                                },
                                                child: TextApp(widget.modelPatient.bs == 0  ?'تکمیل نشده است' :
                                                widget.modelPatient.bs.toString()
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
                                                  if( widget.modelPatient.is724IsComplete==true&&
                                                  widget.modelPatient.bloodPressure1==0
                                                  ){
                                                    GoNextPage(context,ScreenFormPreesBload724(
                                                        widget.modelPatient.id.toString(),false,(p0){
                                                          print(p0);
                                                      var bload1= p0[0]['bload1'].toString();
                                                      var bload2= p0[0]['bload2'].toString();

                                                      RunPressBload(bload1,bload2);
                                                    }));
                                                  }
                                                },
                                                child: TextApp( widget.modelPatient.bloodPressure1 == 0  ?'تکمیل نشده است' :
                                                "${widget.modelPatient.bloodPressure1}/${widget.modelPatient.bloodPressure2}"
                                                    , 14, ColorTextbody, true),
                                              ),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فشار خون', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        widget.modelPatient.injectionType!=0?
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(  widget.modelPatient.injectionType==1?
                                              'تزریق بشود':
                                              'تزریق نشود'
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  وضعیت تزریق', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),
                                        widget.modelPatient.is724IsComplete!
                                         && !widget.modelPatient.isNot724  && !widget.modelPatient.isFinished!  ?
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
                                             )
                                           ],
                                         ):Container()
                                      ],
                                     ),
                                   ),
                                 ),
                                !widget.modelPatient.is724IsComplete! && !widget.modelPatient.isNot724!  ?
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
                                widget.modelPatient.is724IsComplete! &&
                                    !widget.modelPatient.isNot724!  &&
                                    !widget.modelPatient.needToMRI!  &&
                                    !widget.modelPatient.needToCT! ?
                                Row(
                                  children: [

                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ElevatedButton(

                                          onPressed: (){
                                            NeedToCT(context);

                                          },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(BtnColorred),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text('CT',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    )),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ElevatedButton(onPressed: (){
                                        NeedToMRI(context);
                                      },
                                          style: ButtonStyle(
                                              backgroundColor: MaterialStateProperty.all(BtnColorred),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text('MRI',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ))
                                  ],
                                ):Container(),
                                Container(),


                                widget.modelPatient.is724IsComplete! &&
                                    !widget.modelPatient.isNot724!  ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                       GoNextPage(context, ScreenFormNIHS((p0) {
                                         Navigator.pop(context);

                                         AddNIHS(p0);
                                       },widget.modelPatient.nihsIsComplete!,
                                           widget.modelPatient.n_1_a!,
                                           widget.modelPatient.n_1_b!,
                                           widget.modelPatient.n_1_c!,
                                           widget.modelPatient.n_2!,
                                           widget.modelPatient.n_3!,
                                           widget.modelPatient.n_4!,
                                           widget.modelPatient.n_5_a!,
                                           widget.modelPatient.n_5_b!,
                                           widget.modelPatient.n_6_a!,
                                           widget.modelPatient.n_6_b!,
                                           widget.modelPatient.n_7!,
                                           widget.modelPatient.n_8!,
                                           widget.modelPatient.n_9!,
                                           widget.modelPatient.n_10!,
                                           widget.modelPatient.n_11!,
                                           false

                                       ));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: widget.modelPatient.nihsIsComplete==true?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              widget.modelPatient.nihsIsComplete ==true ?
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ):
                                              widget.modelPatient.nihsIsComplete==true ?
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
                                        child: Text( widget.modelPatient.nihsIsComplete ==false?
                                        'NIHSS':
                                        'NIHSS',
                                          style: TextStyle(
                                              color:
                                              widget.modelPatient.nihsIsComplete==false ?Colors.white:
                                              ColorApp ,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),



                                widget.modelPatient.is724IsComplete!
                                    && widget.modelPatient.isNot724!  ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        AddReasonNot724();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: !widget.modelPatient.isNot724IsComplete! ?
                                          MaterialStateProperty.all(ColorApp):
                                          MaterialStateProperty.all(Colors.white),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              !widget.modelPatient.isNot724IsComplete! ?
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
                                        child: Text( widget.modelPatient.isNot724IsComplete ==null?
                                        'تکمیل دلایل رد کد 724':
                                        widget.modelPatient.isNot724IsComplete!

                                            ?'نمایش دلایل رد کد 724':'تکمیل دلایل رد کد 724',
                                          style: TextStyle(
                                              color:
                                              widget.modelPatient.isNot724IsComplete==null ?Colors.white:
                                              widget.modelPatient.isNot724IsComplete!?
                                              ColorApp : Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),
                                widget.modelPatient.is724IsComplete!
                                    && !widget.modelPatient.isNot724!?
                                Row(
                                  children: [

                                    // Expanded(
                                    //   child: Container(
                                    //     width: wid,
                                    //     margin: const EdgeInsets.symmetric(horizontal: 8),
                                    //     child: ElevatedButton(
                                    //         onPressed: (){
                                    //           GoNextPage(context,ScreenFormPreesBload724(widget.modelPatient.id.toString(),false,
                                    //               (p0){
                                    //                 var bload1= p0[0]['bload1'].toString();
                                    //                 var bload2= p0[1]['bload2'].toString();
                                    //                 RunPressBload(bload1,bload2);
                                    //               }));
                                    //         },
                                    //         style: ButtonStyle(
                                    //             backgroundColor:
                                    //             MaterialStateProperty.all(ColorApp),
                                    //             padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                    //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    //                 widget.modelPatient.isNot724IsComplete == null ?
                                    //                 RoundedRectangleBorder(
                                    //                   borderRadius: BorderRadius.circular(8.0),
                                    //                 ):
                                    //                 widget.modelPatient.isNot724IsComplete! ?
                                    //                 RoundedRectangleBorder(
                                    //                     borderRadius: BorderRadius.circular(8.0),
                                    //                     side:  const BorderSide(color: ColorApp,width: 2)
                                    //                 ):
                                    //                 RoundedRectangleBorder(
                                    //                   borderRadius: BorderRadius.circular(8.0),
                                    //                 )
                                    //             )
                                    //         ),
                                    //         child:const Padding(
                                    //           padding: EdgeInsets.all(10.0),
                                    //           child: Text('افزودن توضیحات',
                                    //             style: TextStyle(
                                    //                 color:
                                    //                 Colors.white,
                                    //                 fontSize: 14,
                                    //                 fontWeight: FontWeight.bold),),
                                    //         )),
                                    //   ),
                                    // ),
                                    // Expanded(
                                    //   child: Container(
                                    //     width: wid,
                                    //     margin: const EdgeInsets.symmetric(horizontal: 8),
                                    //     child: ElevatedButton(
                                    //         onPressed: (){
                                    //           GoNextPage(context, ScreenFormImage724(widget.modelPatient.id.toString()));
                                    //         },
                                    //         style: ButtonStyle(
                                    //             backgroundColor:  MaterialStateProperty.all(ColorApp),
                                    //             padding: MaterialStateProperty.all(EdgeInsets.all(2)),
                                    //             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    //                 RoundedRectangleBorder(
                                    //                   borderRadius: BorderRadius.circular(8.0),
                                    //                 )
                                    //             )
                                    //         ),
                                    //         child:const Padding(
                                    //           padding: EdgeInsets.all(8.0),
                                    //           child: Text(
                                    //             'ارسال عکس',
                                    //             style: TextStyle(
                                    //                 color:
                                    //                 Colors.white,
                                    //                 fontSize: 12,
                                    //                 fontWeight: FontWeight.bold),),
                                    //         )),
                                    //   ),
                                    // )

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


