
import 'package:appstrock/Screens/Autentication/ApiServiceAutentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';

class ScreenRigester extends StatefulWidget {


  @override
  State<ScreenRigester> createState() => _ScreenRigesterState();
}

class _ScreenRigesterState extends State<ScreenRigester> {




  int CounterStatus=1;
  String dropdownvalue = 'فوریت های پزشکی';




  var items = [
    'فوریت های پزشکی',
    'تریاژ',
    'پزیرش',
    'رزیدنت',
    'بیماربر',
    'آزمایشگاه',
    'استروک',
    'دکتر متخصص',
  ];



  bool IsLoading=false;
  Future RunRegister(BuildContext context)async{

    if(textControllerName.text.isEmpty)
      {
        showToast("نام و نام خانوادگی را وارد کنید",
            position: StyledToastPosition.top,
            context:context);
        return;
      }

    if(textControllerNationalCode.text.isEmpty)
    {
      showToast("کدملی را وارد کنید",
          position: StyledToastPosition.top,
          context:context);
      return;
    }

    if(textControllerNationalCode.text.length!=10)
    {
      showToast("کدملی اشتباه است",
          position: StyledToastPosition.top,
          context:context);
      return;
    }


    if(textControllerPhoneNumber.text.isEmpty)
    {
      showToast("شماره تلفن را وارد کنید",
          position: StyledToastPosition.top,
          context:context);
      return;
    }

    if(!textControllerPhoneNumber.text.startsWith('0'))
    {
      showToast("شماره تلفن اشتباه است",
          position: StyledToastPosition.top,
          context:context);
      return;
    }

    if(textControllerPhoneNumber.text.length<11)
    {
      showToast("شماره تلفن اشتباه است",
          position: StyledToastPosition.top,
          context:context);
      return;
    }


    int TypUser= await GetTypeUser(dropdownvalue);
    ShowLoadingApp(context);
    await Future.delayed(Duration(seconds: 3));
    var Data=ApiServiceAutentication.Rigester(textControllerName.text, TypUser.toString(), textControllerNationalCode.text, textControllerPhoneNumber.text, context);




  }


  var textControllerName=TextEditingController();
  var textControllerNationalCode=TextEditingController();
  var textControllerPhoneNumber=TextEditingController();
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
                                child: TextApp('ثبت نام', 24, ColorTitleText, true)),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                maxLines: 1,
                                controller: textControllerName,
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
                                controller: textControllerNationalCode,
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
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: DropdownButtonFormField(
                                  value: dropdownvalue,
                                  decoration: InputDecoration(
                                    enabledBorder: outlinedBorderBlack,
                                    focusedBorder: outlinedBorderPurple,
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                maxLines: 1,
                                maxLength: 11,
                                controller: textControllerPhoneNumber,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  labelText: 'شماره تلفن',
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

                      RunRegister(context);

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
                          child: Text('ثبت نام',
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
