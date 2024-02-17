import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Reception/Model/ModelPatient.dart';
import 'ProviderLaboratory/ProviderLaboratoryDetail.dart';
import 'ScreenFormLaboratory.dart';



class ScreenLaboratoryDetailPatient extends StatefulWidget {

  ScreenLaboratoryDetailPatient(this.modelPatient,this.MainCtx);
  





  ModelPatient modelPatient;
  BuildContext MainCtx;

  @override
  State<ScreenLaboratoryDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenLaboratoryDetailPatient> {
  late var Notifi=ProviderLaboratoryDetail();

  // Future NeedToCT(BuildContext context)async{









  Future AddLab()async{
    ShowLoadingApp(context);
    await Future.delayed(Duration(seconds: 2));
    widget.modelPatient.IsLab=true;
    Notifi.setItems(widget.modelPatient);
    Navigator.pop(context);
    // ignore: use_build_context_synchronously
    ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');

  }




  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderLaboratoryDetail>(context);
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
                                              TextApp(widget.modelPatient.dateOfAddToSystem == null ? 'نامشخص' : widget.modelPatient.dateOfAddToSystem!, 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  تاریخ ثبت در سیسیتم', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: wid,
                                          height: 2,
                                          color: Colors.black12,
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              // TextApp(widget.modelPatient.timeOfAddLabotory.isEmpty  ? 'ارسال نشده':widget.modelPatient.timeOfAddLabotory, 16, ColorTextbody, true),
                                              TextApp('', 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان ارسال فرم آزمایشگاه', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),


                                      ],
                                     ),
                                   ),
                                 ),
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                       GoNextPage(context, ScreenFormLaboratory((p0) {
                                         Navigator.pop(context);
                                         AddLab();
                                       },widget.modelPatient.IsLab==null? false:widget.modelPatient.IsLab!));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: widget.modelPatient.IsLab ==null?
                                          MaterialStateProperty.all(ColorApp):
                                          widget.modelPatient.IsLab!?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              widget.modelPatient.IsLab ==null?
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ):
                                              widget.modelPatient.IsLab! ?
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
                                        child: Text(
                                          widget.modelPatient.IsLab == null ?
                                          'تکمیل فرم':
                                          widget.modelPatient.IsLab! ?
                                          'نمایش فرم':
                                          'تکمیل فرم',
                                          style: TextStyle(
                                              color:
                                              widget.modelPatient.IsLab == null ?
                                              Colors.white:
                                              widget.modelPatient.IsLab! ?
                                              ColorApp : Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ),
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


