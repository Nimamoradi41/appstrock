
import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


class ScreenFormIs724 extends StatefulWidget {

  late void Function(List<Map<String, String>>) onClose;

  ScreenFormIs724(this.onClose);
  @override
  State<ScreenFormIs724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormIs724> {
  bool _checkBox1 = false;






  late Jalali DateNowUnKnowLKW;
  late Jalali DateNowUnKnowFss;

  late Jalali DateNowKnow;

  late String DateNowUnKnowLKWStr;
  late String DateNowUnKnowFssStr;
  late String DateNowKnowStr;


  late TimeOfDay TimeNowUnKnowLKW;
  late TimeOfDay TimeNowUnKnowFss;
  late TimeOfDay TimeNowKnow;

  late String TimeNowUnKnowLKWStr;
  late String TimeNowUnKnowFssStr;

  late String TimeNowKnowStr;

  var year=0;
  var month=0;
  var day=0;

  var hour=0;
  var min=0;

  void _submitForm() {
    List<Map<String, String>> answers = [];
    answers.add({
      'Know': _checkBox1.toString(),
    });

    if(!_checkBox1)
      {
        answers.add({
          'Time': TimeNowKnowStr,
        });
        answers.add({
          'Date': DateNowKnowStr,
        });
      }else{
      answers.add({
        'TimeLKW': TimeNowUnKnowLKWStr,
      });
      answers.add({
        'DateLKW': DateNowUnKnowLKWStr,
      });

      answers.add({
        'TimeFss': TimeNowUnKnowFssStr,
      });
      answers.add({
        'DateFss': DateNowUnKnowFssStr,
      });




    }

    if (_selectedJalaliDate != null && _selectedTime != null) {
      // تبدیل تاریخ شمسی به میلادی
      final gregorianDate = _selectedJalaliDate!.toGregorian();

      // تبدیل تاریخ و زمان به DateTime میلادی
      final dateTime = DateTime(
        gregorianDate.year,
        gregorianDate.month,
        gregorianDate.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      timestamp = dateTime.millisecondsSinceEpoch;
      answers.add({
        'timestamp': timestamp.toString(),
      });
    }


    print(answers.toString());






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


  Jalali? _selectedJalaliDate;
  TimeOfDay? _selectedTime;
  int? timestamp;


  Future PersianDateCalender(bool Type,bool LKW)async{
    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate:Type ? DateNowKnow:!Type && LKW ?DateNowUnKnowLKW :DateNowUnKnowFss,
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
    );
    if(picked!=null)
      {

        if(Type)
          {
            _selectedJalaliDate=picked;
            DateNowKnow=picked;
            DateNowKnowStr=Convert_DATE(DateNowKnow.day.toString()
                ,DateNowKnow.month.toString(),DateNowKnow.year.toString());


            Jalali picked2=Jalali(DateNowKnow.year,DateNowKnow.month,
                DateNowKnow.day,hour,min,0);
            timestamp=picked2.toDateTime().millisecondsSinceEpoch;


          }  else  if(!Type && LKW) {
          DateNowUnKnowLKW=picked;
          DateNowUnKnowLKWStr=Convert_DATE(DateNowUnKnowLKW.day.toString()
              ,DateNowUnKnowLKW.month.toString(),DateNowUnKnowLKW.year.toString());
        }
        else  if(!Type && !LKW) {
          DateNowUnKnowFss=picked;
          DateNowUnKnowFssStr=Convert_DATE(DateNowUnKnowFss.day.toString()
              ,DateNowUnKnowFss.month.toString(),DateNowUnKnowFss.year.toString());
        }




        setState(() {

        });
      }



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
      initialTime: Type ? TimeNowKnow:!Type && LKW ?TimeNowUnKnowLKW :TimeNowUnKnowFss,
    );
    if(picked!=null)
    {
      if(Type)
      {
        TimeNowKnow=picked;
        _selectedTime=picked;
        TimeNowKnowStr="${TimeNowKnow.hour}:${TimeNowKnow.minute}";
        // timeStamp=DateTime.now().millisecondsSinceEpoch;
        hour=TimeNowKnow.hour;
        min=TimeNowKnow.minute;
        Jalali picked2=Jalali(year,month,day,hour,min,0);
        timestamp=picked2.toDateTime().millisecondsSinceEpoch;






      }else if(!Type && LKW){
        TimeNowUnKnowLKW=picked;
        TimeNowUnKnowLKWStr="${TimeNowUnKnowLKW.hour}:${TimeNowUnKnowLKW.minute}";
      }
      else if(!Type && !LKW){
        TimeNowUnKnowFss=picked;
        TimeNowUnKnowFssStr="${TimeNowUnKnowFss.hour}:${TimeNowUnKnowFss.minute}";
      }

      setState(() {

      });

    }



  }

  @override
  void initState()
  {
    super.initState();
    DateNowKnow=Jalali.now();
    _selectedJalaliDate=Jalali.now();
    year=DateNowKnow.year;
    day=DateNowKnow.day;
    month=DateNowKnow.month;
    DateNowKnowStr=Convert_DATE(DateNowKnow.day.toString()
        ,DateNowKnow.month.toString(),DateNowKnow.year.toString());


    DateNowUnKnowLKW=Jalali.now();
    DateNowUnKnowLKWStr=Convert_DATE(DateNowUnKnowLKW.day.toString()
        ,DateNowUnKnowLKW.month.toString(),DateNowUnKnowLKW.year.toString());

    DateNowUnKnowFss=Jalali.now();
    DateNowUnKnowFssStr=Convert_DATE(DateNowUnKnowFss.day.toString()
        ,DateNowUnKnowFss.month.toString(),DateNowUnKnowFss.year.toString());


    TimeNowKnow=TimeOfDay.now();
    _selectedTime=TimeOfDay.now();
    TimeNowKnowStr=Convert_Time(TimeNowKnow.hour.toString(),TimeNowKnow.minute.toString());

    hour=TimeNowKnow.hour;
    min=TimeNowKnow.minute;
    Jalali picked2=Jalali(year,month,
        day,hour,min,0);
    timestamp=picked2.toDateTime().millisecondsSinceEpoch;

    TimeNowUnKnowLKW=TimeOfDay.now();
    TimeNowUnKnowLKWStr=Convert_Time(TimeNowUnKnowLKW.hour.toString(),TimeNowUnKnowLKW.minute.toString());

    TimeNowUnKnowFss=TimeOfDay.now();
    TimeNowUnKnowFssStr=Convert_Time(TimeNowUnKnowFss.hour.toString(),TimeNowUnKnowFss.minute.toString());

  }

  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return Center(
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
                  TextApp('ثبت کد 724',18,Colors.black87,true),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  SizedBox(width: 8,),
                  Expanded(child: TextApp2('زمان شروع  علائم مشخص نیست',16,Colors.black87,true)),
                  SizedBox(width: 8,),
                  Checkbox(
                    value: _checkBox1,
                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                    onChanged: (value) {
                      setState(() {
                        _checkBox1 = value!;
                      });
                    },
                  ),
                  SizedBox(width: 4,)
                ],
              ),
              SizedBox(height: 16,),
              Container(
                width: wid,
                height: 2,
                color: Colors.black12,
                margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
              ),
              SizedBox(height: 16,),

