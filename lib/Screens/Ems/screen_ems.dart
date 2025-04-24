
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
import '../Autentication/screen_EditProfile.dart';
import '../Reception/ApiServiceReception.dart';
import '../Reception/screen_reception.dart';
import 'ProviderEms/ProviderEms.dart';

 class ScreenEms extends StatefulWidget {
   late bool isAtend;
   ScreenEms(this.isAtend){}
   @override
  State<ScreenEms> createState() => _ScreenEmsState();
}

class _ScreenEmsState extends State<ScreenEms> {
   bool status=false;
   var items = [
     'مرد',
     'زن',
   ];

   late var Notifi=ProviderEms();

   bool _containsNonEnglishCharacters(String input) {
     RegExp _persianRegex = RegExp(r'^[\u0600-\u06FF\s]+$'); // محدوده کاراکترهای فارسی
     return _persianRegex.hasMatch(input);
   }

   Future RunAddP(BuildContext context)async{

     if(!Notifi.status)
       {
         showToast("ابتدا شیفت خود را فعال کنید",
             position: StyledToastPosition.top,
             context:context);
         return;
       }
     if(TextConName.text.isEmpty)
     {
       showToast("نام و نام خانوادگی را وارد کنید",
           position: StyledToastPosition.top,
           context:context);
       return;
     }

      if(!_containsNonEnglishCharacters(TextConName.text.toString()))
        {
          showToast("برای نام بیمار از کارکتر های انگلیسی استفاده نکنید",
              position: StyledToastPosition.top,
              context:context);
          return;
        }

     if(containsNumber(TextConName.text.toString()))
     {
       showToast("برای نام بیمار از اعداد استفاده نکنید",
           position: StyledToastPosition.top,
           context:context);
       return;
     }




     // var check=checkMeliCode(TextConCode.text.toString());
     // if(!check)
     // {
     //   ShowErrorMsg(context,'کدملی اشتباه است');
     //   return;
     // }


     Jalali date=Jalali.now();
     String formattedDate =
         '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
     // چاپ تاریخ جلالی با فرمت مورد نظر
     print('تاریخ جلالی فعلی: $formattedDate');
     ShowLoadingApp(context);

     var age=convertPersianNumbersToEnglish( TextConAge.text.toString());
     var  timestamp=DateTime.now().millisecondsSinceEpoch;
     var Data=await ApiServiceEms.AddPatient(TextConName.text,formattedDate,TextConCode.text.toString(),
         age,Notifi.dropdownvalue=='مرد'?2:1,context,timestamp);
     if(Data!=null)
     {
       if(Data.success)
       {
         // Ok Shode
         TextConAge.clear();
         TextConCode.clear();
         TextConName.clear();
         TextConGender.clear();
         Notifi.Refrsh();
         ShowSuccesMsg(context,'بیمار با موفقیت ثبت شد');
       }else{
         ShowErrorMsg(context, Data.message);
       }
     }
   }



   var TextConName=TextEditingController();

   var TextConCode=TextEditingController();

   var TextConAge=TextEditingController();

   var TextConGender=TextEditingController();

