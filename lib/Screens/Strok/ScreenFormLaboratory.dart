import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import '../Resident/ScreenFormNIHS.dart';







class ScreenFormLaboratory extends StatefulWidget {
  late void Function(List<Map<String, dynamic>>) onClose;
  ScreenFormLaboratory(this.onClose,this.ISEdit);
  bool ISEdit;
  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ScreenFormLaboratory> {

  @override
  void initState() {
    super.initState();

  }

  Future Run()async{
    if(textControllerBun.text.toString().isEmpty)
    {
      showToast("Bun isEmpty",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }

    if(textControllerCr.text.toString().isEmpty)
    {
      showToast("Cr isEmpty",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }

    if(textControllerPLT.text.toString().isEmpty)
    {
      showToast("PLT isEmpty",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }

    if(textControllerPT.text.toString().isEmpty)
    {
      showToast("PT isEmpty",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }

    if(textControllerINR.text.toString().isEmpty)
    {
      showToast("INR isEmpty",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }

    if(textControllerTrop.text.toString().isEmpty)
    {
      showToast("Trop isEmpty",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }



    if(textControllerTrop.text.toString()!='0'&&textControllerTrop.text.toString()!='1')
    {
      showToast("Trop Not Valid",
          position: StyledToastPosition.top,
          context:context);
      return ;
    }

    var Res=await ShowAllow(context,'آیا از تکمیل فرم مطمئن هستید ؟');
     if(Res)
       {
         _submitForm();
       }
  }



  var textControllerBun=TextEditingController();
  var textControllerCr=TextEditingController();
  var textControllerPLT=TextEditingController();
  var textControllerPT=TextEditingController();
  var textControllerINR=TextEditingController();
  var textControllerTrop=TextEditingController();
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          controller: textControllerBun,
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          maxLines: 1,
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          controller: textControllerPT,
                                          decoration: InputDecoration(
                                            labelText: 'PT',
                                            labelStyle: TextStyle(
                                                color: ColorApp
                                            ),
                                            counterText: "",

                                            enabledBorder: outlinedBorderBlack,
                                            focusedBorder: outlinedBorderPurple,


                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          maxLines: 1,
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
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: TextField(
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          controller: textControllerTrop,
                                          decoration: InputDecoration(
                                            labelText: 'Trop',
                                            labelStyle: TextStyle(
                                                color: ColorApp
                                            ),
                                            counterText: "",

                                            enabledBorder: outlinedBorderBlack,
                                            focusedBorder: outlinedBorderPurple,


                                          ),
                                        ),
                                      ),
                                    ),
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
                // InkWell(
                //   onTap: (){
                //     _submitForm();
                //   },
                //   child: Container(
                //     width: 100,
                //     height: 100,
                //     color: Colors.red,
                //   ),
                // ),

                SizedBox(height: 8,),

                Container(
                  width: wid*0.9,
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
                        child: Text( widget.ISEdit ? 'ویرایش فرم' :  'تکمیل فرم',
                          style: TextStyle(color:Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),),
                      )),
                ),
                SizedBox(height: 8,),



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
      'Trop': 'Trop',
      'selected_answer': textControllerTrop.text.toString(),
    });


    if (widget.onClose != null) {
      widget.onClose(answers);
      Navigator.pop(context);
    }
  }
}
