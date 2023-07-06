
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import '../utils/report/report_data.dart';

class ImagePreview extends StatefulWidget {
XFile pic;

  ImagePreview( this.pic, {super.key});

  @override
  State<StatefulWidget> createState() => ImagePreviewState();
}

class ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    File picture = File(widget.pic.path);
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset("assets/titles/report.png", scale: 6),
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: Stack(
          children: [
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                image: DecorationImage(image: FileImage(picture)),
                border: Border.all(
                  color:cHeavyGrey
                )
              ),
            ),
          ),
            Column(
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: cDirtyWhiteColor.withOpacity(0.85)
                        ),
                        height: 50,
                        child: MaterialButton(
                            shape: CircleBorder(),
                            child: Text("CANCELAR",
                              style: TextStyle(
                                  color: cPrimaryLightColor
                              ),),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            }
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: cDirtyWhiteColor.withOpacity(0.85)
                        ),
                        height: 50,
                        child: MaterialButton(
                            shape: CircleBorder(),
                            child: Text("ANEXAR",
                              style: TextStyle(
                                  color: cPrimaryLightColor
                              ),),
                            onPressed: () async {
                              Report.imagePath = widget.pic.path;
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
  ]
      ),
    );
  }
  
}
