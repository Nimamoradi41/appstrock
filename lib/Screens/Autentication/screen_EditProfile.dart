
import 'package:appstrock/Screens/Ems/ApiServiceEms.dart';
import 'package:appstrock/Screens/SplashScreen.dart';
import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/screen_reception.dart';
 class screen_EditProfile extends StatefulWidget {
  const screen_EditProfile({super.key});

   @override
  State<screen_EditProfile> createState() => _ScreenEmsState();
}

class _ScreenEmsState extends State<screen_EditProfile> {
   bool status=false;
   var items = [
     'مرد',
     'زن',
   ];


   Future RunAddP(BuildContext context)async{

     var Flag=await ShowAllow(context,'آیا از ویرایش مطمئن هستید ؟');
     if(Flag)
     {

       ShowLoadingApp(context);
       var Data=await ApiServiceEms.EditProfile(
           TextName.text.toString(),
           TextCodeMeli.text.toString(),
           TextPass.text.toString(),
           context);


       if(Data!=null)
       {
         if(Data.success)
         {
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.clear();
           ShowSuccesMsg(context,'اطلاعات با موفقیت ویرایش شد');
           GoNextPageGameOver(context,SplashScreen());

         }else{
           ShowErrorMsg(context, Data.message);
         }
       }
     }
   }



   var TextName=TextEditingController();

   var TextCodeMeli=TextEditingController();

   var TextPass=TextEditingController();

   var TextConGender=TextEditingController();






   Future GetInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if(prefs.getBool('isOnline')!=null)
       {
         TextName.text=prefs.getString('Name')!;
         TextCodeMeli.text=prefs.getString('Code')!;
         TextPass.text=prefs.getString('Pass')!;
         setState(() {

         });
       }


   }
   @override
  void initState() {
    super.initState();
    GetInfo();
  }
   @override
   Widget build(BuildContext context) {
     double wid=MediaQuery.of(context).size.width;
     double hei=MediaQuery.of(context).size.height;
     wid=wid>600?600:wid;
     return SafeArea(
       child: Scaffold(
         body: Center(
           child: Container(
             width: wid,
             height: double.infinity,
             color: BackGroundApp,
             child: Stack(
               children: [
                 Container(
                   width: wid,
                   height: wid*0.25,
                   color: ColorApp,
                   child:   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(width: 16,),
                       Expanded(
                         child: Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.end,
                           children:   [
                             InkWell(
                               onTap: () {
                                Navigator.pop(context);
                               } ,
                               child: const RotatedBox(
                                 quarterTurns: 90,
                                 child: Padding(
                                   padding: EdgeInsets.all(16.0),
                                   child: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                                 ),
                               ),
                             ),
                             const RotatedBox(
                               quarterTurns: 0,
                               child: Padding(
                                 padding: EdgeInsets.all(16.0),
                                 child: Icon(Icons.person,color: Colors.white,size: 30,),
                               ),
                             ),
                             const Expanded(child:
                             Padding(
                                 padding: EdgeInsets.all(16.0),
                                 child: Text(
                                   'تغییر اطلاعات کاربری',
                                   textAlign: TextAlign.end,
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                       fontSize: 16
                                   ),
                                 )

                               // TextApp('فوریت های پزشکی', 16, Colors.white, true),
                             )),
                           ],
                         ),
                       )
                     ],
                   ),
                 ),
                 Positioned(
                   top: wid*0.14,
                   right: 16,
                   left: 16,
                   child: Container(
                     width: wid*0.85,

                     child: Column(
                       children: [



                         SizedBox(height: 24,),
                         Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                     color: Colors.black26,
                                     spreadRadius: 1,
                                     blurRadius: 4
                                 )
                               ]
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.end,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: TextApp2('اطلاعات کاربر', 18, ColorTitleText, true),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(16.0),
                                   child: Directionality(
                                     textDirection: TextDirection.rtl,
                                     child: TextField(
                                       controller: TextName,
                                       decoration: InputDecoration(
                                         labelText: 'نام خانوادگی',
                                         disabledBorder:OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8)
                                         ),
                                         border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8)
                                         ),

                                       ),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(16.0),
                                   child: Directionality(
                                     textDirection: TextDirection.rtl,
                                     child: TextField(
                                       controller: TextCodeMeli,
                                        maxLength: 11,
                                       decoration: InputDecoration(
                                         labelText: 'کد ملی',
                                         disabledBorder:OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8)
                                         ),
                                         border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8)
                                         ),

                                       ),
                                     ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(16.0),
                                   child: Directionality(
                                     textDirection: TextDirection.rtl,
                                     child: TextField(
                                       controller: TextPass,
                                       decoration: InputDecoration(
                                         labelText: 'رمز عبور',
                                         disabledBorder:OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8)
                                         ),
                                         border: OutlineInputBorder(
                                             borderRadius: BorderRadius.circular(8)
                                         ),

                                       ),
                                     ),
                                   ),
                                 ),
                                 Container(
                                   width: wid,
                                   margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                                   child: ElevatedButton(onPressed: (){
                                     RunAddP(context);
                                   },
                                       style: ButtonStyle(
                                           backgroundColor: MaterialStateProperty.all(ColorApp),
                                           padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                                           shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                               RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(8.0),
                                               )
                                           )
                                       ),
                                       child:const Padding(
                                         padding: EdgeInsets.all(10.0),
                                         child: Text('ویرایش',
                                           style: TextStyle(color:Colors.white,
                                               fontSize: 16,
                                               fontWeight: FontWeight.bold),),
                                       )),
                                 ),
                                 SizedBox(height: 8,)
                               ],
                             ),
                           ),
                         ),







                       ],
                     ),
                   ),
                 ),
                 Positioned(
                     bottom: 8,
                     right: 8,
                     left: 8,
                     child: TextApp(VersionApp, 12, Colors.black54, true))


               ],
             ),
           ),
         ),
       ),
     );
   }
}

