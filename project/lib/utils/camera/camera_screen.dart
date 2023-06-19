
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/utils/camera/image_preview.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {

  CameraScreen( {super.key});

  @override
  State<StatefulWidget> createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  late CameraController controller;

  @override
void initState(){
    checkCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
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

  Future<void> checkCameras() async {
    cameras = await availableCameras();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          child: Icon(Icons.camera_alt, size: 25, color: cHeavyGrey,),
                          onPressed: () async {
                            if(!controller.value.isInitialized)
                              return null;
                            if(controller.value.isTakingPicture)
                              return null;
                            try {
                              await controller.setFlashMode(FlashMode.auto);
                              await controller.setFocusMode(FocusMode.auto);
                              XFile pic = await controller.takePicture();
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImagePreview(pic)));
                            } on CameraException catch(e) {
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
    );
  }
  
}