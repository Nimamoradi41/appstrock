import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Reception/Model/ModelPatient.dart';
import 'ProviderResident/ProviderResidentDetaile.dart';
import 'ScreenFormIs724.dart';
import 'ScreenFormIsNot724.dart';



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
    var Flag= await   ShowAllow(context,'آیا از CT مطمئن هستید ؟ ');
    if(Flag)
      {



        ShowLoadingApp(context);
        Future.delayed(Duration(seconds: 3),(){
              widget.modelPatient.needToCT=true;
              Notifi.setItems(widget.modelPatient);
              Navigator.pop(context);
              // ignore: use_build_context_synchronously
              ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
        });



        // ShowLoadingApp(context);
        // // ignore: use_build_context_synchronously
        // var Data= await ApiServiceResident.NeedToCT(widget.modelPatient.id.toString(),context);
        //
        // if(Data!=null)
        // {
        //   if(Data.success)
        //   {
        //     widget.modelPatient.needToCT=true;
        //     Notifi.setItems(widget.modelPatient);
        //     Navigator.pop(context);
        //     // ignore: use_build_context_synchronously
        //     ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
        //   }else{
        //     // ignore: use_build_context_synchronously
        //     ShowErrorMsg(context, Data.message);
        //   }
        // }


      }

      }
  Future NeedToMRI(BuildContext context)async{

    var Res=await ShowAllow(context,'آیا از تصمیم خود مطمئن هستید ؟');
    if(Res)
    {
      ShowLoadingApp(context);
      Future.delayed(Duration(seconds: 3),(){
        widget.modelPatient.needToMRI=true;
        Notifi.setItems(widget.modelPatient);
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
      });

      // ignore: use_build_context_synchronously
      // var Data= await ApiServiceResident.NeedToMRI(widget.modelPatient.id.toString(),context);
      //
      // if(Data!=null)
      // {
      //   if(Data.success)
      //   {
      //     widget.modelPatient.needToMRI=true;
      //     Notifi.setItems(widget.modelPatient);
      //     Navigator.pop(context);
      //     // ignore: use_build_context_synchronously
      //     ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
      //   }else{
      //     // ignore: use_build_context_synchronously
      //     ShowErrorMsg(context, Data.message);
      //   }
      // }



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
      ShowLoadingApp(context);
      // ignore: use_build_context_synchronously
      var Data= await ApiServiceResident.Set724(widget.modelPatient.id.toString(),
          context,false,'','','','','','',false);
      Navigator.pop(context);
      if(Data!=null)
      {
        if(Data.success)
        {
          widget.modelPatient.isNot724=true;
          widget.modelPatient.is724IsComplete=true;
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
              child:   ScreenFormIsNot724((pa) async{
                Navigator.pop(context);
                ShowLoadingApp(context);
                await Future.delayed(Duration(seconds: 2));
                widget.modelPatient.AddReasonNot724=true;
                Notifi.setItems(widget.modelPatient);
                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');

              })),
        ],
      );

    });
  }


