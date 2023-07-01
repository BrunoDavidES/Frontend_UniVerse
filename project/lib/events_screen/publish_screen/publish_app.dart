import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/events_screen/publish_screen/publish_screen_app.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/main_screen/app/welcome_body_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:flutter/material.dart';

import '../../components/simple_dialog_box.dart';

class AppPublishPage extends StatelessWidget {
  const AppPublishPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          PublishScreenApp(),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:3),
          ),
        ],
      ),
    );
  }
}