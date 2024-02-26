import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';


class ScreenFormIsNot724 extends StatefulWidget {
  late void Function(List<Map<String, int>>) onClose;

  ScreenFormIsNot724(this.onClose);

  @override
  State<ScreenFormIsNot724> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormIsNot724> {
  bool _checkBox1 = false;
  bool _checkBox2 = false;
  bool _checkBox3 = false;


  void _submitForm() {
    List<Map<String, int>> answers = [];
    answers.add({
      'question': 1,
      'selected_answer': _checkBox1.hashCode,
    });
    answers.add({
      'question': 2,
      'selected_answer': _checkBox2.hashCode,
    });
    answers.add({
      'question': 3,
      'selected_answer': _checkBox3.hashCode,
    });



    if (widget.onClose != null) {
      widget.onClose(answers);
    }
  }

  Future  Run()async
  {
    var Res=await ShowAllow(context,'آیا از تکمیل فرم مطمئن هستید ؟');
    print('VVV');
    print(Res.toString());
    if(Res)
    {
      print('AAA');
      _submitForm();
      // ignore: use_build_context_synchronously
    }
  }

  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return Padding(
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
          SizedBox(height: 8,),

        ],
      ),
    );
  }
}
