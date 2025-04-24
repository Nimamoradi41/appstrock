import 'package:flutter/material.dart';

class staticWidget2 extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    debugPrint('❌ StaticWidget rebuilt!');
    return   Container(color: Colors.black);
  }
}
