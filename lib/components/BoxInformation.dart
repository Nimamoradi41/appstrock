import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Widgets/TextApp.dart';

class BoxInformation extends StatelessWidget {


  final String value;
  final String title;
  final VoidCallback? onTap;
  // Constructor with required arguments



  const BoxInformation({
    required this.value,
    required this.title,
    this.onTap, // مقدار پیش‌فرض null
  });




  @override
  Widget build(BuildContext context) {
     return    InkWell(
       onTap: onTap,
       child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
         child: Row(
           children: [
             TextApp(value, 14,
                 value== 'نامشخص' || value== 'تکمیل نشده است'
                     ? Color(0xFFF44336) : Color(0xFF4CAF50) , true),
             Expanded(child: Align(
                 alignment: Alignment.centerRight,
                 child: TextApp(title, 12, ColorTitleText, false))),
           ],
         ),
       ),
     );
  }
}
