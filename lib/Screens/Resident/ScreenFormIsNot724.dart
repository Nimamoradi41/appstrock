import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ScreenFormIsNot724 extends StatefulWidget {
  late void Function(List<Map<String, bool>>) onClose;

  bool isEdit;
  bool misdiagnosisOfTriage;
  bool misdiagnosisOfEms;
  bool overTime;
  ScreenFormIsNot724(this.onClose,this.isEdit,this.misdiagnosisOfTriage,this.misdiagnosisOfEms,this.overTime);

  @override
  State<ScreenFormIsNot724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormIsNot724> {
  bool _checkBox1 = false;
  bool _checkBox2 = false;
  bool _checkBox3 = false;


  void _submitForm() {
    List<Map<String, bool>> answers = [];
    answers.add({
      'question': false,
      'selected_answer': _checkBox1,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox2,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox3,
    });



    if (widget.onClose != null) {
      widget.onClose(answers);
    }
  }

  Future  Run()async
  {
    _submitForm();
  }


  @override
  void initState() {
    super.initState();
    _checkBox1=widget.misdiagnosisOfTriage;
    _checkBox2=widget.misdiagnosisOfEms;
    _checkBox3=widget.overTime;
    setState(() {

    });
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextApp('دلایل رد کد 724',16,Colors.black54,true),
              SizedBox(height: 16,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black12,width: 2)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          SizedBox(width: 8,),
                          Expanded(child: TextApp2('تشخیص اشتباه تریاژ',16,Colors.black87,true)),
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
                      SizedBox(height: 4,),
                      Row(
                        children: [

                          SizedBox(width: 8,),
                          Expanded(child: TextApp2('تشخیص اشتباه اورژانس پیش بیمارستانی',16,Colors.black87,true)),
                          SizedBox(width: 8,),
                          Checkbox(
                            value: _checkBox2,
                            fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                            onChanged: (value) {
                              setState(() {
                                _checkBox2 = value!;
                              });
                            },
                          ),
                          SizedBox(width: 4,)
                        ],
                      ),
                      SizedBox(height: 4,),
                      Row(
                        children: [
                          SizedBox(width: 8,),
                          Expanded(child: TextApp2('بیش از 4 و نیم ساعت از شروع علائم گذشته است',16,Colors.black87,true)),
                          SizedBox(width: 8,),
                          Checkbox(
                            value: _checkBox3,
                            fillColor: MaterialStateColor.resolveWith((states) => ColorApp),
                            onChanged: (value) {
                              setState(() {
                                _checkBox3= value!;
                              });
                            },
                          ),
                          SizedBox(width: 4,)
                        ],
                      ),



                    ],
                  ),
                ),
              ),
              SizedBox(height: 24,),

              Center(
                child: Container(
                  width: wid,
                  child: ElevatedButton(onPressed: (){
                    // if(widget.isEdit)
                    //   {
                    //    Navigator.pop(context);
                    //   }else{
                    //
                    // }

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
                        child: TextApp(  widget.isEdit ? 'بستن' : 'ثبت اطلاعات',12,Colors.white,true),
                      )),
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
