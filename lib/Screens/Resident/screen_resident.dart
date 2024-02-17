import 'package:appstrock/Screens/Reception/ApiServiceReception.dart';
import 'package:appstrock/Screens/Reception/ProviderReception/ProviderReception.dart';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../../Constants.dart';
import '../../Widgets/ItemPatient.dart';
import '../../Widgets/TextApp.dart';
import '../Reception/Model/ModelPatient.dart';
import 'ScreenDetailPatient.dart';





class ScreenResident extends StatelessWidget {


  bool status=false;


  List<ModelPatient> ItemsP=[];
  var items = [
    'مرد',
    'زن',
  ];
  String dropdownvalue = 'مرد';
  late var Notifi=ProviderReception();

  ScreenResident(this.MainContext){
    RunListP(MainContext,false);
  }

  BuildContext MainContext;


  Future RunListP(BuildContext context,bool refresh) async
  {
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';








    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatient(formattedDate,context,refresh);




    print(Data.toJson());

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

  Future   ChangShift(bool StatusNew,BuildContext context) async
  {
    var Flag=await ShowAllow(context,'آیا از تغییر شیفت خود مطمئن هستید ؟');
    if(Flag)
    {
      ShowLoadingApp(context);
      await Future.delayed(Duration(seconds: 3));
      Notifi.setstatus(StatusNew);
      Navigator.pop(context);
    }
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
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 16,),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            RotatedBox(
                              quarterTurns: 90,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 0,
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Icon(Icons.person,color: Colors.white,size: 30,),
                              ),
                            ),
                            Expanded(child:
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
                              return ListView.builder(
                                itemCount: ItemsP.length,
                                itemBuilder: (ctx,item){
                                  // return ItemPatient(wid: wid, ItemsP: ItemsP[item],);
                                  return InkWell(
                                      onTap: (){
                                        GoNextPage(context,ScreenDetailPatient(ItemsP[item],context));
                                      },
                                      child: ItemPatient(wid: wid));
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
