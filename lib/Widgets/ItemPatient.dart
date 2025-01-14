import 'package:appstrock/Screens/Reception/Model/ModelPatient.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import 'TextApp.dart';


class ItemPatient extends StatelessWidget {
  const ItemPatient({
    super.key,
    required this.wid,
    // required this.ItemsP,
  });
  //
  final double wid;
  // final ModelPatient ItemsP;

  @override
  Widget build(BuildContext context) {
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
                        // TextApp(ItemsP.age.toString().isEmpty?'نامشخص':ItemsP.age.toString(), 12, ColorTextbody, true),
                        TextApp('26', 12, ColorTextbody, true),
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
                        // TextApp(ItemsP.gender.toString().isEmpty?'نامشخص':ItemsP.gender.toString() , 12, ColorTextbody, true),
                        TextApp('مرد' , 12, ColorTextbody, true),
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
                    // TextApp( ItemsP.fullName, 14, ColorTextbody, true),
                    TextApp( 'نیما مرادی', 14, ColorTextbody, true),
                    SizedBox(height: 4,),
                    TextApp('17418848', 12, ColorTitleText, true),
                    // TextApp(ItemsP.nationalCode.toString().isEmpty?': کد ملی '+'نامشخص':': کد ملی '+ItemsP.nationalCode.toString(), 12, ColorTitleText, true),
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
  }
}

class ItemPatientNew extends StatelessWidget {
  const ItemPatientNew({
    super.key,
    required this.wid,
    required this.ItemsP,
  });
  //
  final double wid;
  final ModelPatient ItemsP;

  @override
  Widget build(BuildContext context) {
    print(ItemsP.nationalCode.toString());
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
                        TextApp(ItemsP.age.toString().isEmpty?'نامشخص':ItemsP.age.toString(), 12, ColorTextbody, true),
                        // TextApp('26', 12, ColorTextbody, true),
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
                        TextApp(ItemsP.gender.toString() , 12, ColorTextbody, true),
                        // TextApp('مرد' , 12, ColorTextbody, true),
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
                    TextApp( ItemsP.fullName, 14, ColorTextbody, true),
                    // TextApp( 'نیما مرادی', 14, ColorTextbody, true),
                    SizedBox(height: 4,),
                    // TextApp('17418848', 12, ColorTitleText, true),
                    TextApp(ItemsP.nationalCode.toString().isEmpty?': کد ملی '+'نامشخص':'  کد ملی : '+ItemsP.nationalCode.toString(), 12, ColorTitleText, true),
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
  }
}
