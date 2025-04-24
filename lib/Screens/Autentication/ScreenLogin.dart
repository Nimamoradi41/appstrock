import 'package:appstrock/Screens/Atend/ScreenAtend.dart';
import 'package:appstrock/Screens/Autentication/ScreenRigester.dart';
import 'package:appstrock/Screens/Resident/screen_resident.dart';
import 'package:appstrock/Screens/Strok/ScreenStrock.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:appstrock/Screens/sickcarrier/screen_sickcarrier.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Constants.dart';
import '../Ems/screen_ems.dart';
import '../Laboratory/screen_Laboratory.dart';
import '../Reception/screen_reception.dart';
import 'ApiServiceAutentication.dart';

class ScreenLogin extends StatefulWidget {
  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  String dropdownvalue = 'فوریت های پزشکی';
  var items = [
    'فوریت های پزشکی',
    'تریاژ',
    'پذیرش',
    'بیماربر',
    'دکتر متخصص',
    'آزمایشگاه',
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
    Login(textControllerName.text,
        textControllerNationalCode.text,
        textControllerNationalPass.text,context);
    if(Data!=null)
    {
      if(Data.success)
      {

        await  LoginInApp(textControllerName.text,
            textControllerNationalCode.text,Data.data!.departmentId,
            true,
            textControllerNationalPass.text,Data.data!.id.toString(),Data.data!.isOnline);
        if(Data.data!.departmentId==1)
        {

          // ignore: use_build_context_synchronously
          GoNextPage(context,ScreenEms(false));
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

        if(Data.data?.departmentId==4)
        {
          // ignore: use_build_context_synchronously
          GoNextPage(context,ScreenSickCarrier());
        }
        if(Data.data?.departmentId==8)
        {
          // ignore: use_build_context_synchronously
          GoNextPage(context,ScreenStrock());
        }

        if(Data.data?.departmentId==7)
        {
          GoNextPage(context,ScreenResident(context));
        }
        if(Data.data?.departmentId==6)
        {
          // ignore: use_build_context_synchronously
          GoNextPageGameOver(context,ScreenLaboratory());
        }

        if(Data.data?.departmentId==5)
        {
          // ignore: use_build_context_synchronously
          GoNextPageGameOver(context,ScreenAtend());
        }

        if(Data.data?.departmentId==8)
        {
          // ignore: use_build_context_synchronously
          GoNextPageGameOver(context,ScreenStrock());
        }

      }else{
        ShowErrorMsg(context,Data.message);
      }
    }
  }

  var textControllerName=TextEditingController();

  var textControllerNationalCode=TextEditingController();
  var textControllerNationalPass=TextEditingController();

  @override
  void initState() {
    super.initState();
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
              body: SizedBox(
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
                              child:
                              Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextAppEnd(
                                        'نام کاربری',14, ColorApp,false),
                                      )  ,
                                    SizedBox(height: 8),  // فاصله بین عنوان و فیلد
                                TextField(
                                  controller: textControllerName,
                                  style: const TextStyle(
                                    fontFamily: 'rob',
                                    fontSize: 13,
                                  ),
                                  textAlign:   TextAlign.left,
                                  textDirection:  TextDirection.ltr,
                                  keyboardType: TextInputType.text,
                                  inputFormatters: [
                                    // فقط حروف انگلیسی و اعداد و کاراکترهای خاص مجاز هستند
                                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.,?!@# ]')), // فقط حروف انگلیسی و اعداد
                                  ],
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(
                                      color: ColorApp,
                                    ),
                                    counterText: "",
                                    enabledBorder: outlinedBorderBlack,
                                    focusedBorder: outlinedBorderPurple,
                                  )
                                )
                                  ],
                                ),
                              )
                            ),
                            SizedBox(height: 8,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextAppEnd(
                                        'کد ملی',14, ColorApp,false),
                                  ),
                                  TextField(
                                    maxLines: 1,
                                    maxLength: 10,
                                    textDirection: TextDirection.ltr, // جهت کلی متن
                                    textAlign: TextAlign.left, // متن ورودی راست‌چین باشد
                                    keyboardType: TextInputType.phone,
                                    controller: textControllerNationalCode,
                                    style: const TextStyle(
                                        fontSize: 13
                                    ),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          color: ColorApp
                                      ),
                                      counterText: "",
                                      enabledBorder: outlinedBorderBlack,
                                      focusedBorder: outlinedBorderPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:  Container(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextAppEnd(
                                          'رمز عبور',14, ColorApp,false),
                                    )  ,
                                    SizedBox(height: 8),  // فاصله بین عنوان و فیلد
                                    TextField(
                                        controller: textControllerName,
                                        style: const TextStyle(
                                          fontFamily: 'rob',
                                          fontSize: 13,
                                        ),
                                        textAlign:   TextAlign.left,
                                        textDirection:  TextDirection.ltr,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [
                                          // فقط حروف انگلیسی و اعداد و کاراکترهای خاص مجاز هستند
                                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9.,?!@# ]')), // فقط حروف انگلیسی و اعداد
                                        ],
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                            color: ColorApp,
                                          ),
                                          counterText: "",
                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,
                                        )
                                    )
                                  ],
                                ),
                              )
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
                              padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  )
                              )
                           ),
                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ورود',
                              style: TextStyle(color:Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),),
                          )),
                    ),
                    SizedBox(height: 16,),
                    InkWell(
                        onTap: (){
                          GoNextPage(context, ScreenRigester());
                        },
                        child: TextApp('ثبت نام نکرده اید ؟', 16, Colors.black54, true)),
                    SizedBox(height: 32,),

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
