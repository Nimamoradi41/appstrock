
import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'ApiServiceResident.dart';
class ScreenFormBload724 extends StatefulWidget {

  String Id;

  bool isAtend;
  ScreenFormBload724(this.Id,this.isAtend,this.onClose);

  late void Function(List<Map<String, String>>) onClose;



  @override
  State<ScreenFormBload724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormBload724> {
  bool _checkBox1 = false;




  var bload ="";

  void _submitForm() {
    List<Map<String, String>> answers = [];

    var bloadInt=int.parse(textControllerGh.text);
    if(bloadInt>1000)
      {
        ShowErrorMsg(context,"قند خون وارد شده مجاز نمیباشد");
        return;
      }

    bload= textControllerGh.text.toString();
    answers.add({
      'bload': bload.toString(),
    });






    if (widget.onClose != null) {
      Navigator.pop(context);
      widget.onClose(answers);

    }
  }

  Future Run(String Blod)async{
    ShowLoadingApp(context);


    var Data= await ApiServiceResident.Blod(widget.Id,context,Blod);

    Navigator.pop(context);
    if(Data!=null)
    {
      if(Data.success)
      {
        Navigator.pop(context);
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      }else{
        ShowErrorMsg(context, Data.message);
      }
    }
  }


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
    return Center(
      child: Container(
        width: wid,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[


                SizedBox(height: 16,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextApp('قند خون',18,Colors.black87,true),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    controller: textControllerGh,
                    decoration: InputDecoration(
                      labelText: '',
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
                Spacer(),


                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     TextApp('توضیحات',18,Colors.black87,true),
                //   ],
                // ),
                // SizedBox(height: 8,),
                // Directionality(
                //   textDirection: TextDirection.rtl,
                //   child: Container(
                //     height: 120,
                //     child: TextField(
                //       keyboardType: TextInputType.number,
                //       controller: textControllerGh,
                //       decoration: InputDecoration(
                //         labelText: 'توضیحات خود را وارد کنید',
                //         labelStyle: TextStyle(
                //             color: ColorApp.withOpacity(0.5)
                //         ),
                //         counterText: "",
                //
                //         enabledBorder: outlinedBorderBlack,
                //         focusedBorder: outlinedBorderPurple,
                //
                //
                //       ),
                //     ),
                //   ),
                // ),
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
                            if(textControllerGh.text.isNotEmpty)
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
