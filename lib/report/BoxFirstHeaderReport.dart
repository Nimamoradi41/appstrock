import 'package:flutter/material.dart';

import '../Widgets/TextApp.dart';


class BoxFirstHeaderReport extends StatelessWidget {

  String count;
  String text;


  BoxFirstHeaderReport(this.count, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.indigo[50],
          borderRadius: const BorderRadius.all(Radius.circular(8))
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            const SizedBox(width: 8,),
            Expanded(child: TextAppFromStart(count, 16, Colors.black87, true)),
            const SizedBox(width: 8,),
            TextApp(text, 14, Colors.black54, true),
            const SizedBox(width: 8,),
          ],
        ),
      ),
    );
  }
}
