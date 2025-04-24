import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import 'StaticWidget.dart';

class testt extends StatelessWidget {
  const testt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignalR Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async{
            // var Data = await ApiServiceResident.signalTest(context );
            // print(Data);
            // GoNextPage(context,staticWidget2());

            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Scaffold(body: Text("Test Page")),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
          },


          child: Text("Send Message4"),
        ),
      ),
    );
  }
}
