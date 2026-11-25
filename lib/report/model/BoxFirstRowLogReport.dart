import 'package:flutter/material.dart';

import '../../Widgets/TextApp.dart';

class BoxFirstRowLogReport extends StatelessWidget {
  String name;
  String activity;
  String time;
  int index;

  BoxFirstRowLogReport(this.name, this.activity, this.time, this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: index % 2 == 0 ? Colors.grey[50] : Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: Text(time),
                )),
            Expanded(
                flex: 2,
                child: Center(
                  child: Text(activity),
                )),
            Expanded(flex: 2, child: TextApp(name, 14, Colors.black, true)),
          ],
        ),
      ),
    );
  }
}
