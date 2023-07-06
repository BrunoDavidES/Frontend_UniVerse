import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:flutter/material.dart';

class AppPersonalPage extends StatelessWidget {
  const AppPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            PersonalPageBodyApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            ),
          ],
        ),
    );
  }
}