   Future   ChangShift(bool StatusNew,BuildContext context) async
   {


     ShowLoadingApp(context);
     // ignore: use_build_context_synchronously
     var Data= await ApiServiceReception.ChangeShiftStatus(context);

     if(Data!=null)
     {
       if(Data.success)
       {
         Notifi.setstatus(Data.data!.isOnline);
       }else{
         // ignore: use_build_context_synchronously
         ShowErrorMsg(context, Data.message);
       }
     }

     Navigator.pop(context);








   }
   Future ClearAllDate()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.clear();
     GoNextPageGameOver(context, SplashScreen());
   }

   Future GetInfo() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     if(prefs.getBool('isOnline')!=null)
       {
         status=prefs.getBool('isOnline')!;
         Notifi.setstatus(status);
       }


   }
   @override
  void initState() {
    super.initState();
    GetInfo();
  }
   @override
   Widget build(BuildContext context) {
     Notifi=Provider.of<ProviderEms>(context);
     double wid=MediaQuery.of(context).size.width;
     double hei=MediaQuery.of(context).size.height;
     wid=wid>600?600:wid;
     return SafeArea(
       child: Scaffold(
         resizeToAvoidBottomInset: false,
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
                               onTap: ()  async{
                                 if(widget.isAtend)
                                   {
                                     Navigator.pop(context);
                                   }else{

                                   var flag= await ShowAllow(context,"آیا از حساب خود خارج میشوید ؟");
                                   if(flag)
                                   {
                                     ClearAllDate();
                                   }


                                 }

                               } ,
                               child: const RotatedBox(
                                 quarterTurns: 90,
                                 child: Padding(
                                   padding: EdgeInsets.all(16.0),
                                   child: Icon(Icons.exit_to_app,color: Colors.white,size: 30,),
                                 ),
                               ),
                             ),
                             //  RotatedBox(
                             //   quarterTurns: 0,
                             //   child: InkWell(
                             //     onTap: (){
                             //       GoNextPage(context, screen_EditProfile());
                             //     },
                             //     child: Padding(
                             //       padding: EdgeInsets.all(16.0),
                             //       child: Icon(Icons.person,color: Colors.white,size: 30,),
                             //     ),
                             //   ),
                             // ),
                               Expanded(child:
                             Padding(
                                 padding: EdgeInsets.all(16.0),
                                 child: Text(
                                   widget.isAtend?'دکتر متخصص':'فوریت های پزشکی',
                                   textAlign: TextAlign.end,
                                   style: const TextStyle(
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
                         Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: const [
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
                               children: [
                                 Row(
                                   children: [
                                     SizedBox(width: 8,),
                                     Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Consumer<ProviderEms>(
                                         builder: (context,newstate,child){
                                           status=newstate.status;
                                           return FlutterSwitch(
                                             value: status,
                                             activeColor: Color(0xff38b000),
                                             onToggle: (val) {
                                               ChangShift(val,context);
                                             },
                                           );
                                         },
                                       ),
                                     ),
                                     Expanded(child: TextApp2('وضعیت شیفت',14,ColorTextsubject,false)),
                                     SizedBox(width: 4 ,)
                                   ],

                                 )
                               ],
                             ),
                           ),
                         ),


                         SizedBox(height: 8,),
                         Container(
                           decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: const [
                                 BoxShadow(
                                     color: Colors.black26,
                                     spreadRadius: 1,
                                     blurRadius: 4
                                 )
                               ]
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(2.0),
                             child: Consumer<ProviderEms>(
                               builder: (ctx,newstate,child){
                                 return SingleChildScrollView(
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: TextApp2('اطلاعات بیمار', 14, ColorTitleText, true),
                                       ),
                                       Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child:
                                           Container(
                                             width: double.infinity,
                                             child: Column(
                                               mainAxisAlignment: MainAxisAlignment.end,
                                               children: [
                                                 Align(
                                                   alignment: Alignment.centerRight,
                                                   child: TextAppEnd(
                                                       'نام و نام خانوادگی',14, ColorApp,false),
                                                 )  ,
                                                 SizedBox(height: 8),
                                                 TextField(
                                                     controller: TextConName,
                                                     style: const TextStyle(
                                                       fontFamily: 'rob',
                                                       fontSize: 13,
                                                     ),
                                                     textAlign:   TextAlign.right,
                                                     textDirection:  TextDirection.rtl,
                                                     keyboardType: TextInputType.text,
                                                     inputFormatters: [
                                                       FilteringTextInputFormatter.allow(RegExp(r'[۰-۹0-9\u0600-\u06CC ]')),
                                                     ],
                                                     decoration: InputDecoration(
                                                       labelStyle: const TextStyle(
                                                         color: ColorApp,
                                                       ),
                                                       counterText: "",
                                                       enabledBorder: outlinedBorderBlack,
                                                       focusedBorder: outlinedBorderPurple,
                                                     )
                                                 )
                                               ],
                                             ),
                                           )
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Column(
                                           children: [
                                             Align(
                                               alignment: Alignment.centerRight,
                                               child: TextAppEnd(
                                                   'کد ملی',14, ColorApp,false),
                                             ),
                                             TextField(
                                               maxLines: 1,
                                               maxLength: 10,
                                               textDirection: TextDirection.ltr, // جهت کلی متن
                                               textAlign: TextAlign.left, // متن ورودی راست‌چین باشد
                                               keyboardType: TextInputType.phone,
                                               controller: TextConCode,
                                               style: const TextStyle(
                                                   fontSize: 13
                                               ),
                                               decoration: InputDecoration(
                                                 labelStyle: TextStyle(
                                                     color: ColorApp
                                                 ),
                                                 counterText: "",
                                                 enabledBorder: outlinedBorderBlack,
                                                 focusedBorder: outlinedBorderPurple,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Column(
                                           children: [
                                             Align(
                                               alignment: Alignment.centerRight,
                                               child: TextAppEnd(
                                                   'سن',14, ColorApp,false),
                                             ),
                                             TextField(
                                               maxLines: 1,
                                               maxLength: 10,
                                               textDirection: TextDirection.ltr, // جهت کلی متن
                                               textAlign: TextAlign.left, // متن ورودی راست‌چین باشد
                                               keyboardType: TextInputType.phone,
                                               controller: TextConAge,
                                               style: const TextStyle(
                                                   fontSize: 13
                                               ),
                                               decoration: InputDecoration(
                                                 labelStyle: TextStyle(
                                                     color: ColorApp
                                                 ),
                                                 counterText: "",
                                                 enabledBorder: outlinedBorderBlack,
                                                 focusedBorder: outlinedBorderPurple,
                                               ),
                                             ),
                                           ],
                                         ),
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Directionality(
                                           textDirection: TextDirection.rtl,
                                           child: DropdownButtonFormField(
                                             value: Notifi.dropdownvalue,
                                             decoration: const InputDecoration(
                                               border: OutlineInputBorder(
                                                 borderRadius:   BorderRadius.all(
                                                   Radius.circular(8.0),
                                                 ),
                                               ),
                                             ),
                                             items: items.map((String items) {
                                               return DropdownMenuItem(
                                                 value: items,
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.end,
                                                   children: [
                                                     Text(
                                                       items,),
                                                   ],
                                                 ),
                                               );
                                             }).toList(),
                                             onChanged: (value) {
                                             Notifi.setdropdownvalue(value.toString());
                                           },
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
                                                 padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                     RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(8.0),
                                                     )
                                                 )
                                             ),
                                             child:Padding(
                                               padding: const EdgeInsets.all(4.0),
                                               child: Text('ثبت بیمار',
                                                 style: TextStyle(color:Colors.white,
                                                     fontSize: 12,
                                                     fontWeight: FontWeight.bold),),
                                             )),
                                       ),
                                       SizedBox(height: 8,)
                                     ],
                                   ),
                                 );
                               },

                             ),
                           ),
                         ),







                       ],
                     ),
                   ),
                 ),



               ],
             ),
           ),
         ),
       ),
     );
   }
}

