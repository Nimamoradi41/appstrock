import 'package:appstrock/Widgets/TextApp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import 'ApiServiceAtend.dart';
import 'model/ModelImages.dart';

class ScreenListImages extends StatefulWidget {

  String Id;


  ScreenListImages(this.Id)
  {}
  @override
  State<ScreenListImages> createState() => _ScreenListImagesState();
}

class _ScreenListImagesState extends State<ScreenListImages> {




  Future   getImages(String id,BuildContext context) async
  {
      ShowLoadingApp(context);
      // ignore: use_build_context_synchronously
      var Data= await ApiServiceAtend.GetPatientImages(widget.Id.toString(),context);


      if(Data!=null)
      {
        if(Data.success)
        {
          list=Data.data!;
          setState(() {

          });
        }else{
          // ignore: use_build_context_synchronously
          ShowErrorMsg(context, Data.message);
        }
      }


    }

  List<ModelImageItem> list=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImages(widget.Id,context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorApp,
        title: const Text('عکس های ارسالی'),
        centerTitle: true,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,))
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount:list.length ,
          itemBuilder: (ctx,item){
            return  Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.all(8),
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Image.network(list[item].image,fit: BoxFit.fill,),
                  ),
                  Row(
                    children: [
                      Expanded(child:Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextApp(
                            list[item].userName,
                            14,
                            Colors.black87,
                            true
                          ),
                        ],
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      TextApp(': ارسال شده توسط ', 12, Colors.black38,true)
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextApp(
                            list[item].insertDate,
                            14,
                            Colors.black87,
                            true
                        ),
                        SizedBox(width: 8,),
                        TextApp(
                            list[item].insertTime,
                            14,
                            Colors.black87,
                            true
                        )
                    ],
                  )
                     ),
                      SizedBox(
                        width: 8,
                      ),
                      TextApp(': ارسال شده در ', 12, Colors.black38,true)
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
