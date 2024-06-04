import 'dart:html';

import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';


class ScreenFormImage724 extends StatefulWidget {


  @override
  State<ScreenFormImage724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormImage724> {
  bool _checkBox1 = false;









  Future  Run()async
  {
    var Res=await ShowAllow(context,'آیا از تکمیل فرم مطمئن هستید ؟');
    if(Res)
    {

     var fromPicker = await ImagePicker().pickImage(source: ImageSource.camera,imageQuality: 70);

      if(fromPicker!=null) {
        final file = await  fromPicker.readAsBytes();
        print('11');
        var request = http.MultipartRequest('POST',
            Uri.parse('https://api.appstrok.ir/Patients/AddImages'));

        request.fields.addAll({
          'patientId': '1',
          'userId': '1'
        });
        print(file.toString());
        request.files.add(
          http.MultipartFile.fromBytes(
              'Images',
              file,
              filename: fromPicker.name),
        );
        final response = await request.send();
        if (response.statusCode == 200) {
          print(await response.stream.bytesToString());
        }
        else {
          print(response.reasonPhrase);
          print(await response.stream.bytesToString());
        }
        }

      // ignore: use_build_context_synchronously
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
    return Scaffold(
      body: Center(
        child: Container(
          width: wid,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextApp('آپلود عکس',18,Colors.black87,true),
                    ],
                  ),
                  SizedBox(height: 16,),
                  InkWell(
                    onTap: (){
                      Run();
                    },
                    child: Container(
                      width: wid,
                      margin: EdgeInsets.symmetric(horizontal: 16),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorApp.withOpacity(0.4),width: 2,strokeAlign:BorderSide.strokeAlignOutside)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height: 8,),
                            Icon(Icons.image,color: ColorApp,size: 60,),
                            SizedBox(height: 16,),
                            TextApp2('عکس خود را انتخاب کنید', 16, Colors.black26, true),
                            SizedBox(height: 8,),


                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24,),
                  Container(
                    width: wid,
                    height: 2,
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  ),
                  SizedBox(height: 8,),
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
                  SizedBox(height: 16,),
                  Container(
                    width: wid,
                    height: 2,
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  ),
                  SizedBox(height: 8,),
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
                  Container(
                    width: wid,
                    height: 2,
                    color: Colors.black12,
                    margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  ),
                  SizedBox(height: 8,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextApp('توضیحات',18,Colors.black87,true),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: 120,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: textControllerGh,
                        decoration: InputDecoration(
                          labelText: 'توضیحات خود را وارد کنید',
                          labelStyle: TextStyle(
                              color: ColorApp.withOpacity(0.5)
                          ),
                          counterText: "",

                          enabledBorder: outlinedBorderBlack,
                          focusedBorder: outlinedBorderPurple,


                        ),
                      ),
                    ),
                  ),
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
                        SizedBox(width: 8,),
                        Expanded(
                          child: Container(
                            child: ElevatedButton(onPressed: (){
                              Run();
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
      ),
    );
  }
}
