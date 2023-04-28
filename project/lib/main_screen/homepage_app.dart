import 'package:UniVerse/bars/app_bar.dart';
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
   return Scaffold(
     body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/app/welcome_app.jpg"),
              fit: BoxFit.cover,
            ),
          ),
       child: Column(
         children: <Widget>[
           CustomAppBar(),
         ],
       ),
        ),
   );
  }
}