import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/components/drawer_menu.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/main_screen/app/welcome_body_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_body_app.dart';
import 'package:flutter/material.dart';

import '../components/simple_dialog_box.dart';

class AppPersonalPage extends StatelessWidget {
  const AppPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: cDirtyWhiteColor
        ),
        child: Stack(
          children: <Widget>[
            PersonalPageBodyApp(),
            //const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            ),
          ],
        ),
      ),
    );
  }
}