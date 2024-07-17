import 'dart:async';

import 'package:appstrock/Screens/Atend/ScreenListImages.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Laboratory/ScreenFormLaboratory.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/Model/ModelPatient.dart';
import '../Resident/ScreenFormBload724.dart';
import '../Resident/ScreenFormImage724.dart';
import '../Resident/ScreenFormPreesBload724.dart';
import '../Resident/ScreenFormReasonInjection.dart';
import 'ProviderAtend/ProviderAtendDetaile.dart';




class ScreenDetailPatientAtend extends StatefulWidget {
  ScreenDetailPatientAtend(this.modelPatient,this.MainCtx);
  ModelPatient modelPatient;
  BuildContext MainCtx;
  @override
  State<ScreenDetailPatientAtend> createState() => _ScreenDetailPatientState();
}
class _ScreenDetailPatientState extends State<ScreenDetailPatientAtend> {

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
  Future   seenByAtend(String id,BuildContext context) async
  {
    var Flag=await ShowAllow(context,'آیا  مطمئن هستید ؟');
    if(Flag)
    {
      ShowLoadingApp(context);
      // ignore: use_build_context_synchronously
      var Data= await ApiServiceReception.SeenByAtend(context,widget.modelPatient.id.toString());
      print(Data.toJson());

      if(Data!=null)
      {
        if(Data.success)
        {
          widget.modelPatient.seenByAttend=true;
          Notifi.setItems(widget.modelPatient);
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }

      Navigator.pop(context);
    }









  }
  Future   setInjectionTrue(String id,BuildContext context) async
  {
    var Flag=await ShowAllow(context,'آیا  مطمئن هستید ؟');
    if(Flag)
    {
      ShowLoadingApp(context);
      // ignore: use_build_context_synchronously
      var Data= await ApiServiceReception.SetInjectionStatus(context,widget.modelPatient.id.toString(),true);
      print(Data.toJson());

      if(Data!=null)
      {
        if(Data.success)
        {
          widget.modelPatient.injectionType=1;
          Notifi.setItems(widget.modelPatient);
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }

      Navigator.pop(context);
    }









  }
  Future   setInjectionFalse(String id,BuildContext context) async
  {
    var Flag=await ShowAllow(context,'آیا  مطمئن هستید ؟');
    if(Flag)
    {
      ShowLoadingApp(context);
      // ignore: use_build_context_synchronously
      var Data= await ApiServiceReception.SetInjectionStatus(context,widget.modelPatient.id.toString(),false);
      print(Data.toJson());

      if(Data!=null)
      {
        if(Data.success)
        {
          widget.modelPatient.injectionType=2;
          Notifi.setItems(widget.modelPatient);
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }

      Navigator.pop(context);
    }









  }
  late var Notifi=ProviderAtendDetaile();
  var TimeEffect=0.0;
  var TimeEffectStr="0";
  var TimeAriveToHospital=0.0;
  var TimeAriveToHospitalStr="0";
  late Timer _timer;
  late Timer _timer2;
  double FinalTime=0;
  double FinalTime2=0;
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
                  },widget.modelPatient.notInjectingIsComplete!,
                      widget.modelPatient.c1!,
                      widget.modelPatient.c2!,
                      widget.modelPatient.c3!,
                      widget.modelPatient.c4!,
                      widget.modelPatient.c5!,
                      widget.modelPatient.c6!,
                      widget.modelPatient.c7!,
                      widget.modelPatient.c8!,
                      widget.modelPatient.c9!,
                      widget.modelPatient.c10!,
                      widget.modelPatient.c11!,
                      widget.modelPatient.c12!,
                      widget.modelPatient.c13!,
                      widget.modelPatient.c14!,
                      widget.modelPatient.c15!,
                      widget.modelPatient.c16!,
                      widget.modelPatient.c17!,
                      widget.modelPatient.c18!,
                      widget.modelPatient.c19!,
                      widget.modelPatient.c20!,
                      widget.modelPatient.c21!,
                      widget.modelPatient.c22!
                  )),
            ],
          );

        });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
  }
  @override
  void initState() {
    super.initState();

    // // print(ss.toDateTime().millisecondsSinceEpoch.toString());
    //
    //
    // print((now.millisecondsSinceEpoch/1000));
    // TimeEffect=((now.millisecondsSinceEpoch/1000)-(1721047260000/1000));
    DateTime now = new DateTime.now();
    if(widget.modelPatient.signsStartTS!=0&&!widget.modelPatient.isFinished!)
    {
      // TimeEffect=((now.millisecondsSinceEpoch/1000)-(1721047260000/1000));
      TimeEffect=((now.millisecondsSinceEpoch/1000)-(widget.modelPatient.signsStartTS!/1000));
      startTimerEffect();
    }


    // TimeAriveToHospital=((now.millisecondsSinceEpoch/1000)-(1721047260000/1000));


  }
  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderAtendDetaile>(context);
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
                            !widget.modelPatient.seenByAttend!!?
                            InkWell(
                              onTap: (){
                               seenByAtend(widget.modelPatient.id.toString(), context);
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
                            Padding(
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
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('کدملی', 12, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(widget.modelPatient.nationalCode.isEmpty  ? 'نامشخص':widget.modelPatient.nationalCode, 13, ColorTextbody, true)
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
                                        TextApp(widget.modelPatient.fullName.isEmpty  ? 'نامشخص':widget.modelPatient.fullName, 13, ColorTextbody, true)
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
                                        TextApp(widget.modelPatient.age.isEmpty  ? 'نامشخص':widget.modelPatient.age, 13, ColorTextbody, true)
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
                                        TextApp(widget.modelPatient.gender.isEmpty  ? 'نامشخص':widget.modelPatient.gender, 13, ColorTextbody, true)
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
                                                  'MIR'
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
                                                  if(widget.modelPatient.labIsComplete==true
                                                  )
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
                                              TextApp(widget.modelPatient.bs == 0  ?'تکمیل نشده است' :
                                              widget.modelPatient.bs.toString()
                                                  , 14, ColorTextbody, true),
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
                                            TextApp(widget.modelPatient.bloodPressure1 == 0  ?'تکمیل نشده است' :
                                              "${widget.modelPatient.bloodPressure1}/${widget.modelPatient.bloodPressure2}"
                                                  , 14, ColorTextbody, true),
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
                                                  'تزریق بشود'
                                                  , 14, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  وضعیت تزریق', 12, ColorTitleText, false))),
                                            ],
                                          ),
                                        ):Container(),
                                        widget.modelPatient.is724IsComplete!
                                            && !widget.modelPatient.isNot724   ?
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


                                SizedBox(height: 8,),


                                widget.modelPatient.injectionType==0?
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            setInjectionTrue(widget.modelPatient.id.toString(),context);
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:MaterialStateProperty.all(Colors.red),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
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
                                          child:const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'تزریق بشود',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                    SizedBox(width: 8,),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            setInjectionFalse(widget.modelPatient.id.toString(),context);
                                           },
                                          style: ButtonStyle(
                                              backgroundColor:  MaterialStateProperty.all(Colors.green),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'تزریق نشود',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                  ],
                                ):Container(),
                                SizedBox(height: 2,),
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            GoNextPage(context, ScreenFormNIHS((p0) {
                                              Navigator.pop(context);
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
                                                true
                                            ));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:MaterialStateProperty.all(ColorApp),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
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
                                          child:const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'NIHSS',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                    SizedBox(width: 8,),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: (){
                                            GoNextPage(context,ScreenListImages(widget.modelPatient.id.toString()));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:  MaterialStateProperty.all(ColorApp),
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:const Padding(
                                            padding: EdgeInsets.all(10.0),
                                            child: Text(
                                              'نمایش عکس های ارسال شده',
                                              style: TextStyle(
                                                  color:
                                                  Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ),),
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     Expanded(child: Padding(
                                //       padding: const EdgeInsets.all(8.0),
                                //       child: ElevatedButton(
                                //           onPressed: (){
                                //             GoNextPage(context,ScreenListImages(widget.modelPatient.id.toString()));
                                //           },
                                //           style: ButtonStyle(
                                //               backgroundColor:  MaterialStateProperty.all(ColorApp),
                                //               padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                //               shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                //                   RoundedRectangleBorder(
                                //                     borderRadius: BorderRadius.circular(8.0),
                                //                   )
                                //               )
                                //           ),
                                //           child:  Padding(
                                //             padding: const EdgeInsets.all(10.0),
                                //             child: Text(
                                //               widget.modelPatient.notInjectingIsComplete!?
                                //               'نمایش دلایل رد تزریق':
                                //               'تکمیل دلایل رد تزریق',
                                //               style: const TextStyle(
                                //                   color:
                                //                   Colors.white,
                                //                   fontSize: 13,
                                //                   fontWeight: FontWeight.bold),),
                                //           )),
                                //     ),),
                                //   ],
                                // ),

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


