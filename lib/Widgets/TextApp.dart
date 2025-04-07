import 'package:flutter/material.dart';


class TextApp extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextApp(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
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
class TextAppStartfredoka extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextAppStartfredoka(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
    return Text(Title,
      textAlign: TextAlign.start,
      style: TextStyle(
          color: Mcolor,
          fontFamily: 'fredoka',
          fontSize: Fontsize,
          fontWeight: Isbold==true?
          FontWeight.bold:FontWeight.normal
      ),);
  }
}
class TextAppStartfredokaCenter extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextAppStartfredokaCenter(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
    return Text(Title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Mcolor,
          fontFamily: 'fredoka',
          fontSize: Fontsize,
          fontWeight: Isbold==true?
          FontWeight.bold:FontWeight.normal
      ),);
  }
}

class TextAppfredoka extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextAppfredoka(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
    return Text(Title,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Mcolor,
          fontFamily: 'fredoka',
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
    Fontsize=Fontsize-1;
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

class TextApp4 extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextApp4(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Text(Title,
        textAlign: TextAlign.right,
        style: TextStyle(
            color: Mcolor,
            shadows: [

            ],
            fontSize: Fontsize,
            fontWeight: Isbold==true?
            FontWeight.bold:FontWeight.normal
        ),),
    );
  }
}


class TextApp3 extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextApp3(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
    return Text(Title,
      textAlign: TextAlign.start,
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


class TextApp5 extends StatelessWidget {

  String Title;
  double Fontsize;
  Color Mcolor;
  bool Isbold=false;


  TextApp5(this.Title, this.Fontsize, this.Mcolor, this.Isbold);


  @override
  Widget build(BuildContext context) {
    Fontsize=Fontsize-1;
    return Text(Title,
      textAlign: TextAlign.end,
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


