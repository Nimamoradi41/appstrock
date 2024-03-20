
import 'package:appstrock/Screens/Autentication/ApiServiceAutentication.dart';
import 'package:appstrock/Screens/Ems/screen_ems.dart';
import 'package:appstrock/Screens/Teriazh/screen_teriazh.dart';
import 'package:flutter/material.dart';
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
    'پذیرش',
    'بیماربر',
    'دکتر متخصص',
    'آزماشیگاه',
    'رزیدنت',
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

    if(textControllerPhoneNumber.text.length<11)
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



    // GoNextPage(context,ScreenCodeOtp(textControllerPhoneNumber.text.toString(),textControllerName.text.toString(),textControllerNationalCode.text.toString(),TypUser));


    // ignore: use_build_context_synchronously
    var Data=await ApiServiceAutentication.Rigester(textControllerName.text, TypUser.toString(), textControllerNationalCode.text, textControllerPhoneNumber.text,textControllerPassWord.text, context);



    Navigator.pop(context);

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
                ,Data.data.id.toString()));
          }else{
          ShowErrorMsg(context,Data.message);
        }
      }



  }


  var textControllerName=TextEditingController();
  var textControllerNationalCode=TextEditingController();
  var textControllerPhoneNumber=TextEditingController();
  var textControllerPassWord=TextEditingController();
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                maxLines: 1,

                                controller: textControllerPassWord,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'رمز عبور',
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
