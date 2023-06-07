import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController cameraController;

  void startCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(
        cameras[0],
        ResolutionPreset.medium,
        enableAudio: false
    );
    await cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    startCamera();
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (cameraController.value.isInitialized)
      return Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController),
          ],
        )

      );
    else {
      return SizedBox();
    }
  }
}