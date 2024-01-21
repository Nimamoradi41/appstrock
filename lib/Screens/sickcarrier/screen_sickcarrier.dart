import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';


class ScreenSickCarrier extends StatefulWidget {


  @override
  State<ScreenSickCarrier> createState() => _ScreenSickCarrierState();
}

class _ScreenSickCarrierState extends State<ScreenSickCarrier> {
  bool status=false;

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
                                Row(children: [
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp2(' : کدملی',14,ColorTextsubject,false),
                                        TextApp2('174875455445',16,ColorTextbody,true),

                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8,),
                                  Container(
                                    width: 1,
                                    color: Colors.black38,
                                    height: 20,
                                  ),
                                  SizedBox(width: 8,),


                                  Expanded(
                                    flex: 6,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TextApp2(' : نام ونام خانوادگی',14,ColorTextsubject,false),
                                        TextApp2('نیما مرادی',16,ColorTextbody,true),

                                      ],
                                    ),
                                  ),
                                ],),
                                SizedBox(height: 4,),
                                Container(
                                  width: wid,
                                  margin: EdgeInsets.all(8),
                                  color: Colors.black12,
                                  height: 1,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 8,),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FlutterSwitch(
                                        value: status,
                                        activeColor: Color(0xff38b000),
                                        onToggle: (val) {
                                          setState(() {
                                            status = val;
                                          });
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
                          child: ListView.builder(
                            itemCount: 6,
                            itemBuilder: (ctx,item){
                              return Container(
                                width: wid,
                                margin: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 1,
                                          spreadRadius: 1,

                                          offset: Offset(0,0)
                                      )
                                    ]
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(child: Row(
                                        children: [
                                          Expanded(child:
                                          Row(
                                            children: [
                                              SizedBox(width: 8,),
                                              Column(
                                                children: [
                                                  TextApp('سن', 10, ColorTitleText, false),
                                                  SizedBox(height: 4,),
                                                  TextApp('نامشخص', 12, ColorTextbody, true),
                                                ],
                                              ),
                                              SizedBox(width: 12,),
                                              Container(
                                                width: 1,
                                                height: 30,
                                                color: Colors.black38,
                                              ),
                                              SizedBox(width: 12,),
                                              Column(
                                                children: [
                                                  TextApp('جنسیت', 10, ColorTitleText, false),
                                                  SizedBox(height: 4,),
                                                  TextApp('مرد', 12, ColorTextbody, true),
                                                ],
                                              ),
                                              SizedBox(width: 8,),
                                            ],
                                          )
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              TextApp('نیما مرادی', 14, ColorTextbody, true),
                                              SizedBox(height: 4,),
                                              TextApp(' کد ملی : نامشخص', 12, ColorTitleText, true),
                                            ],
                                          )
                                        ],
                                      )),
                                      SizedBox(width: 12,),
                                      Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.rectangle,
                                              borderRadius: BorderRadius.circular(6),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 1,
                                                    spreadRadius: 1,

                                                    offset: Offset(0,0)
                                                ),
                                              ]
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Icon(Icons.person,size: 35,color: Colors.blueAccent,),
                                          )),
                                      SizedBox(width: 1,)
                                    ],
                                  ),
                                ),
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
                    child: TextApp('نسخه  1.0.0', 12, Colors.black54, true))


              ],
            ),
          ),
        ),
      ),
    );
  }
}
