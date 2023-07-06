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
    return Stack(
          children: <Widget>[
            const CalendarScreenApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:const CustomAppBar(i:3),
            )
          ],
    );
  }
}