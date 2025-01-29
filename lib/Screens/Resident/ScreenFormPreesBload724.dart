import 'dart:html';

import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:appstrock/test.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import 'ApiServiceResident.dart';


class ScreenFormPreesBload724 extends StatefulWidget {



  late void Function(List<Map<String, String>>) onClose;
  String Id;
  bool isAtend;

  ScreenFormPreesBload724(this.Id,this.isAtend,this.onClose);

  @override
  State<ScreenFormPreesBload724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormPreesBload724> {
  bool _checkBox1 = false;

  String    Convert_DATE(String day,String month,String year)
  {
    var temp_day="";
    var temp_mont="";
    if (day.length==1)
    {
      temp_day="0"+day;
    }else{
      temp_day=day;
    }
    if (month.length==1)
    {
      temp_mont="0"+month;
    }else{
      temp_mont=month;
    }





    return  (year+"/"+temp_mont+"/"+temp_day).toString();


  }




  var bload1 ="";
  var bload2 ="";

  void _submitForm() {
    List<Map<String, String>> answers = [];
    var FOneInt=int.parse(textControllerF1.text);
    var FTwoInt=int.parse(textControllerF2.text);


    if(FOneInt<50||FOneInt>300)
      {
        ShowErrorMsg(context,"فشار خون اشتباه وارد شده است");
        return;
      }


      if(FTwoInt<20||FTwoInt>150)
    {
      ShowErrorMsg(context,"فشار خون اشتباه وارد شده است");
      return;
    }





    bload1= textControllerF1.text.toString();
    bload2= textControllerF2.text.toString();

    answers.add({
      'bload1': bload1.toString(),
      'bload2': bload2.toString(),
    });






    if (widget.onClose != null) {
      Navigator.pop(context);
      widget.onClose(answers);

    }
  }

  Future Run(String Blod1,String Blod2)async{
    ShowLoadingApp(context);
    // ignore: use_build_context_synchronously

    var Data= await ApiServiceResident.PressBlod(widget.Id,context,Blod1,Blod2);

    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        Navigator.pop(context);
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        // ignore: use_build_context_synchronously
        ShowErrorMsg(context, Data.message);
      }
    }
  }




  @override
  void initState() {
    super.initState();
  }
  var textControllerF1=TextEditingController();
  var textControllerF2=TextEditingController();
  var textControllerGh=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return Scaffold(
      body: Center(
        child: Container(
          width: wid,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextApp('فشار خون',18,Colors.black87,true),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    controller: textControllerF1,
                    style: const TextStyle(
                      fontFamily: 'rob',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Systolic blood pressure (mmHg)',
                      labelStyle: TextStyle(
                          color: ColorApp.withOpacity(0.5)
                      ),
                      counterText: "",
                      enabledBorder: outlinedBorderBlack,
                      focusedBorder: outlinedBorderPurple,


                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    controller: textControllerF2,
                    style: const TextStyle(
                      fontFamily: 'rob',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Diastolic blood pressure (mmHg)',
                      labelStyle: TextStyle(
                          color: ColorApp.withOpacity(0.5)
                      ),
                      counterText: "",

                      enabledBorder: outlinedBorderBlack,
                      focusedBorder: outlinedBorderPurple,


                    ),
                  ),
                ),


                Spacer(),

                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: ElevatedButton(onPressed: (){
                            Navigator.pop(context);
                          },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          side:  const BorderSide(color: ColorApp,width: 2)
                                      )
                                  )
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextApp('بستن',16,ColorApp,true),
                              )),
                        ),
                      ),
                      widget.isAtend?Container():
                      SizedBox(width: 8,),
                      widget.isAtend?Container():
                      Expanded(
                        child: Container(
                          child: ElevatedButton(onPressed: (){
                            if(textControllerF1.text.isNotEmpty&&textControllerF2.text.isNotEmpty)
                              {
                                _submitForm();
                              }
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
                                child: TextApp('ثبت اطلاعات',16,Colors.white,true),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
