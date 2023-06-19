
import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';

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
        title: Image.asset("assets/app/report.png", scale: 6),
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: Stack(
          children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color:cHeavyGrey
              )
            ),
              child: Image.file(picture)
          ),
            Column(
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
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
                    SizedBox(width: 15,),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: cDirtyWhiteColor.withOpacity(0.85)
                        ),
                        height: 50,
                        child: MaterialButton(
                            shape: CircleBorder(),
                            child: Text("GUARDAR",
                              style: TextStyle(
                                  color: cPrimaryLightColor
                              ),),
                            onPressed: () async {
                              Navigator.of(context).pop();
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
