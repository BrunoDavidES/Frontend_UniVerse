import 'package:UniVerse/login_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';
import '../consts/color_consts.dart';
import 'login_screen.dart';

class ResetPageWeb extends StatefulWidget {

  const ResetPageWeb({super.key});

  @override
  State<ResetPageWeb> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<ResetPageWeb> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/3.5,
        height: size.height/1.5,
        child: const Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: cDirtyWhiteColor,
            body: ResetScreen()
        )
    );
  }
}