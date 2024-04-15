import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constants.dart';
import '../Ems/screen_ems.dart';
import '../Reception/screen_reception.dart';
import 'ApiServiceAutentication.dart';

class ScreenLogin extends StatefulWidget {






  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String dropdownvalue = 'فوریت های پزشکی';

  // List of items in our dropdown menu
  var items = [
    'فوریت های پزشکی',
    'تریاژ',
    'پذیرش',
    'بیماربر',
    'دکتر متخصص',
    'آزماشیگاه',
    'رزیدنت',
    // 'رزیدنت',
    // 'دکتر متخصص',
  ];

  bool IsLoading=false;

  Future RunLogin(BuildContext context)async{
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



    ShowLoadingApp(context);
    var Data=await ApiServiceAutentication.
    Login(textControllerName.text,textControllerNationalCode.text,context);
    // Login('Nimaa','111111111',context);
    if(Data!=null)
    {
      if(Data.success)
      {
        // if(Data.data.departmentId==1)
        if(Data.data!.departmentId==36)
        {
          // ignore: use_build_context_synchronously
          GoNextPage(context,ScreenEms());
        }

        if(Data.data?.departmentId==2)
        // if(Data.data.departmentId==36)
        {
          // ignore: use_build_context_synchronously
          GoNextPage(context,Screen_Teriazh());
        }

        if(Data.data?.departmentId==3)
        {
          // ignore: use_build_context_synchronously
          GoNextPage(context,ScreenReception());
        }

      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context,Data.message);
      }
    }
  }

  var textControllerName=TextEditingController();

  var textControllerNationalCode=TextEditingController();

  @override
  void initState() {
    super.initState();
    textControllerName.text="test";
    textControllerNationalCode.text="8888888888";
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
                                  controller: textControllerName,
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
                                  controller: textControllerNationalCode,
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
