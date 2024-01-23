import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Widgets/TextApp.dart';



const Color ColorTitleText=Color(0xff505050);
const Color Colorbutton=Color(0xff0266FD);
const Color BackGroundApp=Color(0xffDFE1E5);
const Color ColorApp=Color(0xff7B73E7);
const Color ColorTextsubject=Color(0xff989898);
const Color ColorTextbody=Color(0xff3F3F3F);





BoxDecoration MainDecoration=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
          color: Colors.black26,
          spreadRadius: 1,
          blurRadius: 4
      )
    ]
);


// Loading in All App
Future<void> ShowLoadingApp(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      double wid=MediaQuery.of(context).size.width;
      wid=wid>600?600:wid;
      return Scaffold(
        backgroundColor: Colors.transparent ,
        body:  Center(
          child: LoadingAnimationWidget.halfTriangleDot(
            color: ColorApp,
            size: 100,
          ),
        )
      );
    },
  );
}
// Loading in All App


// Login And Rigester Border
OutlineInputBorder outlinedBorderBlack=OutlineInputBorder(
  borderSide: const BorderSide(color: Colors.black26, width: 2),
  borderRadius: BorderRadius.circular(8),
);
OutlineInputBorder outlinedBorderPurple=OutlineInputBorder(
  borderSide: const BorderSide(color: ColorApp, width: 2),
  borderRadius: BorderRadius.circular(8),
);
// Login And Rigester Border

const String VersionApp='نسخه  1.0.0';


