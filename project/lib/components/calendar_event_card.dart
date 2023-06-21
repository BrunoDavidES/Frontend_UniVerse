import 'dart:math';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';

import '../calendar_screen/calendar_event.dart';
import '../consts/list_consts.dart';

class CalendarEventCard extends StatefulWidget {
  CalendarEventCard(this.data, {super.key});
  CalendarEvent data;

  @override
  State<StatefulWidget> createState() => CalendarEventState();
}

class CalendarEventState extends State<CalendarEventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
   return Container(
        margin: EdgeInsets.only(right: 10, bottom: 10, left:10),
        padding: EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
        width: size.width-100,
        decoration: BoxDecoration(
            color: cDarkLightBlueColor,
            borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  Text(
                    widget.data.title!,
                    style: TextStyle(
                        fontSize: 15,
                        color: cDirtyWhiteColor
                    ),
                  ),
            Row(
              children: [
                SizedBox(width: 20),
                Text(
                  widget.data.location!,
                  style: TextStyle(
                      fontSize: 13,
                      color: cDirtyWhiteColor
                  ),
                ),
              ],
            )
          ],
        ),
    );
  }
}