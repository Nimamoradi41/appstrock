import 'dart:async';

import 'package:appstrock/Screens/Reception/ApiServiceReception.dart';
import 'package:appstrock/Screens/Reception/ProviderReception/ProviderReception.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants.dart';
import '../../Widgets/ItemPatient.dart';
import '../../Widgets/TextApp.dart';
import '../Autentication/screen_EditProfile.dart';
import '../Reception/Model/ModelPatient.dart';
import '../SplashScreen.dart';
import 'ScreenDetailPatient.dart';





class ScreenResident extends StatefulWidget {




   BuildContext MainContext;


   ScreenResident(this.MainContext);

  @override
  State<ScreenResident> createState() => _ScreenResidentState();
}

class _ScreenResidentState extends State<ScreenResident> {
  bool status=false;

  List<ModelPatient> ItemsP=[];

  var items = [
    'مرد',
    'زن',
  ];

  String dropdownvalue = 'مرد';

  late var Notifi=ProviderReception();


  Future RunListP(BuildContext context) async
  {
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';

    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatient(formattedDate,context);


    if(Data!=null)
    {
      if(Data.success)
      {
        Notifi.setItems(Data.data);
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }








  late Timer _timer;


  double FinalTime=0;
  void startTimer() {
    const oneSec =   Duration(seconds: 20);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
            RunListP(widget.MainContext);
      },
    );

    GetInfo();
    RunListP(widget.MainContext);

  }



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


  Future GetInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.getBool('isOnline')!=null)
    {
      status=prefs.getBool('isOnline')!;
      Notifi.setstatus(status);
    }

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
    GetInfo();
  }


  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderReception>(context);
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
                      SizedBox(width: 16,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: (){
                                ClearAllDate();
                              },
                              child: const RotatedBox(
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
                            const Expanded(child:
                            Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'رزیدنت',
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
                                      child: Consumer<ProviderReception>(
                                        builder: (context,newstate,child){
                                          status=newstate.status;
                                          return FlutterSwitch(
                                            value: status,
                                            activeColor: Color(0xff38b000),
                                            onToggle: (val) {
                                              ChangShift(val,context);
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
                          child: Consumer<ProviderReception>(
                            builder: (context,newstate,child){
                              ItemsP=newstate.ListItemsPatient;
                              print('Count ');
                              print(ItemsP.length.toString());
                              return ListView.builder(
                                itemCount: ItemsP.length,
                                itemBuilder: (ctx,item){
                                  return InkWell(
                                      onTap: (){
                                        GoNextPage(context,ScreenDetailPatient(ItemsP[item],context));
                                      },
                                      child: ItemPatientNew(wid: wid,ItemsP: ItemsP[item],));
                                },
                              );
                            },

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