Future  AddRequestIs724(bool IsUnkown,String TimeStart,String DateStart
    ,String TimeFssStart,String DateFSSStart,String TimeLKWStart,String DateLKWStart)async{


  ShowLoadingApp(context);
  // ignore: use_build_context_synchronously
  var Data= await ApiServiceResident.Set724(widget.modelPatient.id.toString(),
  context,IsUnkown,TimeStart,DateStart,TimeFssStart,DateFSSStart,TimeLKWStart,DateLKWStart,true);
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
                Navigator.pop(context);
                ShowLoadingApp(context);
                await Future.delayed(Duration(seconds: 2));
                if(Know=='false')
                  {
                      Time=p[1]['Time']!;
                      Date=p[2]['Date']!;
                      print(Time);
                      print(Date);
                      AddRequestIs724(false, Time, Date, '', '', '', '');
                  }else{
                  TimeFss=p[3]['TimeFss']!;
                  TimeLKW=p[1]['TimeLKW']!;
                  DateFSS=p[4]['DateFss']!;
                  DateLKW=p[2]['DateLKW']!;

                  AddRequestIs724(true, '', '', TimeFss, DateFSS, TimeLKW, DateLKW);





                }







                Navigator.pop(context);
                // ignore: use_build_context_synchronously
                ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
              }));

        });
  }


  @override
  void dispose() {
    _controller.dispose(); // رها کردن منابع انیمیشن کنترلر
    super.dispose();
  }
  late AnimationController _controller;
  late Animation<Color?> _colorAnimationRed;
  late Animation<Color?> _colorAnimationGreen;
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
            child:   Stack(
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
                                  Notifi.PatientItem!.is724IsComplete == null   ?
                                  Container() :
                                  Notifi.PatientItem!.is724IsComplete! ?
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
                                            animation:  Notifi.PatientItem!.AtendSeen! ?  _colorAnimationGreen:
                                            _colorAnimationRed
                                            ,
                                            builder: (context, child) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                    color:  Notifi.PatientItem!.AtendSeen! ? _colorAnimationGreen.value:_colorAnimationRed.value,
                                                    shape: BoxShape.circle
                                                ),
                                                width: 10,
                                                height: 10,

                                              );
                                            },
                                          ),
                                          SizedBox(width: 8,),
                                          TextApp( Notifi.PatientItem!.AtendSeen! ?   'دکتر متخصص مشاهده کرده است'
                                              : 'دکتر متخصص مشاهده نکرده است', 10,
                                              Notifi.PatientItem!.AtendSeen!? Colors.green :
                                              Colors.red, true),
                                          SizedBox(width: 4,)
                                        ],
                                      ),
                                    ),
                                  )
                                 :Container(),
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
                                              TextApp(widget.modelPatient.timeOfAddToSystem.isEmpty  ? 'نامشخص':widget.modelPatient.timeOfAddToSystem, 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان ثبت در سیسیتم', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(widget.modelPatient.dateOfAddToSystem == null ? 'نامشخص' : widget.modelPatient.dateOfAddToSystem!, 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  تاریخ ثبت در سیسیتم', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(widget.modelPatient.needToMRI ? ' اعلان MRI':
                                              widget.modelPatient.needToCT ? ' اعلان CT' :
                                              widget.modelPatient.isNot724 ? 'کد 724 نیست' : 'نامشخص'

                                                  , 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  وضعیت بیمار', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
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

                                                  , 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فرم NIHSS', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(widget.modelPatient.IsLab == null  ?'تکمیل نشده است' :
                                              widget.modelPatient.IsLab! ?
                                              'تکمیل شده است':
                                              'تکمیل نشده است'

                                                  , 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  فرم آزمایشگاه', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        )
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

                                SizedBox(height: 8,),
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
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text('CT',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 16,
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
                                              padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                  )
                                              )
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text('MIR',
                                              style: TextStyle(color:Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),),
                                          )),
                                    ))
                                  ],
                                ) :Container(),

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
                                       },widget.modelPatient.nihsIsComplete==null? false:widget.modelPatient.nihsIsComplete!));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: widget.modelPatient.nihsIsComplete==true?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
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
                                      child:Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text( widget.modelPatient.nihsIsComplete ==false?
                                        'تکمیل فرم NIHSS':
                                        'نمایش فرم NIHSS',
                                          style: TextStyle(
                                              color:
                                              widget.modelPatient.nihsIsComplete==false ?Colors.white:
                                              ColorApp ,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),
                                SizedBox(height: 8,),


                                widget.modelPatient.is724IsComplete! && widget.modelPatient.isNot724!  ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        AddReasonNot724();
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: widget.modelPatient.AddReasonNot724 == null ?
                                          MaterialStateProperty.all(ColorApp):
                                          widget.modelPatient.AddReasonNot724!?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              widget.modelPatient.AddReasonNot724 == null ?
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ):
                                              widget.modelPatient.AddReasonNot724! ?
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
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text( widget.modelPatient.AddReasonNot724 ==null?
                                        'تکمیل دلایل رد کد 724':
                                        widget.modelPatient.AddReasonNot724!

                                            ?'نمایش دلایل رد کد 724':'تکمیل دلایل رد کد 724',
                                          style: TextStyle(
                                              color:
                                              widget.modelPatient.AddReasonNot724==null ?Colors.white:
                                              widget.modelPatient.AddReasonNot724!?
                                              ColorApp : Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),





                                    // :Container(),
                                SizedBox(height: 16,),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    bottom: 4,
                    right: 8,
                    left: 8,
                    child: TextApp(VersionApp, 12, Colors.black54, true))
              ],
            ),
          ),
        ),
      ),
    );
  }
}


