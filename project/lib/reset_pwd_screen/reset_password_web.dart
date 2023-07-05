
import 'package:UniVerse/reset_pwd_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';

class ResetPageWeb extends StatelessWidget {

  const ResetPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/3.5,
        height: size.height/1.5,
        child: ResetScreen()
        );
  }
}