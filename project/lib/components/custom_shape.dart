import 'package:flutter/material.dart';

class CustomShape extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    var path = Path();
    double height = size.height;
    double width = size.width;
    path.lineTo(0, height-height/2);
    path.quadraticBezierTo(width/2, height, width, height-height/2);
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}