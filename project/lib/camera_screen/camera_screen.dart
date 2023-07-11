
import 'package:UniVerse/consts/color_consts.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'image_preview.dart';


class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen( {super.key, required this.cameras});

  @override
  State<StatefulWidget> createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  late CameraController controller;

  @override
void initState(){
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if(!mounted)
        return;
      setState(() {
      });
    }).catchError((Object e) {
      if(e is CameraException) {
        switch(e.code) {
          case 'CameraAccessDenied':
            print("denied");
            break;
          default:
            print(e.description);
            break;
        }
      }
    });
  }

@override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.value.isInitialized
      ?Stack(
                children: [
                  Container(
                    height: double.infinity,
                    child: CameraPreview(controller),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
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
                          SizedBox(width: 15),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: cPrimaryLightColor,
                                      width: 3
                                  ),
                                  color: cDirtyWhiteColor.withOpacity(0.90)
                              ),
                              height: 75,
                              width: 75,
                              child: MaterialButton(
                                  shape: CircleBorder(),
                                  child: Icon(Icons.camera_alt, size: 25,
                                    color: cHeavyGrey,),
                                  onPressed: () async {
                                    if (!controller.value.isInitialized)
                                      return null;
                                    if (controller.value.isTakingPicture)
                                      return null;
                                    try {
                                      await controller.setFlashMode(
                                          FlashMode.auto);
                                      await controller.setFocusMode(
                                          FocusMode.auto);
                                      XFile pic = await controller.takePicture();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) =>
                                              ImagePreview(pic)));
                                    } on CameraException catch (e) {
                                      print("error taking pic");
                                      return null;
                                    }
                                  }
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]
            )
          :Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LinearProgressIndicator(color: cPrimaryOverLightColor,
              minHeight: 10,
              backgroundColor: cPrimaryLightColor,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "A INICIALIZAR",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cPrimaryLightColor
                ),
              ),
            )
          ],
        ),
      ),
    );
        }
  
}