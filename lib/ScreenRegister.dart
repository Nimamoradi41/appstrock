import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'Constants.dart';
import 'Widgets/TextApp.dart';

class ScreenRegister extends StatefulWidget {


  @override
  State<ScreenRegister> createState() => _ScreenRegisterState();
}

class _ScreenRegisterState extends State<ScreenRegister> {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("فوریت های پزشکی"),value: "1"),
    DropdownMenuItem(child: Text("تریاژ"),value: "2"),
    DropdownMenuItem(child: Text("پذیرش"),value: "3"),
    DropdownMenuItem(child: Text("رزیدنت"),value: "4"),
  ];

  String dropdownValue = 'Dog';

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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: wid*0.2,),
                  SvgPicture.asset('assets/Svg/loginui.svg',width: wid*0.3,height: wid*0.3,),

                  Padding(
                    padding: const EdgeInsets.only(right: 16,top: 16),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: TextApp('ثبت نام', 24, ColorTitleText, true)),
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
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      value: dropdownValue,
                      borderRadius: BorderRadius.circular(1),

                      items:menuItems,
                      // Step 5.
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  // DropdownButton(items: items, onChanged: onChanged)
                  SizedBox(height: 8,),

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
                    width: wid*0.9,
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
                          child: Text('ورود',
                            style: TextStyle(color:Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),),
                        )),
                  ),
                  Spacer(),
                  Spacer(),
                  TextApp('نسخه  1.0.0 ',12, Colors.black54, true),
                  SizedBox(height: 8,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
