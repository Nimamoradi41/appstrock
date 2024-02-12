import 'package:flutter/material.dart';

import 'Constants.dart';
import 'Screens/Resident/ScreenDetailPatient.dart';
import 'Widgets/TextApp.dart';


class test extends StatefulWidget {


  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {

  int SelectedOne = 0;


  List<Widget> questions=[];
  @override
  void initState() {
    super.initState();
      questions = [
      QuestionWidget(
        "What is the capital of France?",
        ["Paris", "London", "Rome", "Berlin"],
        SelectedOne,
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
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
                    Column(
                      children: questions,
                    ),
                    InkWell(
                      onTap: (){
                        print(SelectedOne.toString());
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.red,
                      ),
                    )
                    // Row(
                    //   children: [
                    //     Expanded(child: TextApp(
                    //         'Level of Consciousnees',14,Colors.black45,false
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
          ],
        ),
      ),
    );
  }
}
