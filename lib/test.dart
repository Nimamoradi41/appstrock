import 'package:flutter/material.dart';

import 'Constants.dart';
import 'Screens/Resident/ScreenDetailPatient.dart';
import 'Widgets/TextApp.dart';


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

class ExamForm extends StatefulWidget {
  late void Function(List<Map<String, dynamic>>) onClose;


  ExamForm(this.onClose);

  @override
  _ExamFormState createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 100,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: ColorApp,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8))
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextApp('NIHSS',16,Colors.white,true),
                      ),
                    ),
                    SizedBox(height: 16,),



                    // QuestionWidget
                    // Row(
                    //   children: [
                    //     Expanded(child: TextApp(
                    //       'Level of Consciousnees',14,Colors.black45,false
                    //     ))
                    //   ],
                    // ),
                    // SizedBox(height: 8,),
                    // Column(
                    //   children: [
                    //     Row(
                    //       children: [
                    //
                    //         Expanded(child: TextApp(
                    //             'Level of Consciousnees',14,Colors.black87,false
                    //         ))
                    //       ],
                    //     )
                    //   ],
                    // )





                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                _submitForm();
              },
              child: Container(
                width: 100,
                height: 100,
                color: Colors.red,
              ),
            ),
            ListView.builder(
              itemCount: questions.length,
              shrinkWrap: false,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorApp,width: 3)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextApp(questions[index].question,14 , Colors.black54, true),

                        SizedBox(height: 10),
                        Column(
                          children: List.generate(
                            questions[index].options.length,
                                (optionIndex) {
                              return RadioListTile(
                                title: TextApp3(questions[index].options[optionIndex],14 , Colors.black87, true),
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


          ],
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