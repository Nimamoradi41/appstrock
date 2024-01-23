import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constants.dart';

class ScreenLogin extends StatelessWidget {


  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("فوریت های پزشکی"),value: "1"),
    DropdownMenuItem(child: Text("تریاژ"),value: "2"),
    DropdownMenuItem(child: Text("پذیرش"),value: "3"),
    DropdownMenuItem(child: Text("رزیدنت"),value: "4"),
  ];

  String dropdownValue = 'Dog';

  String dropdownvalue = 'فوریت های پزشکی';

  // List of items in our dropdown menu
  var items = [
    'فوریت های پزشکی',
    'تریاژ',
    'پزیرش',
    'رزیدنت',
    'دکتر متخصص',
  ];



  bool IsLoading=false;
  Future RunLogin(BuildContext context)async{
    ShowLoadingApp(context);
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Center(
        child: Container(
          width: wid,
          color: Colors.redAccent,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                width: wid,
                height: double.infinity,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: wid*0.2,),
                            SvgPicture.asset('assets/Svg/loginui.svg',width: wid*0.3,height: wid*0.3,),
                            Padding(
                              padding: const EdgeInsets.only(right: 16,top: 16),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextApp('ورود', 24, ColorTitleText, true)),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'نام و نام خانوادگی',
                                    labelStyle: TextStyle(
                                        color: ColorApp
                                    ),
                                    counterText: "",

                                    enabledBorder: outlinedBorderBlack,
                                    focusedBorder: outlinedBorderPurple,


                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: TextField(
                                  maxLines: 1,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    labelText: 'کد ملی',
                                    labelStyle: TextStyle(
                                        color: ColorApp
                                    ),
                                    counterText: "",

                                    enabledBorder: outlinedBorderBlack,
                                    focusedBorder: outlinedBorderPurple,


                                  ),
                                ),
                              ),
                            ),











                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32,),

                    Container(
                      width: wid*0.9,
                      child: ElevatedButton(onPressed: (){

                        RunLogin(context);

                      },
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
                            child: Text('ورود',
                              style: TextStyle(color:Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),),
                          )),
                    ),
                    SizedBox(height: 32,),
                    TextApp(VersionApp,12, Colors.black54, true),
                    SizedBox(height: 8,),
                  ],
                ),
              )
          ),
        ),
      ),
    );
  }
}
