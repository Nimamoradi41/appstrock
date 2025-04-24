
import 'package:appstrock/Screens/Autentication/ApiServiceAutentication.dart';
import 'package:appstrock/Screens/Ems/screen_ems.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import 'ScreenCodeOtp.dart';

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
    // 'پذیرش',
    // 'بیماربر',
    'دکتر متخصص',
    // 'آزمایشگاه',
    'رزیدنت',
    // 'استروک',
    // 'تصویر برداری',
    // 'سوپروایزور',
  ];



  bool IsLoading=false;
  Future RunRegister(BuildContext context)async{
    // GoNextPage(context,ScreenEms(true,context,'نیما مرادی احدی میسلیمانی','1234567894'));
    if(textControllerName.text.isEmpty)
      {
        ShowErrorMsg(context,'نام و نام خانوادگی را وارد کنید');
        return;
      }

    if(textControllerNationalCode.text.isEmpty)
    {

      ShowErrorMsg(context,'کدملی را وارد کنید');
      return;
    }

    if(textControllerNationalCode.text.length!=10)
    {
      ShowErrorMsg(context,'کدملی اشتباه است');
      return;
    }


    var check=checkMeliCode(textControllerNationalCode.text.toString());
    if(!check)
      {
        ShowErrorMsg(context,'کدملی اشتباه است');
        return;
      }


    if(textControllerPhoneNumber.text.isEmpty)
    {
      ShowErrorMsg(context,'شماره تلفن را وارد کنید');
      return;
    }

    if(!textControllerPhoneNumber.text.startsWith('0'))
    {
      ShowErrorMsg(context,'شماره تلفن اشتباه است');
      return;
    }

    if(textControllerNationalCode.text.length<10||textControllerNationalCode.text.length>10)
    {

      ShowErrorMsg(context,'کد ملی اشتباه است');
      return;
    }

    if(textControllerPhoneNumber.text.length<11)
    {

      ShowErrorMsg(context,'شماره تلفن اشتباه است');
      return;
    }

    if(!textControllerPhoneNumber.text.startsWith("09"))
    {
      ShowErrorMsg(context,'شماره تلفن اشتباه است');
      return;
    }





    if(textControllerPassWord.text.isEmpty)
    {
      ShowErrorMsg(context,'رمز عبور را وارد کنید');
      return;
    }


    int TypUser= await GetTypeUser(dropdownvalue);
    ShowLoadingApp(context);





    // ignore: use_build_context_synchronously
    var Data=await ApiServiceAutentication.Rigester(textControllerName.text,
        TypUser.toString(),
        textControllerNationalCode.text,
        textControllerPhoneNumber.text,textControllerPassWord.text, context);







     if(Data!=null)
      {
        if(Data.success)
          {
            // ignore: use_build_context_synchronously
            GoNextPage(context,ScreenCodeOtp(
                textControllerPhoneNumber.text.toString()
                ,textControllerName.text.toString()
                ,textControllerNationalCode.text.toString()
                ,TypUser
                ,textControllerPassWord.text.toString()
                ,Data.data!.id.toString()));
          }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context,Data.message);
        }
      }



  }
  var textControllerName=TextEditingController();
  var textControllerNationalCode=TextEditingController();
  var textControllerPhoneNumber=TextEditingController();
  var textControllerPassWord=TextEditingController();






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
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextAppEnd(
                                      'شماره تلفن',14, ColorApp,false),
                                ),
                                TextField(
                                  maxLines: 1,
                                  maxLength: 11,
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

                      RunRegister(context);

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
                          child: Text('ثبت نام',
                            style: TextStyle(color:Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),),
                        )),
                  ),
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
