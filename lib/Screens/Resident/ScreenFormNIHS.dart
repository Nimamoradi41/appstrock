import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';





class QuestionAnswer {
  final String question;
  final List<String> options;
  final int correctIndex;
  int? selectedAnswer;

  QuestionAnswer({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.selectedAnswer,
  });
}

class ScreenFormNIHS extends StatefulWidget {
  late void Function(List<Map<String, dynamic>>) onClose;


  ScreenFormNIHS(this.onClose,this.ISEdit);


  bool ISEdit;
  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ScreenFormNIHS> {
  List<QuestionAnswer> questions = [
    QuestionAnswer(
      question: 'Level of Consciousness',
      options: ['Alert', 'Drowsy', 'Stuporous', 'coma'],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'LOC Questions',
      options: ['Answers both correctly', 'Answers one correctly', 'Answers neither correctly'],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'LOC commands',
      options: ['Performs both tasks correctly', 'Performs one task correctly', 'Performs neither task correctly'],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'Best Gaze',
      options: ['Normal', 'Partial gaze palsy', 'Forced deviation'],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'Visual',
      options: ['No visual loss', 'Partial hemianopia', 'Complete hemianopia','Bilateral hemianopia'],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'Facial Palsy',
      options: ['Normal', 'Minor paralysis', 'Partial paralysis','Complete paralysis'],
      correctIndex: 0,
    ),
    QuestionAnswer(
      question: 'Motor Arm-left',
      options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
      correctIndex: 0,
    ),

    QuestionAnswer(
      question: 'Motor Arm-right',
      options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
      correctIndex: 0,
    ),

    QuestionAnswer(
      question: 'Motor Leg-left',
      options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
      correctIndex: 0,
    ),


    QuestionAnswer(
      question: 'Motor Leg- right',
      options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
      correctIndex: 0,
    ),



    QuestionAnswer(
      question: 'Limb Ataxia',
      options: ['Absent', 'Present in one limb','Present in two limbs'],
      correctIndex: 0,
    ),

    QuestionAnswer(
      question: 'Sensory',
      options: ['Normal', 'Mild-to-moderate sensory loss','Severe or total sensory loss'],
      correctIndex: 0,
    ),


    QuestionAnswer(
      question: 'Best Language',
      options: ['No aphasia', 'Mild-to-moderate aphasia','Severe aphasia','Mute, global aphasia'],
      correctIndex: 0,
    ),


    QuestionAnswer(
      question: 'Dysarthria',
      options: ['No aphasia', 'Mild-to-moderate aphasia','Severe aphasia'],
      correctIndex: 0,
    ),

    QuestionAnswer(
      question: 'Extinction and Inattention (formerly Neglect)',
      options: ['No neglect', 'Partial neglect','Complete neglect'],
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
                                child: TextAppfredoka('NIHSS',16,Colors.white,true),
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
                                              child: TextAppStartfredoka(questions[index].question,14 , Colors.black54, true)),
                                        ],
                                      ),

                                      SizedBox(height: 10),
                                      Column(
                                        children: List.generate(
                                          questions[index].options.length,
                                              (optionIndex) {
                                            return RadioListTile(
                                              title: TextAppStartfredoka(questions[index].options[optionIndex],14 , Colors.black87, true),
                                              value: optionIndex,
                                              groupValue: questions[index].selectedAnswer,
                                              onChanged: (value) {
                                                setState(() {
                                                  questions[index].selectedAnswer = value;
                                                });
                                              },
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
