import 'package:flutter/material.dart';

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
  List<QuestionAnswer> questions = [
    QuestionAnswer(
      question: 'آیا از داروهای خاصی استفاده می‌کنید؟',
      options: [ 'خیر','بله، داروهای فشار خون',],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'آیا به هر نوعی از حساسیت‌ها یا آلرژی‌ها مبتلا هستید؟',
      options: [ 'خیر','بله، حساسیت به آنتی‌بیوتیک‌ها',],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'آیا اخیراً عمل جراحی یا درمان خاصی داشته‌اید؟',
      options: [ 'خیر','بله، عمل جراحی سزارین',],
      correctIndex: 0,
    ),

  ];
  @override
  void initState() {
    super.initState();

  }


  Future Run()async{

    var Res=await ShowAllow(context,'آیا از تکمیل فرم مطمئن هستید ؟');
     if(Res)
       {
         _submitForm();
         // ignore: use_build_context_synchronously
       }
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
                                child: TextApp('Laboratory',16,Colors.white,true),
                              ),
                              Spacer(),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: questions.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all( color: Colors.black45,width: 3)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: TextApp4(questions[index].question,14 , Colors.black54, true)),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Column(
                                        children: List.generate(
                                          questions[index].options.length,
                                              (optionIndex) {
                                            return Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: RadioListTile(
                                                title: TextApp3(questions[index].options[optionIndex],14 , Colors.black87, true),
                                                value: optionIndex,
                                                groupValue: questions[index].selectedAnswer,
                                                onChanged: (value) {
                                                  setState(() {
                                                    questions[index].selectedAnswer = value;
                                                  });
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
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
    for (var question in questions) {
      answers.add({
        'question': question.question,
        'selected_answer': question.selectedAnswer,
      });
    }



    if (widget.onClose != null) {
      widget.onClose(answers);
    }
  }
}
