import 'package:UniVerse/reset_pwd_screen/reset_password_screen.dart';
import 'package:flutter/material.dart';
import '../bars/app_bar.dart';

class ResetPageApp extends StatelessWidget {

  const ResetPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            const ResetScreen(),
            Container(
              alignment: Alignment.bottomCenter,
              child:const CustomAppBar(i:3),
            )
          ],
        );
  }
}