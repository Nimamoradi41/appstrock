import 'package:flutter/material.dart';


class TextApp extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextApp(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    return Text(Title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Mcolor,
          fontSize: Fontsize,
          fontWeight: Isbold==true?
          FontWeight.bold:FontWeight.normal
      ),);
  }
}



class TextApp2 extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextApp2(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    return Text(Title,
      textAlign: TextAlign.right,
      style: TextStyle(
          color: Mcolor,
          shadows: [

          ],
          fontSize: Fontsize,
          fontWeight: Isbold==true?
          FontWeight.bold:FontWeight.normal
      ),);
  }
}
