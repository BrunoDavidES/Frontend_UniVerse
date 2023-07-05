import 'package:flutter/material.dart';
import '../consts/color_consts.dart';
import 'login_screen.dart';

class LoginPageWeb extends StatelessWidget {

  const LoginPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   return SizedBox(
      width: size.width/3.5, height: size.height/1.5,
      child: LoginScreen()
    );
  }
}