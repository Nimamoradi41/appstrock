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


class ScreenFormDescription extends StatefulWidget {




  String Id;
  bool isAtend;

  ScreenFormDescription(this.Id,this.isAtend);

  @override
  State<ScreenFormDescription> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormDescription> {
  bool _checkBox1 = false;





  Future Run(String Desc)async{
    // ShowLoadingApp(context);
    // // ignore: use_build_context_synchronously
    //
    // var Data= await ApiServiceResident.PressBlod(widget.Id,context,Desc);
    //
    // Navigator.pop(context);
    // if(Data!=null)
    // {
    //   if(Data.success)
    //   {
    //     Navigator.pop(context);
    //     ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
    //   }else{
    //     // ignore: use_build_context_synchronously
    //     ShowErrorMsg(context, Data.message);
    //   }
    // }
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
                    TextApp('توضیحات',18,Colors.black87,true),
                  ],
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextField(
                    maxLines: 6,
                    controller: textControllerF1,
                    style: const TextStyle(
                      fontFamily: 'rob',
                    ),
                    decoration: InputDecoration(
                      labelText: 'Description',
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
                                  padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                          side:  const BorderSide(color: ColorApp,width: 2)
                                      )
                                  )
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextApp('بستن',12,ColorApp,true),
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
                                // Run(textControllerF1.text.toString(),
                                //     textControllerF2.text.toString());
                              }
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
                                child: TextApp('ثبت اطلاعات',12,Colors.white,true),
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
