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
import 'ProviderLaboratory/ProviderLaboratoryDetail.dart';
import 'ScreenFormLaboratory.dart';



class ScreenLaboratoryDetailPatient extends StatefulWidget {

  ScreenLaboratoryDetailPatient(this.patientItem,this.MainCtx);
  





  ModelPatient patientItem;
  BuildContext MainCtx;

  @override
  State<ScreenLaboratoryDetailPatient> createState() => _ScreenDetailPatientState();
}

class _ScreenDetailPatientState extends State<ScreenLaboratoryDetailPatient> {
  late var Notifi=ProviderLaboratoryDetail();

  // Future NeedToCT(BuildContext context)async{












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

      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }



  Future getInfoOfPatient()async{
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    // چاپ تاریخ جلالی با فرمت مورد نظر
    print('تاریخ جلالی فعلی: $formattedDate');

    // ignore: use_build_context_synchronously
    // var Data= await ApiServiceReception.ListPatientLab(formattedDate,context);
    //
    // if(Data!=null)
    // {
    //   if(Data.success)
    //   {
    //
    //     var finded=Data.data.firstWhere((element) => element.id==widget.patientItem.id);
    //     Notifi.setItems(finded);
    //     Notifi.setLoading(false);
    //   }else{
    //     // ignore: use_build_context_synchronously
    //     ShowErrorMsg(context, Data.message);
    //   }
    // }
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

      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfoOfPatient();
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
                                        TextApp(Notifi.patientItem.nationalCode.isEmpty  ? 'نامشخص':widget.patientItem.nationalCode, 14, ColorTextbody, true)
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
                                        TextApp(Notifi.patientItem.fullName.isEmpty  ? 'نامشخص':widget.patientItem.fullName, 14, ColorTextbody, true)
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
                                Container(
                                  width: wid,
                                  margin: const EdgeInsets.all(4),
                                  child: ElevatedButton(
                                      onPressed: (){
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
                                      style: ButtonStyle(
                                          backgroundColor: Notifi.patientItem.labIsComplete ==null?
                                          MaterialStateProperty.all(ColorApp):
                                          Notifi.patientItem.labIsComplete!?
                                          MaterialStateProperty.all(Colors.white):
                                          MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(4)),
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
                                          Notifi.patientItem.labIsComplete == null ?
                                          'تکمیل فرم':
                                          Notifi.patientItem.labIsComplete! ?
                                          'نمایش فرم':
                                          'تکمیل فرم',
                                          style: TextStyle(
                                              color:
                                              Notifi.patientItem.labIsComplete == null ?
                                              Colors.white:
                                              Notifi.patientItem.labIsComplete! ?
                                              ColorApp : Colors.white,
                                              fontSize: 12,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}


