import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Reception/Model/ModelPatient.dart';
import 'ProviderAtend/ProviderAtendDetaile.dart';




class ScreenDetailPatientAtend extends StatefulWidget {

  ScreenDetailPatientAtend(this.modelPatient,this.MainCtx);
  





  ModelPatient modelPatient;
  BuildContext MainCtx;

  @override
  State<ScreenDetailPatientAtend> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenDetailPatientAtend> {
  late var Notifi=ProviderAtendDetaile();

  // Future NeedToCT(BuildContext context)async{











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
                                    Expanded(child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp('کدملی', 12, ColorTitleText, false),
                                        SizedBox(height: 8,),
                                        TextApp(widget.modelPatient.nationalCode.isEmpty
                                            ? 'نامشخص':widget.modelPatient.nationalCode, 14, ColorTextbody, true)
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
                                          margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
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
                                                  child: TextApp(' :  زمان شروع علائم ', 14, ColorTitleText, false))),
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
                                                  child: TextApp(' :  زمان تکمیل NIHSS ', 14, ColorTitleText, false))),
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
                                                  child: TextApp(' :  زمان تکمیل آزمایش ', 14, ColorTitleText, false))),
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
                                                  child: TextApp(' :  زمان اعلان کد ', 14, ColorTitleText, false))),
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
                                                  child: TextApp(' :  وضعیت بیمار ', 14, ColorTitleText, false))),
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
                                                  child: TextApp(' :  وضعیت بیمار ', 14, ColorTitleText, false))),
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
                                                  child: TextApp(' :  زمان اتمام ', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),

                                      ],
                                     ),
                                   ),
                                 ),
                                !widget.modelPatient.needToCT && !widget.modelPatient.isNot724 && !widget.modelPatient.needToMRI ?
                                Row(
                                  children: [
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Container(
                                        width: wid,
                                        margin: const EdgeInsets.all(8),
                                        child: ElevatedButton(
                                            onPressed: (){

                                            },
                                            style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.all(Colors.white),
                                                padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        side:  const BorderSide(color: ColorApp,width: 2)
                                                    )
                                                )
                                            ),
                                            child:const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text('NIHSS',
                                                style: TextStyle(
                                                    color:
                                                    ColorApp,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),),
                                            )),
                                      ),
                                    )),
                                    Expanded(child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                                      child: Container(
                                        width: wid,
                                        margin: const EdgeInsets.all(8),
                                        child: ElevatedButton(
                                            onPressed: (){

                                            },
                                            style: ButtonStyle(
                                                backgroundColor:MaterialStateProperty.all(Colors.white),
                                                padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        side:  const BorderSide(color: ColorApp,width: 2)
                                                    )
                                                )
                                            ),
                                            child:const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text('آزمایش',
                                                style: TextStyle(
                                                    color:
                                                    ColorApp,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),),
                                            )),
                                      ),
                                    ))
                                  ],
                                ) :Container(),







                                widget.modelPatient.ResonNot == null ?Container():
                                widget.modelPatient.ResonNot!.isNotEmpty?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:MaterialStateProperty.all(Colors.white),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side:  const BorderSide(color: ColorApp,width: 2)
                                              )
                                          )
                                      ),
                                      child:const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('عکس های ارسال شده رزیدنت',
                                          style: TextStyle(
                                              color:
                                              ColorApp,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ):Container(),
                                


                                widget.modelPatient.ResonNot == null ?Container():
                                widget.modelPatient.ResonNot!.isNotEmpty?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                      onPressed: (){

                                      },
                                      style: ButtonStyle(
                                          backgroundColor:MaterialStateProperty.all(Colors.white),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  side:  const BorderSide(color: ColorApp,width: 2)
                                              )
                                          )
                                      ),
                                      child:const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text('نمایش دلیل رزیدنت',
                                          style: TextStyle(
                                              color:
                                              ColorApp,
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


