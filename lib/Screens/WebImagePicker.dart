import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants.dart';
import '../Widgets/TextApp.dart';
import 'Autentication/Models/ModelLogin.dart';
import 'Resident/Models/ModelNeetToCt.dart';


class WebImagePicker extends StatefulWidget {

  String name;
  String age;
  String nationalCode;
  String gender;
  String patientID;


  WebImagePicker(this.name, this.age, this.nationalCode, this.gender,this.patientID);

  @override
  _WebImagePickerState createState() => _WebImagePickerState();
}

class _WebImagePickerState extends State<WebImagePicker> {
  Uint8List? _imageData;


  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final uri = Uri.parse("https://api.appstrok.ir/Patients/AddImages");
    final request = http.MultipartRequest('POST', uri);


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? UserId;

    // UserId

    if(prefs.getString('UserId')!=null)
    {
      UserId=prefs.getString('UserId')!;
    }

    // فیلدهای متنی
    request.fields['patientId'] = widget.patientID;
    request.fields['userId'] = UserId.toString();


    request.files.add(
      http.MultipartFile.fromBytes(
        'Images',
        imageBytes,
        filename: fileName,
        contentType: getMediaType(fileName),
      ),
    );

    try {
      setState(() {
        isLoading=true;
      });
      final response = await request.send();
      setState(() {
        isLoading=false;
      });

      if (response.statusCode == 200) {
        ShowSuccesMsg(context, 'عملیات با موفقیت انجام شد');
      } else if(response.statusCode==400)
      {
        String str= await response.stream.bytesToString();
        ModelLogin data=   modelLoginFromJson(str);
        ShowErrorMsg(context,data.message);
      }
      else if(response.statusCode==403)
      {
        String str= await response.stream.bytesToString();
        ModelLogin data=   modelLoginFromJson(str);
        ShowErrorMsg(context,data.message);

      }
    } catch (e) {
      print("خطای شبکه: $e");
    }
  }


  void _pickImage() {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files?.first;
      if (file != null) {
        final reader = html.FileReader();
        reader.readAsArrayBuffer(file);
        reader.onLoadEnd.listen((event) {
          setState(() {
            _imageData = reader.result as Uint8List;
            imageSelected = true;
          });
        });
      }
    });
  }

  var isLoading = false;
  var imageSelected = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery
        .of(context)
        .size
        .width;
    double hei = MediaQuery
        .of(context)
        .size
        .height;
    wid = wid > 600 ? 600 : wid;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : Container(
            width: wid,
            height: double.infinity,
            color: BackGroundApp,
            child: Stack(
              children: [
                Container(
                  width: wid,
                  height: wid * 0.25,
                  color: ColorApp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, top: 16, right: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              const Expanded(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'اطلاعات بیمار',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12),
                                          )

                                        // TextApp('فوریت های پزشکی', 16, Colors.white, true),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: wid * 0.14,
                  right: 16,
                  left: 16,
                  child: SizedBox(
                    width: wid * 0.85,
                    height: hei * 0.88,
                    child: Column(
                      children: [
                        Container(
                          decoration: MainDecoration,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 8.0, left: 8, top: 8),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            TextApp('کدملی', 10, ColorTitleText, false),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            TextApp(
                                                widget.nationalCode,
                                                12,
                                                ColorTextbody,
                                                true)
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.black12,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            TextApp('نام و نام خانوادگی', 10,
                                                ColorTitleText, false),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            TextApp(
                                                widget.name,
                                                12,
                                                ColorTextbody,
                                                true)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            TextApp('سن', 12, ColorTitleText,
                                                false),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            TextApp(
                                                widget.age,
                                                14,
                                                ColorTextbody,
                                                true)
                                          ],
                                        )),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.black12,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [
                                            TextApp('جنسیت', 12,
                                                ColorTitleText, false),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            TextApp(
                                                widget.gender,
                                                14,
                                                ColorTextbody,
                                                true)
                                          ],
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Expanded(
                          child: Container(
                            decoration: MainDecoration,
                            child: Column(
                              children: [
                                  Expanded(
                                  child: Container(
                                    width: wid,
                                    margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                        color: Colors.grey, // رنگ کادر
                                        width: 2,
                                        // ضخامت کادر
                                      ),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child:imageSelected ?
                                            Center(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(12),
                                                  child: Image.memory(
                                                    _imageData!,
                                                    width: wid,
                                                    height: 300,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ):Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Icon(Icons.image, size: 150, color: Colors.grey),
                                                ),
                                                SizedBox(height: 8),
                                                Text("عکس خود را انتخاب کنید", style: TextStyle(fontSize: 16)),
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 4.0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  _pickImage();
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all(
                                                        ColorApp),
                                                    padding:
                                                    MaterialStateProperty
                                                        .all(EdgeInsets
                                                        .all(4)),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                        RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                        ))),
                                                child: const Padding(
                                                  padding:
                                                  EdgeInsets
                                                      .all(8.0),
                                                  child: Text(
                                                    'انتخاب عکس جدید',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                )),
                                          )),
                                      Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 4.0),
                                            child: ElevatedButton(
                                                onPressed: () async {
                                                  var flag = await ShowAllow(
                                                      context, "آپلود شود ؟");
                                                  if (flag) {
                                                    String timestampBase36 = DateTime
                                                        .now()
                                                        .millisecondsSinceEpoch
                                                        .toString();
                                                    uploadImage(_imageData!,
                                                        "img_$timestampBase36.png");
                                                  }
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                    MaterialStateProperty
                                                        .all(
                                                        ColorApp),
                                                    padding:
                                                    MaterialStateProperty
                                                        .all(EdgeInsets
                                                        .all(4)),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                        RoundedRectangleBorder>(
                                                        RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8.0),
                                                        ))),
                                                child: const Padding(
                                                  padding:
                                                  EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'آپلود',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.white,
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                )),
                                          ))
                                    ],
                                  ),
                                )
                              ],
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
