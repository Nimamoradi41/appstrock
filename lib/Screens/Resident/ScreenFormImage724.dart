import 'dart:html';
import 'dart:typed_data';

import 'package:appstrock/Constants.dart';
import 'package:appstrock/Screens/Resident/ApiServiceResident.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';


class ScreenFormImage724 extends StatefulWidget {


  String Id;


  ScreenFormImage724(this.Id);

  @override
  State<ScreenFormImage724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormImage724> {
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

  @override
  void initState() {
    super.initState();
  }

  var textControllerF1=TextEditingController();
  var textControllerF2=TextEditingController();
  var textControllerGh=TextEditingController();
  var IsSelected=false;
  late Uint8List DateImage;
  String NameFile="";
  String pathFile="";

  Future  Run()async
  {

    var fromPicker = await ImagePicker().pickImage(source
        : ImageSource.camera,imageQuality: 20);

    if(fromPicker!=null) {
      final file = await  fromPicker.readAsBytes();
      IsSelected=true;
      NameFile=fromPicker.name;
      pathFile=fromPicker.path;
      DateImage=file;
      setState(() {

      });


    }
  }
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
                      border: Border.all(color: ColorApp.withOpacity(0.4),
                          width: 2,strokeAlign:BorderSide.strokeAlignOutside)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 8,),
                          pathFile.isEmpty?
                          Icon(Icons.image,color: ColorApp,size: 60,):
                          Image.network(pathFile,width: 60,height: 60,),
                          SizedBox(height: 16,),
                          TextApp2('عکس خود را انتخاب کنید', 16, Colors.black26, true),
                          SizedBox(height: 8,),


                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: ElevatedButton(
                              onPressed: (){
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
                          child: ElevatedButton(onPressed:() async{
                            var Res=await ShowAllow(context,'آیا از تکمیل فرم مطمئن هستید ؟');
                            if(Res)
                            {
                              ShowLoadingApp(context);
                              var Req=await ApiServiceResident.
                              UploadImage(widget.Id.toString(),context,DateImage,NameFile.toString());
                              if(Req.success)
                              {
                                ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }else{
                                ShowErrorMsg(context, Req.message);
                              }

                              // ignore: use_build_context_synchronously
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
