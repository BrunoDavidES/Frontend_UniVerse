import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/profile_screen/profile_page_app.dart';
import 'package:flutter/material.dart';

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ProfilePageApp(),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:3),
          ),
        ],
      ),
    );
  }
}