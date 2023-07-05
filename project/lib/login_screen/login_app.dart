
import 'package:flutter/material.dart';
import '../bars/app_bar.dart';
import 'login_screen.dart';

class LoginPageApp extends StatelessWidget {

 const LoginPageApp({super.key});

 @override
 Widget build(BuildContext context) {
  return Stack(
     children: <Widget>[
      const LoginScreen(),
      Container(
       alignment: Alignment.bottomCenter,
       child:const CustomAppBar(i:3),
      )
     ],
    );
 }
}