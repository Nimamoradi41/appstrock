import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import 'ItemNIHS.dart';





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
  late void Function(List<Map<String, dynamic>>,int Score) onClose;
  ScreenFormNIHS(
      this.onClose,
      this.ISEdit,
      this.n_1_a,
      this.n_1_b,
      this.n_1_c,
      this.n_2,
      this.n_3,
      this.n_4,
      this.n_5_a,
      this.n_5_b,
      this.n_6_a,
      this.n_6_b,
      this.n_7,
      this.n_8,
      this.n_9,
      this.n_10,
      this.n_11,
      this.isAtend,
      this.subscroe); // ScreenFormNIHS(this.onClose,this.ISEdit,this.DataEdit);




  bool ISEdit;
  String n_1_a;
  String n_1_b;
  String n_1_c;
  String n_2;
  String n_3;
  String n_4;
  String n_5_a;
  String n_5_b;
  String n_6_a;
  String n_6_b;
  String n_7;
  String n_8;
  String n_9;
  String n_10;
  String n_11;
  int subscroe;
  bool isAtend;
  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ScreenFormNIHS> {

  List<QuestionAnswer> questions=[];
  @override
  void initState() {
    super.initState();
    int n_1_aNumber=0;
    int n_1_bNumber=0;
    int n_1_cNumber=0;
    int n_2Number=0;
    int n_3Number=0;
    int n_4Number=0;
    int n_5_aNumber=0;
    int n_5_bNumber=0;
    int n_6_aNumber=0;
    int n_6_bNumber=0;
    int n_7Number=0;
    int n_8Number=0;
    int n_9Number=0;
    int n_10Number=0;
    int n_11Number=0;
    if(widget.ISEdit)
      {
          n_1_aNumber=int.parse(widget.n_1_a);
          n_1_bNumber=int.parse(widget.n_1_b);
          n_1_cNumber=int.parse(widget.n_1_c);
          n_2Number=int.parse(widget.n_2);
          n_3Number=int.parse(widget.n_3);
          n_4Number=int.parse(widget.n_4);
          n_5_aNumber=int.parse(widget.n_5_a);
          n_5_bNumber=int.parse(widget.n_5_b);
          n_6_aNumber=int.parse(widget.n_6_a);
          n_6_bNumber=int.parse(widget.n_6_b);
          n_7Number=int.parse(widget.n_7);
          n_8Number=int.parse(widget.n_8);
          n_9Number=int.parse(widget.n_9);
          n_10Number=int.parse(widget.n_10);
          n_11Number=int.parse(widget.n_11);
          try{
            Score=widget.subscroe;
          }catch(s)
          {}
      }





    questions.add(  QuestionAnswer(
        question: 'Level of Consciousness',
        options: ['Alert', 'Drowsy', 'Stuporous', 'coma'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_1_aNumber:
        0
    ));

    questions.add(   QuestionAnswer(
        question: 'LOC Questions',
        options: ['Answers both correctly', 'Answers one correctly', 'Answers neither correctly'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_1_bNumber:
        0
    ));

    questions.add(   QuestionAnswer(
        question: 'LOC commands',
        options: ['Performs both tasks correctly', 'Performs one task correctly', 'Performs neither task correctly'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_1_cNumber:
        0
    ));




    questions.add(    QuestionAnswer(
        question: 'Best Gaze',
        options: ['Normal', 'Partial gaze palsy', 'Forced deviation'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_2Number:
        0
    ));




    questions.add(     QuestionAnswer(
        question: 'Visual',
        options: ['No visual loss', 'Partial hemianopia', 'Complete hemianopia','Bilateral hemianopia'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_3Number:
        0
    ));



    questions.add(     QuestionAnswer(
        question: 'Facial Palsy',
        options: ['Normal', 'Minor paralysis', 'Partial paralysis','Complete paralysis'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_4Number:
        0
    ));



    questions.add(     QuestionAnswer(
        question: 'Motor Arm-left',
        options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_5_aNumber:
        0
    ));

    questions.add(     QuestionAnswer(
        question: 'Motor Arm-right',
        options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_5_bNumber:
        0
    ));

    questions.add(     QuestionAnswer(
        question: 'Motor Leg-left',
        options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_6_aNumber:
        0
    ));



    questions.add(     QuestionAnswer(
        question: 'Motor Leg- right',
        options: ['No drift', 'Drift', 'Some effort against gravity','No effort against gravity','No movement'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_6_bNumber:
        0
    ));
    //

    questions.add(     QuestionAnswer(
        question: 'Limb Ataxia',
        options: ['Absent', 'Present in one limb','Present in two limbs'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_7Number:
        0
    ));

    questions.add(     QuestionAnswer(
        question: 'Sensory',
        options: ['Normal', 'Mild-to-moderate sensory loss','Severe or total sensory loss'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_8Number:
        0
    ));
    questions.add(      QuestionAnswer(
        question: 'Best Language',
        options: ['No aphasia', 'Mild-to-moderate aphasia','Severe aphasia','Mute, global aphasia'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_9Number:
        0
    ));


    questions.add(     QuestionAnswer(
        question: 'Dysarthria',
        options: ['No aphasia', 'Mild-to-moderate aphasia','Severe aphasia'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_10Number:
        0
    ));

    questions.add(     QuestionAnswer(
        question: 'Extinction and Inattention (formerly Neglect)',
        options: ['No neglect', 'Partial neglect','Complete neglect'],
        correctIndex: 0,
        selectedAnswer:
        widget.ISEdit?
        n_11Number:
        0
    ));


    setState(() {

    });
  }


  Future Run()async{
    _submitForm();
  }


  int Selected1=0;
  int Score=0;


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
            color: Colors.white,
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
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                              //       child: TextAppfredoka('Score : ',16,Colors.white,true),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                              //       child: TextAppfredoka('16',16,Colors.white,true),
                              //     ),
                              //
                              //   ],
                              // ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                      child: TextAppfredoka('NIHSS',16,Colors.white,true),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                                      child: TextAppfredoka('Score = '+Score.toString(),16,Colors.white,true),
                                    )

                                  ],
                                ),
                              )
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 8),
                              //   child: TextAppfredoka('NIHSS'+'Score = '+Score.toString(),16,Colors.white,true),
                              // ),



                            ],
                          ),
                        ),


                        SizedBox(height: 8,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: questions.length,
                            itemBuilder: (context, index) {
                              return  ItemNIHS(index,questions[index],questions,Score,(){
                                int i=0;
                               questions.forEach((element) {
                                 i=i+element.selectedAnswer!!;
                                });
                               Score=i;
                               setState(() {

                               });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 8,),
                  widget.isAtend?
                    Container():
                   Column(
                  children: [
                    Container(
                      width: wid*0.9,
                      child: ElevatedButton(onPressed:(){
                        Navigator.pop(context);
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
                            child: Text( widget.ISEdit ? 'ویرایش' :  'تکمیل فرم',
                              style: TextStyle(color:Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),),
                          )),
                    ),
                    SizedBox(height: 8,),
                  ],
                )




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
      widget.onClose(answers,Score);
    }
  }
}
