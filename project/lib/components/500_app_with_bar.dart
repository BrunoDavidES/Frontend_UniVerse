import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/components/500_app.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/main_screen/app/welcome_body_app.dart';
import 'package:flutter/material.dart';

class Error500WithBar extends StatelessWidget {
  final int i;
  final Image img;
  const Error500WithBar({super.key, required this.i, required this.img});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: img,
          automaticallyImplyLeading: false,
          backgroundColor: cDirtyWhiteColor,
          titleSpacing: 15,
          elevation: 0,
        ),
      body: Container(
        height: size.height,
        width: size.width,
        color: cDirtyWhiteColor,
        child: Stack(
          children: <Widget>[
            Error500App(),
            //const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:i),
            )
          ],
        ),
      ),
    );
  }
}