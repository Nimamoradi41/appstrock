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



class ScreenDetailPatient extends StatefulWidget {

  ScreenDetailPatient(this.modelPatient,this.MainCtx);
  





  ModelPatient modelPatient;
  BuildContext MainCtx;

  @override
  State<ScreenDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenDetailPatient> {
  late var Notifi=ProviderResidentDetaile();

  // Future NeedToCT(BuildContext context)async{
  Future NeedToCT()async{


    DateTime? TimeStart;
    var Flag= await   ShowAllow(widget.MainCtx,'آیا از CT مطمئن هستید ؟ ');
    if(Flag)
      {
        // ignore: use_build_context_synchronously
        await   DatePickerBdaya.showTimePicker(widget.MainCtx,
            showTitleActions: true,
            onConfirm: (date) {
              TimeStart=date;
            }, currentTime: DateTime.now(), locale: LocaleType.fa);



        if(TimeStart!=null)
          {
            var Data= await ApiServiceResident.NeedToCT(widget.modelPatient.id.toString(), widget.MainCtx, TimeStart!.millisecondsSinceEpoch.toString());
            if(Data!=null)
              {
                if(Data.success)
                  {
                    widget.modelPatient.needToCT=true;
                    Notifi.setItems(widget.modelPatient);
                    // ignore: use_build_context_synchronously
                    ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
                  }else
                    {
                      // ignore: use_build_context_synchronously
                      ShowErrorMsg(widget.MainCtx, Data.message);
                    }
              }else{
              // ignore: use_build_context_synchronously
              ShowErrorMsg(widget.MainCtx, 'مشکلی در ارتباط با سرور به وچود آمده');
            }
          }

        }
      }

  Future NeedToMRI()async{


    DateTime? TimeStart;
    var Flag= await   ShowAllow(widget.MainCtx,'آیا از MRI مطمئن هستید ؟ ');


    if(Flag)
    {
      // ignore: use_build_context_synchronously
      await   DatePickerBdaya.showTimePicker(widget.MainCtx,
          showTitleActions: true,
          onConfirm: (date) {
            TimeStart=date;
          }, currentTime: DateTime.now(), locale: LocaleType.fa);



      if(TimeStart!=null)
      {
        var Data= await ApiServiceResident.NeedToMRI(widget.modelPatient.id.toString(), widget.MainCtx, TimeStart!.millisecondsSinceEpoch.toString());
        if(Data!=null)
        {
          if(Data.success)
          {
            widget.modelPatient.needToMRI=true;
            Notifi.setItems(widget.modelPatient);
            // ignore: use_build_context_synchronously
            ShowSuccesMsg(widget.MainCtx, 'عملیات با موفقیت انجام شد');
          }else
          {
            // ignore: use_build_context_synchronously
            ShowErrorMsg(widget.MainCtx, Data.message);
          }
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(widget.MainCtx, 'مشکلی در ارتباط با سرور به وچود آمده');
        }
      }

    }
  }



  Future AddNIHS()async{


    ShowLoadingApp(context);
   await Future.delayed(Duration(seconds: 2));
    widget.modelPatient.IsNIHSS=true;
    Notifi.setItems(widget.modelPatient);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');

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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                            ),


                            Expanded(child:
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
                                              TextApp(widget.modelPatient.dateOfAddToSystem.isEmpty  ? 'نامشخص':widget.modelPatient.dateOfAddToSystem, 16, ColorTextbody, true),
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
                                              TextApp(widget.modelPatient.IsNIHSS ? 'تکمیل شده است': 'تکمیل نشده است'

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
                                              TextApp(widget.modelPatient.IsLab ? 'تکمیل شده است': 'تکمیل نشده است'

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
                                !widget.modelPatient.needToCT && !widget.modelPatient.isNot724 && !widget.modelPatient.needToMRI ?
                                Row(
                                  children: [

                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: ElevatedButton(

                                          onPressed: (){
                                            NeedToCT();

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
                                        NeedToMRI();
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
                                !widget.modelPatient.needToCT && !widget.modelPatient.isNot724 && !widget.modelPatient.needToMRI ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){



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
                                ):
                                Container(),

                                widget.modelPatient.needToCT || widget.modelPatient.needToMRI  ?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                       GoNextPage(context, ScreenFormNIHS((p0) {
                                         Navigator.pop(context);
                                         AddNIHS();
                                       },widget.modelPatient.IsNIHSS));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: widget.modelPatient.IsNIHSS ?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              widget.modelPatient.IsNIHSS ?
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
                                        child: Text( widget.modelPatient.IsNIHSS ?'نمایش فرم NIHSS':'تکمیل فرم NIHSS',
                                          style: TextStyle(
                                              color:widget.modelPatient.IsNIHSS ? ColorApp : Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                      )),
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


