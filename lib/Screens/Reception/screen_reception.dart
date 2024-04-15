import 'package:appstrock/Screens/Reception/ApiServiceReception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import '../../Constants.dart';
import '../../Widgets/ItemPatient.dart';
import '../../Widgets/TextApp.dart';
import 'Model/ModelPatient.dart';
import 'ProviderReception/ProviderReception.dart';



class ScreenReception extends StatefulWidget {







  ScreenReception( );

  @override
  State<ScreenReception> createState() => _ScreenReceptionState();
}

class _ScreenReceptionState extends State<ScreenReception> {
  late HubConnection connection;

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

  bool status=false;




  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        double wid=MediaQuery.of(context).size.width;
        double hei=MediaQuery.of(context).size.height;
        wid=wid>600?600:wid;
        return Scaffold(
          backgroundColor: Colors.transparent ,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: wid,
                margin: EdgeInsets.all(8),
                decoration: MainDecoration,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: TextApp2('نیما مرادی',14,ColorTextbody,true)),
                          SizedBox(width: 16,),
                          TextApp(' : نام ونام خانوادگی',14,ColorTitleText,false),
                          SizedBox(width: 8,),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.black45,
                        margin: EdgeInsets.all(8),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: 'کد ملی',
                              disabledBorder:OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),

                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: TextApp('سن',14,ColorTitleText,false),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                    decoration: InputDecoration(

                                      disabledBorder:OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8)
                                      ),

                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: TextApp('جنسیت',14,ColorTitleText,false),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:   BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                                        ),
                                        // Initial Value
                                        // Down Arrow Icon


                                        // Array list of items

                                        // After selecting the desired option,it will
                                        // change button value to selected value

                                      ),
                                      items: items.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                items,),
                                            ],
                                          ),
                                        );
                                      }).toList()
                                      , onChanged: (String? value) {
                                      // setState(() {
                                      //   dropdownvalue = value!;
                                      // });
                                    },
                                    ),
                                  )),
                            ],
                          ))
                        ],
                      ),

                      SizedBox(height: 50,),
                      Container(
                        width: wid*0.9,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                              },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                                      padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),

                                          )
                                      )
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('بستن',
                                      style: TextStyle(color:Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                  )),
                            ),
                            SizedBox(width: 16,),
                            Expanded(
                              child: ElevatedButton(onPressed: (){},
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colorbutton),
                                      padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8.0),

                                          )
                                      )
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text('تکمیل اطلاعات',
                                      style: TextStyle(color:Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16,),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  List<ModelPatient> ItemsP=[];

  var items = [
    'مرد',
    'زن',
  ];

  String dropdownvalue = 'مرد';

  late var Notifi=ProviderReception();

  Future RunListP(BuildContext context,bool refresh) async
  {
    Jalali date=Jalali.now();
    String formattedDate =
        '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
    // چاپ تاریخ جلالی با فرمت مورد نظر
    print('تاریخ جلالی فعلی: $formattedDate');








    // ignore: use_build_context_synchronously
    var Data= await ApiServiceReception.ListPatient(formattedDate,context,refresh);





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



  @override
  void initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
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
                                  'پذیرش',
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
                              // ItemsP=newstate.ListItemsPatient;
                              return ListView.builder(
                                // itemCount: ItemsP.length,
                                itemCount: 2,
                                itemBuilder: (ctx,item){
                                  return InkWell(
                                    onTap: (){
                                      _showAlertDialog(context);
                                    },
                                    child: ItemPatient(wid: wid,),
                                    // child: ItemPatient(wid: wid),
                                  );
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





