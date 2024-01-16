
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';

class ScreenEms extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
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
                                'فوریت های پزشکی',
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
                    width: wid*0.8,
                    height: wid*0.25,
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
                          Expanded(child: Row(
                          children: [
                            Expanded(
                                flex: 8,
                                child: TextApp2('نیما مرادی',16,ColorTextbody,true)),
                            Expanded(
                                flex: 3,
                                child: TextApp2(' : نام ونام خانوادگی',14,ColorTextsubject,false)),
                          ],

                          )),
                          SizedBox(height: 4,),

                          Expanded(child: Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: TextApp2('1742778887',14,ColorTextbody,true)),
                              Expanded(
                                  flex: 2,
                                  child: TextApp2(' : کد ملی',16,ColorTextsubject,false)),
                            ],

                          )),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: wid*0.43,
                  right: 16,
                  left: 16,
                  child: Container(
                    width: wid*0.8,
                    height:wid*0.85 ,
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
                          Spacer(),
                          Container(
                            width: wid,
                            margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
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
