import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePicker extends StatefulWidget {
  final Color color;
  final String text;

  const MyImagePicker({super.key, required this.color, required this.text});
  @override
  State<MyImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<MyImagePicker> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Uint8List imageUint8 = Uint8List(8);
    File? pickedImage;

    return InkWell(
      onTap: () async {
        final ImagePicker picker = ImagePicker();
        XFile? image = await picker.pickImage(source: ImageSource.gallery);
        if(image!=null) {
          var f = await image.readAsBytes();
          imageUint8= f;
          setState(() {
            pickedImage = File("a");
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 25, top: 10),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:5),
              child: Icon(Icons.camera_alt_outlined, color: widget.color),
            ),
            Padding(
              padding: const EdgeInsets.only(left:12),
              child: pickedImage!=null
                  ?Container(
                height: size.width/8,
                width: size.width/4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Image.memory(imageUint8, fit: BoxFit.scaleDown, scale: 5),
              )
                  : Text(
                widget.text,
                style: TextStyle(
                    color: widget.color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}