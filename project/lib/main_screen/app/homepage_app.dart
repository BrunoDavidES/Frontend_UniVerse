import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/main_screen/app/welcome_body_app.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatelessWidget {
  const AppHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

   return Scaffold(
     body: Container(
        height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white70,
            /*image: DecorationImage(
              image: AssetImage("assets/app/welcome_app.jpg"),
              fit: BoxFit.cover,
            ),*/
          ),
       child: Column(
         children: <Widget>[
           WelcomeBodyApp(),
           const Spacer(),
           CustomAppBar(i:0),
         ],
       ),
        ),
   );
  }
}