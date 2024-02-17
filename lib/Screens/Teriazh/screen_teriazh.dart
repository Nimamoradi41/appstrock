import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import 'ProviderTeraizh.dart';

class Screen_Teriazh extends StatefulWidget {


  @override
  State<Screen_Teriazh> createState() => _Screen_TeriazhState();
}

class _Screen_TeriazhState extends State<Screen_Teriazh> {
  bool status=false;

  var items = [
    'مرد',
    'زن',
  ];

  String dropdownvalue = 'مرد';


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



  late var Notifi=ProviderTeraizh();
  @override
  Widget build(BuildContext context) {
    Notifi=Provider.of<ProviderTeraizh>(context);
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
                                  'تریاژ',
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

                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 4
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                Row(
                                  children: [
                                    SizedBox(width: 8,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Consumer<ProviderTeraizh>(
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
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26,
                                    spreadRadius: 1,
                                    blurRadius: 4
                                )
                              ]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextApp2('اطلاعات بیمار', 18, ColorTitleText, true),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'نام و نام خانوادگی',

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
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'سن',
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
                                        setState(() {
                                          dropdownvalue = value!;
                                        });
                                      },
                                      ),
                                    )),

                                Container(
                                  width: wid,
                                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                  child: ElevatedButton(onPressed: (){},
                                      style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(ColorApp),
                                          padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              )
                                          )
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('اعلان کد',
                                          style: TextStyle(color:Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),),
                                      )),
                                ),
                                SizedBox(height: 8,)
                              ],
                            ),
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

