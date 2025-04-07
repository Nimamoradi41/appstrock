import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


class ScreenFormAddTimeInjection extends StatefulWidget {

  late void Function(List<Map<String, String>>) onClose;

  ScreenFormAddTimeInjection(this.onClose);
  @override
  State<ScreenFormAddTimeInjection> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormAddTimeInjection> {
  bool _checkBox1 = false;



  late Jalali DateNowKnow;


  late String DateNowKnowStr;



  late TimeOfDay TimeNowKnow;



  late String TimeNowKnowStr;
  void _submitForm() {
    List<Map<String, String>> answers = [];


    answers.add({
      'Time': TimeNowKnowStr,
    });

    if (widget.onClose != null) {
      widget.onClose(answers);
    }
  }

  Future  Run()async
  {
    _submitForm();
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

  Future PersianTimeCalender(bool Type,bool LKW)async{
    var picked = await showPersianTimePicker(
      context: context,
      builder: (BuildContext context, Widget? child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        );
      },
      initialTime: TimeNowKnow,
    );
    if(picked!=null)
    {
      TimeNowKnow=picked;
      TimeNowKnowStr=Convert_Time(TimeNowKnow.hour.toString(),TimeNowKnow.minute.toString());

      setState(() {

      });

    }



  }
  String    Convert_Time(String Hour,String Minute)
  {
    var temp_Hour="";
    var temp_Min="";
    if (Hour.length==1)
    {
      temp_Hour="0"+Hour;
    }else{
      temp_Hour=Hour;
    }
    if (Minute.length==1)
    {
      temp_Min="0"+Minute;
    }else{
      temp_Min=Minute;
    }
    return  (temp_Hour+":"+temp_Min).toString();


  }
  @override
  void initState()
  {
    super.initState();
    TimeNowKnow=TimeOfDay.now();
    TimeNowKnowStr="${TimeNowKnow.hour}:${TimeNowKnow.minute}";
    TimeNowKnowStr=Convert_Time(TimeNowKnow.hour.toString(),TimeNowKnow.minute.toString());


  }

  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return Center(
      child: Scaffold(
        body: Container(
          width: wid,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextApp('ثبت زمان تزریق',18,Colors.black87,true),
                  ],
                ),

                SizedBox(height: 16,),

                SizedBox(height: 16,),

                  Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          PersianTimeCalender(!_checkBox1,false);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextApp2('Time',14,Colors.black54,true),
                            SizedBox(height: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.black12,width: 2)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Column(
                                  children: <Widget>[

                                    Row(
                                      children: [
                                        SizedBox(width: 8,),
                                        Expanded(child: TextApp(TimeNowKnowStr,16,Colors.black87,true)),
                                        SizedBox(width: 8,),
                                        Icon(Icons.arrow_drop_down_circle_rounded,color: Colors.black54,),
                                        SizedBox(width: 4,)
                                      ],
                                    ),





                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                  ),

                SizedBox(height: 24,),

                SizedBox(height: 120,),
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
                      SizedBox(width: 8,),
                      Expanded(
                        child: Container(
                          child: ElevatedButton(onPressed: (){
                            Run();
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
                SizedBox(height: 8,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
