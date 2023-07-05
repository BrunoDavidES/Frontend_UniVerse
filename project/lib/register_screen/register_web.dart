import 'package:flutter/material.dart';
import '../consts/color_consts.dart';
import 'register_screen.dart';

class RegisterPageWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/3.5,
        height: size.height/1.25,
        child: RegisterScreen()
        );
  }
}