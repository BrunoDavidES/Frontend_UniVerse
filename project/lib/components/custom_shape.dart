
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    if(!kIsWeb) {
      path.lineTo(0, height - height / 1.5);
      path.quadraticBezierTo(width / 2, height, width, height - height);
      path.lineTo(width, 0);
    } else {
      path.lineTo(0, height - height/0.6);
      path.quadraticBezierTo(width / 2, height, width, height - height / 2);
      path.lineTo(width, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}