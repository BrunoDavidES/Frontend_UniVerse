import 'package:UniVerse/find_screen/departments_screen/departments_body_app.dart';
import 'package:UniVerse/find_screen/links_screen/links_body_app.dart';
import 'package:UniVerse/find_screen/services_screen/services_body_app.dart';
import 'package:flutter/material.dart';

import '../../bars/app_bar.dart';
import '../../consts/color_consts.dart';

class ChosenPageApp extends StatefulWidget {
  final int i;
  const ChosenPageApp({super.key, required this.i});

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
            if(widget.i==1)
              ServicesBodyApp(),
            if(widget.i==3)
              LinksBodyApp(),
            if(widget.i==4)
              DepartmentsBodyApp(),
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