import 'add_personal_event_screen.dart';
import 'edit_personal_event_screen.dart';
import '../utils/events/personal_event_data.dart';
import 'package:UniVerse/personal_event_screen/personal_event_screen.dart';
import '';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../login_screen/login_screen.dart';

class PersonalEventApp extends StatelessWidget {
  final bool toCreate;
  final bool toEdit;
  final CalendarEvent? data;
  //final DateTime focusDay;
  const PersonalEventApp({super.key, required this.toCreate, this.data, required this.toEdit/*required this.focusDay*/});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: toCreate ?size.height/2 :size.height/4,
        child: toCreate
            ?toEdit ?PersonalEventEditScreen(data: data!) :PersonalEventCreationScreen()
            :PersonalEventScreen(data: data!,)
    );
  }
}