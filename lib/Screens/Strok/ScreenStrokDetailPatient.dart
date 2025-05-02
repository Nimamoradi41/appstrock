import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Screens/Resident/ScreenFormNIHS.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../../test.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/Model/ModelPatient.dart';
import '../Resident/ScreenFormTimeInjection.dart';
import 'ProviderStrok/ProviderStrok.dart';
import 'ScreenFormAddTimeInjection.dart';
import 'ScreenFormLaboratory.dart';



class ScreenStrokDetailPatient extends StatefulWidget {

  ScreenStrokDetailPatient(this.patientItem,this.MainCtx);
  





  ModelPatient patientItem;
  BuildContext MainCtx;

  @override
  State<ScreenStrokDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenStrokDetailPatient> {
  late var Notifi=ProviderStrok();

  Future  RequestAddTimeInjection(String Time)async{

    //
    // ShowLoadingApp(context);
    // // ignore: use_build_context_synchronously
    //  var Data= await ApiServiceResident.TimeOfInjection(widget.patientItem.id.toString(),context,Time,timestamp);
    // Navigator.pop(context);
    // if(Data!=null)
    // {
    //   if(Data.success)
    //   {
    //
    //     Notifi.patientItem!.timeOfInjection=Time;
    //
    //
    //     Notifi.setItem(Notifi.patientItem);
    //
    //
    //     // ignore: use_build_context_synchronously
    //     ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
    //   }else{
    //     // ignore: use_build_context_synchronously
    //     ShowErrorMsg(context, Data.message);
    //   }
    // }

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
    // چاپ تاریخ جلالی با فرمت مورد نظر
    print('تاریخ جلالی فعلی: $formattedDate');

    // // ignore: use_build_context_synchronously
    // var Data= await ApiServiceReception.ListPatientLab(formattedDate,context);
    //
    // if(Data!=null)
    // {
    //   if(Data.success)
    //   {
    //
    //     var finded=Data.data.firstWhere((element) => element.id==widget.patientItem.id);
    //     Notifi.setItem(finded);
    //     Notifi.setLoading(false);
    //   }else{
    //     // ignore: use_build_context_synchronously
    //     ShowErrorMsg(context, Data.message);
    //   }
    // }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoOfPatient();
  }
  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderStrok>(context);
    double wid=MediaQuery.of(context).size.width;
    double hei=MediaQuery.of(context).size.height;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child:
          Notifi.isLoading?
          CircularProgressIndicator():
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:   [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                              ),
                            ),


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
                                              TextApp(Notifi.patientItem.timeOfAddToSystem.isEmpty  ? 'نامشخص':Notifi.patientItem.timeOfAddToSystem, 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان ثبت در سیستم', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(Notifi.patientItem.dateOfAddToSystem == null ? 'نامشخص' : Notifi.patientItem.dateOfAddToSystem!, 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  تاریخ ثبت در سیستم', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                          child: Row(
                                            children: [
                                              TextApp(
                                                  Notifi.patientItem.timeOfInjection!.isEmpty ?
                                              'تکمیل نشده است':
                                                  Notifi.patientItem.timeOfInjection.toString()

                                                  , 16, ColorTextbody, true),
                                              Expanded(child: Align(
                                                  alignment: Alignment.centerRight,
                                                  child: TextApp(' :  زمان تزریق', 14, ColorTitleText, false))),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: wid,
                                          height: 2,
                                          color: Colors.black12,
                                          margin: EdgeInsets.symmetric(horizontal: 8),
                                        ),



                                      ],
                                     ),
                                   ),
                                 ),
                                Notifi.patientItem.timeOfInjection!.isEmpty?
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(4),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        GoNextPage(context, ScreenFormAddTimeInjection((p0) {
                                          var Time=p0[0]['Time'];
                                          RequestAddTimeInjection(Time.toString());
                                        }
                                        ));
                                      },
                                      style: ButtonStyle(
                                          backgroundColor: Notifi.patientItem.labIsComplete ==null?
                                          MaterialStateProperty.all(ColorApp):
                                          Notifi.patientItem.labIsComplete!?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              Notifi.patientItem.labIsComplete ==null?
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ):
                                              Notifi.patientItem.labIsComplete! ?
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
                                        child: Text(
                                          Notifi.patientItem.timeOfInjection == null ?
                                          'تکمیل زمان تزریق':
                                          Notifi.patientItem.timeOfInjection!.isNotEmpty ?
                                          'نمایش زمان تزریق':
                                          'تکمیل زمان تزریق',
                                          style: TextStyle(
                                              color:
                                              Notifi.patientItem.labIsComplete == null ?
                                              Colors.white:
                                              Notifi.patientItem.labIsComplete! ?
                                              ColorApp : Colors.white,
                                              fontSize: 12,
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

              ],
            ),
          ),
        ),
      ),
    );
  }
}


