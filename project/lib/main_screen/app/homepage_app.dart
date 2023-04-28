import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/main_screen/app/welcome_body_app.dart';
import 'package:flutter/material.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key, required this.title});
  final String title;

  @override
  State<AppHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AppHomePage> {

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
           Spacer(),
           CustomAppBar(),
         ],
       ),
        ),
   );
  }
}