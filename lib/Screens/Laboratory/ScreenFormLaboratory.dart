import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../Resident/ScreenFormNIHS.dart';







class ScreenFormLaboratory extends StatefulWidget {
  late void Function(List<Map<String, dynamic>>) onClose;
  ScreenFormLaboratory(
      this.onClose,
      this.ISEdit,
      this.Bun,
      this.Cr,this.PLT,this.PT,
      this.INR,
      this.Trop,
      this.hb,
      this.wbc,
      this.isAtend);
  bool ISEdit;
  String Bun;
  String Cr;
  String PLT;
  String PT;
  String INR;
  String Trop;
  String hb;
  String wbc;
  bool isAtend;
  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ScreenFormLaboratory> {

  @override
  void initState() {
    super.initState();
    textControllerBun.text=widget.Bun.toString();
    textControllerCr.text=widget.Cr.toString();
    textControllerPLT.text=widget.PLT.toString();
    textControllerPT.text=widget.PT.toString();
    textControllerINR.text=widget.INR.toString();
    textControllerTrop.text=widget.Trop.toString();
    textControllerWBC.text=widget.wbc.toString();
    textControllerHB.text=widget.hb.toString();

    if(widget.Trop=="true")
      {
        _handleRadioValueChange("Positive");
      }else{
      _handleRadioValueChange("Negative");
    }


  }

  Future Run()async{

    if(textControllerCr.text.isNotEmpty)
      {
        var CrInt=int.parse(textControllerCr.text);

        if(CrInt>10||CrInt<0)
        {
          showToast(" باید بین 0 تا 10 باشد"+" Cr ",
              position: StyledToastPosition.top,
              context:context);
          return ;
        }
      }


    if(textControllerPLT.text.isNotEmpty)
    {
      var PLTInt=int.parse(textControllerPLT.text);
      if(PLTInt>1000000||PLTInt<1000)
      {
        showToast("باید بین 1000 تا 1000000 باشد"+" PLT ",
            position: StyledToastPosition.top,
            context:context);
        return ;
      }
    }


    if(textControllerPT.text.isNotEmpty)
    {
      var PTInt=int.parse(textControllerPT.text);

      if(PTInt>100||PTInt<10)
      {
        showToast(" باید بین 10 تا 100 باشد "+" PTT ",
            position: StyledToastPosition.top,
            context:context);
        return ;
      }
    }


    if(textControllerINR.text.isNotEmpty)
    {
      var INRInt=int.parse(textControllerINR.text);

      if(INRInt>10||INRInt<1)
      {
        showToast( "باید بین 1 تا 10 باشد"+" INR ",
            position: StyledToastPosition.top,
            context:context);
        return ;
      }
    }


    if(textControllerHB.text.isNotEmpty)
    {
      var HBInt=int.parse(textControllerHB.text);
      if(HBInt>20||HBInt<5)
      {
        showToast("باید بین 5 تا 20 باشد"+" HB ",
            position: StyledToastPosition.top,
            context:context);
        return ;
      }
    }


    if(textControllerWBC.text.isNotEmpty)
    {
      var WBCInt=int.parse(textControllerWBC.text);
      if(WBCInt>30000||WBCInt<1000)
      {
        showToast("باید بین 1000 تا 30000 باشد"+" WBC ",
            position: StyledToastPosition.top,
            context:context);
        return ;
      }
    }

    _submitForm();
  }



  var textControllerBun=TextEditingController();
  var textControllerCr=TextEditingController();
  var textControllerPLT=TextEditingController();
  var textControllerPT=TextEditingController();
  var textControllerINR=TextEditingController();
  var textControllerHB=TextEditingController();
  var textControllerWBC=TextEditingController();
  var textControllerTrop=TextEditingController();



  String _selectedOption = 'Positive';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedOption = value!;
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
            height: double.infinity,
            color: BackGroundApp,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: wid,
                          decoration: const BoxDecoration(
                              color: Colors.black45,
                              borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.arrow_back,size: 30,color: Colors.white,),
                                ),
                              ),


                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                child: TextAppfredoka('Laboratory',16,Colors.white,true),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Expanded(
                          child:  Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all( color: Colors.black45,width: 3)
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        maxLength: 3,
                                        keyboardType: TextInputType.number,
                                        controller: textControllerBun,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        decoration: InputDecoration(
                                          labelText: 'Bun',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        controller: textControllerCr,

                                        decoration: InputDecoration(
                                          labelText: 'Cr',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        keyboardType: TextInputType.text,
                                        controller: textControllerPLT,
                                        decoration: InputDecoration(
                                          labelText: 'PLT',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        keyboardType: TextInputType.number,
                                        controller: textControllerPT,
                                        decoration: InputDecoration(
                                          labelText: 'PTT',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        keyboardType: TextInputType.text,
                                        controller: textControllerINR,
                                        decoration: InputDecoration(
                                          labelText: 'INR',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        keyboardType: TextInputType.text,
                                        controller: textControllerHB,
                                        decoration: InputDecoration(
                                          labelText: 'HB',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: TextField(
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontFamily: 'rob',
                                            fontSize: 12
                                        ),
                                        keyboardType: TextInputType.text,
                                        controller: textControllerWBC,
                                        decoration: InputDecoration(
                                          labelText: 'WBC',
                                          labelStyle: TextStyle(
                                              color: ColorApp
                                          ),
                                          counterText: "",

                                          enabledBorder: outlinedBorderBlack,
                                          focusedBorder: outlinedBorderPurple,


                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 8,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: TextApp('Trop', 14, ColorApp, true),
                                        ),
                                        RadioListTile<String>(
                                          title: const Text('Positive'),
                                          value: 'Positive',
                                          groupValue: _selectedOption,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1,
                                          color: Colors.black26,
                                          margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                        ),
                                        RadioListTile<String>(
                                          title: const Text('Negative'),
                                          value: 'Negative',
                                          groupValue: _selectedOption,
                                          onChanged: _handleRadioValueChange,
                                        ),
                                      ],
                                    )


                                  ],
                                ),
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),


                SizedBox(height: 8,),

                !widget.isAtend?
                    Column(
                      children: [
                        Container(
                          width: wid*0.9,
                          child: ElevatedButton(onPressed: (){
                            Run();
                          },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(ColorApp),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4.0),
                                      )
                                  )
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text( widget.ISEdit ? 'ویرایش فرم' :  'تکمیل فرم',
                                  style: TextStyle(color:Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),),
                              )),
                        ),
                        SizedBox(height: 8,),
                      ],
                    ):Container()
              ],
            ),
          ),
        ),
      ),
    );




  }

  void _submitForm() {
    List<Map<String, dynamic>> answers = [];
    answers.add({
      'Bun': 'Bun',
      'selected_answer': textControllerBun.text.toString(),
    });

    answers.add({
      'Cr': 'Cr',
      'selected_answer': textControllerCr.text.toString(),
    });

    answers.add({
      'PLT': 'PLT',
      'selected_answer': textControllerPLT.text.toString(),
    });

    answers.add({
      'PT': 'PT',
      'selected_answer': textControllerPT.text.toString(),
    });

    answers.add({
      'INR': 'INR',
      'selected_answer': textControllerINR.text.toString(),
    });


    answers.add({
      'HB': 'HB',
      'selected_answer': textControllerHB.text.toString(),
    });

    answers.add({
      'WBC': 'WBC',
      'selected_answer': textControllerWBC.text.toString(),
    });


    if(_selectedOption=='Positive')
      {
        answers.add({
          'Trop': 'Trop',
          'selected_answer': "1"
        });
      }else{
      answers.add({
        'Trop': 'Trop',
        'selected_answer': "0"
      });
    }

    if (widget.onClose != null) {
      widget.onClose(answers);
      Navigator.pop(context);
    }
  }


}
