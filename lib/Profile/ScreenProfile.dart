import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Constants.dart';



class ScreenProfile extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double wid=MediaQuery.of(context).size.width;
    wid=wid>600?600:wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            width: wid,
            height: double.infinity,
            // color: BackGroundApp,
            color: ColorApp,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 16,),
                  SvgPicture.asset('assets/Svg/pro.svg',width: wid*0.2,height: wid*0.2,),
                  SizedBox(height: 8,),
                  TextApp('پروفایل', 18, Colors.white, true),
                  SizedBox(height: 16,),
                  Expanded(
                    child: Container(
                      width: wid,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(32),topLeft: Radius.circular(32))
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 16,),
                                  Row(
                                    children: [
                                      SizedBox(width: 16,),
                                      Icon(Icons.edit,size: 30,color: ColorApp,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            TextApp('نام و نام خانوادگی', 12, Colors.black45, false),
                                            SizedBox(height: 8,),
                                            TextApp('نیما مرادی', 14, Colors.black87, true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16,),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: wid,
                                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                    color: Colors.black12,
                                    height: 2,
                                  ),
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      SizedBox(width: 16,),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            TextApp('کد ملی', 12, Colors.black45, false),
                                            SizedBox(height: 8,),
                                            TextApp('56454545', 14, Colors.black87, true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16,),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: wid,
                                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                    color: Colors.black12,
                                    height: 2,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 16,),

                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            TextApp('دپارتمان', 12, Colors.black45, false),
                                            SizedBox(height: 8,),
                                            TextApp('Ems', 14, Colors.black87, true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16,),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: wid,
                                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                    color: Colors.black12,
                                    height: 2,
                                  ),
                                  Row(
                                    children: [

                                      SizedBox(width: 16,),
                                      Icon(Icons.edit,size: 30,color: ColorApp,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [

                                            TextApp('شماره تلفن', 12, Colors.black45, false),
                                            SizedBox(height: 8,),
                                            TextApp('09909439787', 14, Colors.black87, true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16,),
                                    ],
                                  ),
                                  SizedBox(height: 8,),
                                  Container(
                                    width: wid,
                                    margin: EdgeInsets.symmetric(horizontal: 16,vertical: 4),
                                    color: Colors.black12,
                                    height: 2,
                                  ),
                                  Row(
                                    children: [

                                      SizedBox(width: 16,),
                                      Icon(Icons.edit,size: 30,color: ColorApp,),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [

                                            TextApp('رمز عبور', 12, Colors.black45, false),
                                            SizedBox(height: 8,),
                                            TextApp('********', 14, Colors.black87, true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 16,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextApp(VersionApp, 12, Colors.black54, true)
                        ],
                      ),

                    ),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
