import 'package:flutter/material.dart';
import '../consts/color_consts.dart';
import 'register_screen.dart';

class RegisterPageWeb extends StatefulWidget {

  const RegisterPageWeb({super.key});

  @override
  State<RegisterPageWeb> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<RegisterPageWeb> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/3.5,
        height: size.height/1.25,
        child: const Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: cDirtyWhiteColor,
            body: RegisterScreen()
        )
    );
  }
}