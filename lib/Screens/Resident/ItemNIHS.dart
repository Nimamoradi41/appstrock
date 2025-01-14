import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../Widgets/TextApp.dart';
import 'ScreenFormNIHS.dart';


class ItemNIHS extends StatefulWidget {


  QuestionAnswer Que;
  int Index;
  int score;
  List<QuestionAnswer> questions;
  VoidCallback _onTap;

  ItemNIHS(this.Index,this.Que,this.questions,this.score,this._onTap);

  @override
  State<ItemNIHS> createState() => _ItemNIHSState();
}



class _ItemNIHSState extends State<ItemNIHS> {

  void Check() {
    widget.score=0;
    widget.questions.forEach((element) {
      widget.score=widget.score+element.selectedAnswer!!;
    });



    widget._onTap();

  }

  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return Center(
      child: Container(
        width: wid,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8,),
            TextAppStartfredoka(widget.Index.toString()+' '+widget.Que.question,14 , Colors.black87, true),
            SizedBox(height: 16,),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 4),
                child: Row(
                  children:List.generate(
                    widget.Que.options.length,
                        (optionIndex) {
                      return Expanded(child:
                      InkWell(
                        onTap: (){
                          widget.Que.selectedAnswer =optionIndex;
                          Check();
                          setState((){});
                        },
                        child: Container(
                            decoration: widget.Que.selectedAnswer ==optionIndex ? BoxDecoration(
                                color: ColorApp,
                                borderRadius: BorderRadius.circular(8)
                            ): BoxDecoration(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
                              child: TextAppStartfredokaCenter(optionIndex.toString(),16 ,widget.Que.selectedAnswer ==optionIndex ? Colors.white: Colors.black87, true),
                            )),
                      ));
                    },
                  ) ,
                ),
              ),

            ),
            SizedBox(height: 16,),
            Row(
              children: [
                Expanded(child: TextAppStartfredokaCenter(widget.Que.options[widget.Que.selectedAnswer!].toString(),16 , Colors.black87, true)),
              ],
            ),
            SizedBox(height: 64,),

          ],
        ),
      ),
    );
  }
}
