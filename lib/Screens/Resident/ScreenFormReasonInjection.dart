import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ScreenFormReasonInjection extends StatefulWidget {
  late void Function(List<Map<String, bool>>) onClose;

  bool isEdit;
  bool c1;
  bool c2;
  bool c3;
  bool c4;
  bool c5;
  bool c6;
  bool c7;
  bool c8;
  bool c9;
  bool c10;
  bool c11;
  bool c12;
  bool c13;
  bool c14;
  bool c15;
  bool c16;
  bool c17;
  bool c18;
  bool c19;
  bool c20;
  bool c21;
  bool c22;

  ScreenFormReasonInjection(this.onClose,this.isEdit,
      this.c1,
      this.c2,
      this.c3,
      this.c4,
      this.c5,
      this.c6,
      this.c7,
      this.c8,
      this.c9,
      this.c10,
      this.c11,
      this.c12,
      this.c13,
      this.c14,
      this.c15,
      this.c16,
      this.c17,
      this.c18,
      this.c19,
      this.c20,
      this.c21,
      this.c22);

  @override
  State<ScreenFormReasonInjection> createState() => _ScreenFormIsNot724State();
}

class _ScreenFormIsNot724State extends State<ScreenFormReasonInjection> {
  bool _checkBox1 = false;
  bool _checkBox2 = false;
  bool _checkBox3 = false;
  bool _checkBox4 = false;
  bool _checkBox5 = false;
  bool _checkBox6 = false;
  bool _checkBox7 = false;
  bool _checkBox8 = false;
  bool _checkBox9 = false;
  bool _checkBox10 = false;
  bool _checkBox11 = false;
  bool _checkBox12 = false;
  bool _checkBox13 = false;
  bool _checkBox14 = false;
  bool _checkBox15 = false;
  bool _checkBox16 = false;
  bool _checkBox17 = false;
  bool _checkBox18 = false;
  bool _checkBox19 = false;
  bool _checkBox20 = false;
  bool _checkBox21 = false;
  bool _checkBox22 = false;

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
    answers.add({
      'question': false,
      'selected_answer': _checkBox4,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox5,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox6,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox7,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox8,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox9,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox10,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox11,
    }); answers.add({
      'question': false,
      'selected_answer': _checkBox12,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox13,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox14,
    }); answers.add({
      'question': false,
      'selected_answer': _checkBox15,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox16,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox17,
    }); answers.add({
      'question': false,
      'selected_answer': _checkBox18,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox19,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox20,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox21,
    });
    answers.add({
      'question': false,
      'selected_answer': _checkBox22,
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
    _checkBox1=widget.c1;
    _checkBox2=widget.c2;
    _checkBox3=widget.c3;
    _checkBox4=widget.c4;
    _checkBox5=widget.c5;
    _checkBox6=widget.c6;
    _checkBox7=widget.c7;
    _checkBox8=widget.c8;
    _checkBox9=widget.c9;
    _checkBox10=widget.c10;
    _checkBox11=widget.c11;
    _checkBox12=widget.c12;
    _checkBox13=widget.c13;
    _checkBox14=widget.c14;
    _checkBox15=widget.c15;
    _checkBox16=widget.c16;
    _checkBox17=widget.c17;
    _checkBox18=widget.c18;
    _checkBox19=widget.c19;
    _checkBox20=widget.c20;
    _checkBox21=widget.c21;
    _checkBox22=widget.c22;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: wid,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back,size: 30,color: Colors.black45,)),
                        Spacer(),
                        TextApp('دلایل رد تزریق',16,Colors.black54,true),
                      ],
                    ),
                    SizedBox(height: 16,),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12,width: 2)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  SizedBox(width: 8,),
                                  const Expanded(child:
                                  Text(
                                    'شواهد خونریزی مغزی در CT Scan و MRI',
                                    textDirection: TextDirection.rtl, // تنظیم جهت متن به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
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
                                  const Expanded(child:
                                  Text(
                                    'بهبود سریع علائم یا حمله ایسکمیک گذرا (TIA)',
                                    textDirection: TextDirection.rtl, // تنظیم جهت متن به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
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
                                  const Expanded(child:
                                  Text(
                                    'فشار خون بالا – علی‌رغم دریافت دو دوز لابتالول (DBP > 110) یا (SBP > 185)',
                                    textDirection: TextDirection.rtl, // تنظیم جهت متن به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )

                                  ),
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
                              SizedBox(height: 4,),
                              Row(
                                children: [

                                  SizedBox(width: 8,),
                                  const Expanded(child:
                                  Text(
                                    'وجود هایپودانسیته و ناحیه اینفارکت < 1/3 ناحیه MCA',
                                    textDirection: TextDirection.rtl, // تنظیم جهت متن به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),

                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox4,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox4= value!;
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
                                  const Expanded(child:
                                  Text(
                                    'MRS بالای پیش از استروک',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),

                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox5,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox5= value!;
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
                                  const Expanded(child:
                                  Text(
                                    'NIHSS پایین',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),

                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox6,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox6= value!;
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
                                  const Expanded(child:
                                  Text(
                                    'پلاکت > 100 هزار',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),

                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox7,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox7= value!;
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
                                  const Expanded(
                                    child:Text(
                                      'سابقه کوآگولوپاتی یا مصرف آنتی کوآگولانت و آزمایشات مختل (INR > 1.7 یا برابر، یا PTT1.5 >)',
                                      textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                      textAlign: TextAlign.right,       // تراز متن به راست
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    )
                                    ,
                                  ),

                                  // const SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox8,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox8= value!;
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
                                  const Expanded(child: Text(
                                    'قند خون > 50 mg/dl',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox9,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox9= value!;
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
                                  const Expanded(child: Text(
                                    'قند خون < 400 mg/dl',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox10,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox10= value!;
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
                                  const Expanded(child: Text(
                                    'سابقه ICH قبلی',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox11,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox11= value!;
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
                                  const Expanded(child: Text(
                                    'جراحی مازور در 2 هفته اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox12,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox12= value!;
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
                                  const Expanded(child: Text(
                                    'ترومای جدی در 2 هفته اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox13,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox13= value!;
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
                                  const Expanded(child: Text(
                                    'سکته قلبی (STEMI) در 4 هفته اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox14,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox14= value!;
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
                                  const Expanded(child: Text(
                                    'سابقه استروک ایسکمیک در 3 ماه اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox15,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox15= value!;
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
                                  const Expanded(child: Text(
                                    'سابقه تروما به سر در 3 ماه اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox16,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox16= value!;
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
                                  const Expanded(child: Text(
                                    'بارداری',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox17,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox17= value!;
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
                                  const Expanded(child: Text(
                                    'خونریزی دستگاه گوارش، ادراری تناسلی و یا هر خونریزی Significant دیگردر 3 هفته اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox17,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox17= value!;
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
                                  const Expanded(child: Text(
                                    'وجود arterial puncture at a noncompressible site در 7 روز اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox18,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox18= value!;
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
                                  const Expanded(child: Text(
                                    'انجام LP در 7 روز اخیر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox19,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox19= value!;
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
                                  const Expanded(child: Text(
                                    'عدم رضایت بیمار یا همراه به دریافت Tpa',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox20,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox20= value!;
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
                                  const Expanded(child: Text(
                                    'سایر',
                                    textDirection: TextDirection.rtl, // جهت‌دهی به راست‌چین
                                    textAlign: TextAlign.right,       // تراز متن به راست
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  )
                                  ),
                                  SizedBox(width: 8,),
                                  Checkbox(
                                    value: _checkBox21,
                                    fillColor: MaterialStateColor.resolveWith((states) => ColorApp),

                                    onChanged: (value) {
                                      setState(() {
                                        _checkBox21= value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 4,)
                                ],
                              ),
                              SizedBox(height: 4,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24,),

                    Center(
                      child: Container(
                        width: wid,
                        child: ElevatedButton(onPressed: (){
                          Run();
                          // if(widget.isEdit)
                          //   {
                          //    Navigator.pop(context);
                          //   }else{
                          //
                          // }

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
                              // child: TextApp(  widget.isEdit ? 'بستن' : 'ثبت اطلاعات',16,Colors.white,true),
                              child: TextApp(   'ثبت اطلاعات',16,Colors.white,true),
                            )),
                      ),
                    ),
                    SizedBox(height: 8,),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
