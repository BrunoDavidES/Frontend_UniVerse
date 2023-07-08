import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/modify_password_screen/modify_password_screen.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:flutter/material.dart';


class ModifyPwdPageApp extends StatelessWidget {
  const ModifyPwdPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          ModifyPasswordScreen(),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:3),
          ),
        ],
      ),
    );
  }
}