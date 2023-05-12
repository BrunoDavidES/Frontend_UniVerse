import 'package:flutter/material.dart';
import '../consts/color_consts.dart';
import 'login_screen.dart';

class LoginPageWeb extends StatefulWidget {

  const LoginPageWeb({super.key});

  @override
  State<LoginPageWeb> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPageWeb> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width/4,
      height: size.height/1.65,
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: cDirtyWhiteColor,
        body: Stack(
            children: <Widget>[
              LoginScreen(),
            ],
          ),
    )
    );
  }
}