import 'package:UniVerse/find_screen/buildings_screen/buildings_body_app.dart';
import 'package:UniVerse/find_screen/departments_screen/departments_body_app.dart';
import 'package:UniVerse/find_screen/links_screen/links_body_app.dart';
import 'package:UniVerse/find_screen/restaurants_screen/restaurants_screen.dart';
import 'package:UniVerse/find_screen/services_screen/services_body_app.dart';
import 'package:flutter/material.dart';

import '../../bars/app_bar.dart';
import '../../consts/color_consts.dart';

class ChosenPageApp extends StatefulWidget {

  final Widget page;
  const ChosenPageApp({super.key, required this.page, });

  @override
  State<ChosenPageApp> createState() => _MyChosenPageState();
}

class _MyChosenPageState extends State<ChosenPageApp> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: cDirtyWhiteColor,
        ),
        child: Stack(
          children: <Widget>[
            widget.page,
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:1),
            )
          ],
        ),
      ),
    );
  }
}