
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../../Widgets/ItemPatient.dart';
import '../../Widgets/TextApp.dart';
import '../Autentication/screen_EditProfile.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/Model/ModelPatient.dart';
import '../SplashScreen.dart';
import 'ProviderSickCarrier/ProviderSickCarrier.dart';





class ScreenSickCarrier extends StatefulWidget {


  @override
  State<ScreenSickCarrier> createState() => _ScreenSickCarrierState();
}

class _ScreenSickCarrierState extends State<ScreenSickCarrier> {
  bool status=false;

  List<ModelPatient> ItemsP=[];

  var items = [
    'مرد',
    'زن',
  ];

  String dropdownvalue = 'مرد';

  late var Notifi=ProviderSickCarrier();

  Future   ChangShift(bool StatusNew,BuildContext context) async
  {


    var Flag=await ShowAllow(context,'آیا از تغییر شیفت خود مطمئن هستید ؟');
    if(Flag)
    {
      ShowLoadingApp(context);
      // ignore: use_build_context_synchronously
      var Data= await ApiServiceReception.ChangeShiftStatus(context);
      print(Data.toJson());

      if(Data!=null)
      {
        if(Data.success)
        {
          Notifi.setstatus(Data.data!.isOnline);
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }

      Navigator.pop(context);
    }









  }


  Future RunListP(BuildContext context) async
  {
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    // چاپ تاریخ جلالی با فرمت مورد نظر
    print('تاریخ جلالی فعلی: $formattedDate');








    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatient(formattedDate,context);





    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.setItems(Data.data);
      }else{
        showToast(Data.message,
            position: StyledToastPosition.top,
            context:context);
      }
    }
  }


  Future GetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isOnline')!=null)
    {
      status=prefs.getBool('isOnline')!;
      Notifi.setstatus(status);
    }


  }
  late Timer _timer;
  void startTimer() {
    const oneSec =   Duration(seconds: 20);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        RunListP(context);
      },
    );

    GetInfo();
    RunListP(context);

  }
  Future ClearAllDate()async{
    var Flag=await ShowAllow(context,'آیا میخواهید از حساب کاربری خود خارج شوید ؟');
    if(Flag)
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      GoNextPageGameOver(context, SplashScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }


  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderSickCarrier>(context);
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
                          children:   [
                            InkWell(
                              onTap: (){
                                ClearAllDate();
                              },
                              child: RotatedBox(
                                quarterTurns: 90,
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                                ),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 0,
                              child: InkWell(
                                onTap: (){
                                  GoNextPage(context, screen_EditProfile());
                                },
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Icon(Icons.person,color: Colors.white,size: 30,),
                                ),
                              ),
                            ),
                            Expanded(child:
                            Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'بیماربر',
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
                    child: Column(
                      children: [
                        Container(
                          decoration: MainDecoration,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 8,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Consumer<ProviderSickCarrier>(
                                        builder: (context,newstate,child){
                                          status=newstate.status;
                                          return FlutterSwitch(
                                            value: status,
                                            activeColor: Color(0xff38b000),
                                            onToggle: (val) {
                                              Notifi.setstatus(!status);
                                              // setState(() {
                                              //   status = val;
                                              // });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(child: TextApp2('وضعیت شیفت',16,ColorTextsubject,false)),
                                    SizedBox(width: 4 ,)
                                  ],

                                )
                              ],
                            ),
                          ),
                        ),


                        SizedBox(height: 24,),

                        Container(
                          height:  hei*0.68,
                          child: Consumer<ProviderSickCarrier>(
                            builder: (context,newstate,child){
                              ItemsP=newstate.ListItemsPatient;
                              return ListView.builder(
                                itemCount: ItemsP.length,
                                itemBuilder: (ctx,item){
                                  return ItemPatientNew(wid: wid, ItemsP: ItemsP[item],);
                                  // return Container();
                                },
                              );
                            },

                          ),
                        ),






                      ],
                    ),
                  ),
                ),


                Positioned(
                    bottom: 8,
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
