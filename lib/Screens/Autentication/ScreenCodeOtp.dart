import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_svg/svg.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import 'ApiServiceAutentication.dart';


class ScreenCodeOtp extends StatelessWidget {

  var ControlerTimer=CountdownController(autoStart: true);
  String CodeInput="";

  Future RunCode(String Code,BuildContext context)async{
    if(CodeInput.length!=5)
      {
        showToast("کد را وارد کنید",
            position: StyledToastPosition.top,
            context:context);
        return;
      }


    ShowLoadingApp(context);
    await Future.delayed(Duration(seconds: 3));
    var Data=ApiServiceAutentication.CodeOtp(CodeInput, context);



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
                            SizedBox(height: 16,),
                            Padding(
                              padding: const EdgeInsets.only(right: 16,top: 16),
                              child: TextApp('کد تایید را وارد کنید', 24, ColorTitleText, true),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16,top: 4),
                              child: TextApp('پیامک به شماره 09909439787 ارسال شد', 16, Colors.black38, false),
                            ),
                            SizedBox(height: 32,),

                            Container(
                              width: wid*0.6,
                              child: OtpTextField(
                                numberOfFields: 5,
                                borderWidth: 3,
                                keyboardType: TextInputType.phone,
                                borderRadius: BorderRadius.circular(8),
                                borderColor: ColorApp,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //set to true to show as box or false to show as dash
                                showFieldAsBox: true,
                                //runs when a code is typed in
                                onCodeChanged: (String code) {
                                  //handle validation or checks here
                                },
                                //runs when every textfield is filled
                                onSubmit: (String verificationCode){
                                  CodeInput=verificationCode;
                                  if(CodeInput.length==5)
                                    {

                                    }
                                }, // end onSubmit
                              ),
                            ),

                            SizedBox(height: 24,),



                            Column(
                              children: [
                                Countdown(
                                  seconds: 60,
                                  controller: ControlerTimer,
                                  build: (BuildContext context, double time) => Text(
                                    "00:"+time.toInt().toString(),
                                    style: const TextStyle(color: Colors.black38,fontWeight: FontWeight.bold,fontSize:18 ),
                                  ),
                                  interval: Duration(milliseconds: 1000),
                                  onFinished: () {

                                  },
                                ),
                                InkWell(
                                  onTap: (){

                                  },
                                  child: TextApp("ارسال مجدد ؟ ", 16,    Colors.black54
                                      , true),
                                ),
                              ],
                            ),






                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 32,),

                    Container(
                      width: wid*0.9,
                      child: ElevatedButton(onPressed: (){
                      RunCode(CodeInput   , context);
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
                            child: Text('ارسال کد',
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
