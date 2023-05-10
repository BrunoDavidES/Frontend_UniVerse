import 'package:flutter/material.dart';

import '../bars/app_bar.dart';
import '../consts.dart';
import 'login_body_app.dart';

class LoginPageApp extends StatefulWidget {

  const LoginPageApp({super.key});

  @override
  State<LoginPageApp> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<LoginPageApp> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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