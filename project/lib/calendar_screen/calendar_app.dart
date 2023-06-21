import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/calendar_screen/calendar_screen_app.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class CalendarPageApp extends StatefulWidget {

  const CalendarPageApp({super.key});

  @override
  State<CalendarPageApp> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<CalendarPageApp> {

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
            CalendarScreenApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            )
          ],
        ),
      ),
    );
  }
}