              !_checkBox1 ?
              Row(
                children: [
                  Expanded(child: InkWell(
                    onTap: (){
                      PersianDateCalender(!_checkBox1,false);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp2('تاریخ شروع علائم',14,Colors.black54,true),

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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 8,),
                                    Expanded(child: TextApp(DateNowKnowStr,16,Colors.black87,true)),
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
                  SizedBox(width: 16,),
                  Expanded(child: InkWell(
                    onTap: (){
                      PersianTimeCalender(!_checkBox1,false);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp2('زمان شروع علائم',14,Colors.black54,true),
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
              ):
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          PersianDateCalender(!_checkBox1,true);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextApp2('LKW Date',14,Colors.black54,true),

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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        Expanded(child: TextApp(DateNowUnKnowLKWStr,16,Colors.black87,true)),
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
                      SizedBox(width: 16,),
                      Expanded(child: InkWell(
                        onTap: (){
                          PersianTimeCalender(!_checkBox1,true);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextApp2('LKW Time',14,Colors.black54,true),
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
                                        Expanded(child: TextApp(TimeNowUnKnowLKWStr,16,Colors.black87,true)),
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
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Expanded(child: InkWell(
                        onTap: (){
                          PersianDateCalender(!_checkBox1,false);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextApp2('FSS Date',14,Colors.black54,true),

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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 8,),
                                        Expanded(child: TextApp(DateNowUnKnowFssStr,16,Colors.black87,true)),
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
                      SizedBox(width: 16,),
                      Expanded(child: InkWell(
                        onTap: (){
                          PersianTimeCalender(!_checkBox1,false);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextApp2('FSS Time',14,Colors.black54,true),
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
                                        Expanded(child: TextApp(TimeNowUnKnowFssStr,16,Colors.black87,true)),
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
                ],
              )
              ,
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
              SizedBox(height: 8,),

            ],
          ),
        ),
      ),
    );
  }
}
