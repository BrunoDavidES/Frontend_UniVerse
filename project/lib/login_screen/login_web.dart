import 'package:flutter/material.dart';

import '../bars/app_bar.dart';
import '../consts.dart';
import 'login_body_app.dart';

class LoginPageWeb extends StatefulWidget {

  const LoginPageWeb({super.key});

  @override
  State<LoginPageWeb> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPageWeb> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: cDirtyWhiteColor,
        ),
        child: Stack(
          children: <Widget>[
            LoginPageBodyApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            )
          ],
        ),
      ),
    );
  }
}