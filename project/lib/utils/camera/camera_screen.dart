
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
  Future<void> initState() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if(!mounted)
        return;
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}