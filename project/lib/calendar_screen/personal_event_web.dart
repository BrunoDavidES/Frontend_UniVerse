import 'package:UniVerse/calendar_screen/calendar_event.dart';
import 'package:UniVerse/calendar_screen/personal_event_screen.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../login_screen/login_screen.dart';
import 'add_personal_event_screen.dart';

class PersonalEventWeb extends StatelessWidget {
  final bool toCreate;
  final CalendarEvent? data;
  //final DateTime focusDay;
  const PersonalEventWeb({super.key, required this.toCreate, this.data/*required this.focusDay*/});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: toCreate ?size.width/2.75 :size.width/3.5,
        height: toCreate ?size.height/2.5 :size.height/4,
        child: toCreate
          ?PersonalEventCreationScreen()
            :PersonalEventScreen(data: data!,)
    );
  }
}