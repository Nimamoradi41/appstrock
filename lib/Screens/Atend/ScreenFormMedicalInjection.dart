import 'package:appstrock/Constants.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class ScreenFormMedicalInjection extends StatefulWidget {
  late void Function(List<Map<String, String>>) onClose;

  ScreenFormMedicalInjection(this.onClose,this.medicineSelected);

  int medicineSelected;
  @override
  State<ScreenFormMedicalInjection> createState() => _ScreenFormIsNot724State();


}

class _ScreenFormIsNot724State extends State<ScreenFormMedicalInjection> {
  bool _checkBox1 = false;




  String? selectedValue;

  int selectedInt=0;

  void _submitForm() {
    List<Map<String, String>> answers = [];
    answers.add({
      'question': "3",
      'selected_answer': selectedInt.toString(),
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

    if(widget.medicineSelected==1)
      {
        selectedValue='آلتپلاز';
      }

    if(widget.medicineSelected==2)
    {
      selectedValue='تنکتپلاز';
    }

    if(widget.medicineSelected==3)
    {
      selectedValue='آلتلایز(ایرانی)';
    }

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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextApp('ثبت دارو پیشنهادی',18,Colors.black87,true),
                ],
              ),
              SizedBox(height: 16,),
              Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextApp2('دارو',14,Colors.black54,true),
                      SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black12,width: 2)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            children: [
                              Expanded(child: buildRadio('آلتپلاز',1)),
                              Expanded(child:buildRadio('تنکتپلاز',2) ),
                              Expanded(child: buildRadio('آلتلایز(ایرانی)',3))
                            ],
                          ),
                        ),
                      ),



                    ],
                  )),

                ],
              ),

              SizedBox(height: 32,),
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
    );
  }

  Widget buildRadio(String value,int data) {
    return RadioListTile<String>(
      title: Text(
        value,
        style: const TextStyle(fontSize: 12),
      ),
      value: value,
      groupValue: selectedValue,
      controlAffinity: ListTileControlAffinity.trailing, // دکمه سمت راست
      onChanged: (val) {
        setState(() {
          selectedValue = val;
          selectedInt=data;
        });
      },
    );
  }

}
