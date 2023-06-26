
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import '../calendar_screen/calendar_event.dart';

class CalendarEventCard extends StatefulWidget {
  CalendarEventCard(this.data, {super.key, required this.color});
  CalendarEvent data;
  final Color color;

  @override
  State<StatefulWidget> createState() => CalendarEventState();
}

class CalendarEventState extends State<CalendarEventCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
   return Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10, left:10),
        padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 5),
        width: size.width-100,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  Text(
                    widget.data.title!,
                    style: const TextStyle(
                        fontSize: 15,
                        color: cDirtyWhiteColor
                    ),
                  ),
            Row(
              children: [
                const SizedBox(width: 20),
                Text(
                  widget.data.location!,
                  style: const TextStyle(
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