import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/TextApp.dart';



const Color ColorTitleText=Color(0xff505050);
const Color Colorbutton=Color(0xff0266FD);
const Color BackGroundApp=Color(0xffDFE1E5);
const Color ColorApp=Color(0xff7B73E7);
const Color ColorTextsubject=Color(0xff989898);
const Color ColorTextbody=Color(0xff3F3F3F);
const Color BtnColorgreen=Color(0xff008000);
const Color BtnColorred=Color(0xffef233c);



void GoNextPage(BuildContext context,dynamic Screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Screen));
}


Future<bool>   ShowAllow(BuildContext context,String BodyText) async{

  bool Flag=false;
  await  showDialog(context: context, builder:
      (ctx){
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: ColorApp,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TextApp('مجوز',16,Colors.white,true),
                    ),
                  ),
                  SizedBox(height: 16,),
                  TextApp(BodyText,18,Colors.black87,true),
                  SizedBox(height: 16,),
                  Row(
                    children: [

                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                            onPressed: (){
                              Navigator.pop(context);
                              // NeedToCT(context);

                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(BtnColorgreen),
                                padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                )
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('خیر',
                                style: TextStyle(color:Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),),
                            )),
                      )),
                      Expanded(child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                          Flag=true;

                        },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(BtnColorred),
                                padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    )
                                )
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text('بله',
                                style: TextStyle(color:Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),),
                            )),
                      ))
                    ],
                  ),
                  SizedBox(height: 8,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  );


  return Flag;

}

BoxDecoration MainDecoration=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 4
      )
    ]
);




Widget BoldText(String Body){
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(text: "پیامک به شماره ",style: TextStyle(
          color: Colors.black38,
          fontSize: 16,
        )),
        TextSpan(text:Body,style: TextStyle(
          color: Colors.black38,
          fontSize: 16,
          fontWeight: FontWeight.bold
        )),
        TextSpan(text: " ارسال شد " ,style: TextStyle(
          color: Colors.black38,
          fontSize: 16,
        )),

      ],
    ),
  );
}
// Loading in All App
Future<void> ShowLoadingApp(BuildContext context) async {
      showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      double wid=MediaQuery.of(context).size.width;
      wid=wid>600?600:wid;
      return Scaffold(
        backgroundColor: Colors.transparent ,
        body:  Center(
          child: LoadingAnimationWidget.halfTriangleDot(
            color: ColorApp,
            size: 100,
          ),
        )
      );
    },
  );
}
// Loading in All App


// todo ShowErrors
void ShowErrorMsg(BuildContext context,String Msg)
{
  showToast(Msg,
      backgroundColor: Colors.redAccent,
      textStyle: TextStyle(color: Colors.white),
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromLeft,
      context:context);
}
// todo ShowErrors



// todo ShowSucces
void ShowSuccesMsg(BuildContext context,String Msg)
{
  showToast(Msg,
      backgroundColor: Colors.green,
      textStyle: TextStyle(color: Colors.white),
      position: StyledToastPosition.top,
      animation: StyledToastAnimation.slideFromLeft,
      context:context);
}
// todo ShowSucces



  // todo Login Or Rigester User
 Future LoginInApp(String Name,String Code,int TypeUser,bool Login)async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   await prefs.setString('Name',Name);
   await prefs.setString('Code',Code);
   await prefs.setBool('Login',Login);
   await prefs.setInt('TypeUser',TypeUser);
 }
 // todo  Login Or Rigester User




Future<int> GetTypeUser(String Type)async{
  if(Type=='فوریت های پزشکی')
  {
    return 1;
  }
  if(Type=='تریاژ')
  {
    return 2;
  }
  if(Type=='پزیرش')
  {
    return 3;
  }
  if(Type=='رزیدنت')
  {
    return 4;
  }
  if(Type=='بیماربر')
  {
    return 5;
  }
  if(Type=='آزمایشگاه')
  {
    return 6;
  }
  if(Type=='آزمایشگاه')
  {
    return 7;
  }
  if(Type=='استروک')
  {
    return 8;
  }
  return 9;
}




// Login And Rigester Border
OutlineInputBorder outlinedBorderBlack=OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.black26, width: 2),
  borderRadius: BorderRadius.circular(8),
);
OutlineInputBorder outlinedBorderPurple=OutlineInputBorder(
  borderSide: const BorderSide(color: ColorApp, width: 2),
  borderRadius: BorderRadius.circular(8),
);
// Login And Rigester Border

const String VersionApp='نسخه  1.0.0';


