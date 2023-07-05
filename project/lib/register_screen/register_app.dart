import 'package:UniVerse/register_screen/register_screen.dart';
import 'package:flutter/material.dart';

import '../bars/app_bar.dart';

class RegisterPageApp extends StatelessWidget {

 const RegisterPageApp({super.key});

 @override
 Widget build(BuildContext context) {
  return Stack(
     children: <Widget>[
      const RegisterScreen(),
      Container(
       alignment: Alignment.bottomCenter,
       child:const CustomAppBar(i:3),
      )
     ],
    );
 }
}