import 'package:UniVerse/components/calendar_event_card.dart';
import 'package:UniVerse/components/grid_item.dart';
import 'package:UniVerse/consts/text_consts.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../components/500_app_with_bar.dart';
import '../components/menu_card.dart';
import '../components/personal_app_card.dart';
import '../report_screen/report_app.dart';
import '../report_screen/report_screen_app.dart';
import 'calendar_event.dart';


class CalendarScreenApp extends StatefulWidget {
  const CalendarScreenApp({super.key});

  @override
  State<CalendarScreenApp> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<CalendarScreenApp> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late String selectedDayString;
  late String selectedMonthString;
  late Map<DateTime, List<CalendarEvent>> selectedEvents;

  @override
  void initState() {
    initializeDateFormatting('pt_PT', null);
    selectedDayString = selectedDay.day.toString();
    selectedMonthString = monthsInText[selectedDay.month-1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/area.png", scale:6),
        leadingWidth: 20,
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {Navigator.pop(context);},
                  color: cDarkBlueColorTransparent);
            }
        ),
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(left:10, right:10),
                decoration: BoxDecoration(
                    color: cDirtyWhiteColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: cHeavyGrey
                    ),
                    boxShadow:[ BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0,0),
                    ),
                    ]
                ),
                child: TableCalendar(
                  locale: 'pt_PT',
                    focusedDay: focusedDay,
                    firstDay: DateTime.utc(2023),
                    lastDay: DateTime.utc(2030),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekVisible: true,
                  onDaySelected: (DateTime selectDay, DateTime focusDay) {
                    setState(() {
                      selectedDay = selectDay;
                      focusedDay = focusDay;
                      selectedDayString = selectDay.day.toString();
                      selectedMonthString = monthsInText[selectedDay.month-1];
                    });
                  },
                  calendarFormat: format,
                  onFormatChanged: ( CalendarFormat _format) {
                    setState(() {
                      format=_format;
                    });
                  },
                  calendarStyle: CalendarStyle(
                      isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: cDarkLightBlueColor,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    todayTextStyle: TextStyle(
                      color: Colors.black
                    ),
                    todayDecoration: BoxDecoration(
                      color: cPrimaryOverLightColor,
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  selectedDayPredicate: (DateTime date) {
                    return isSameDay(selectedDay, date);
                  },
                  headerStyle: HeaderStyle(
                    formatButtonVisible: true,
                    titleCentered: true,
                    formatButtonShowsNext: false,
                    formatButtonDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: cHeavyGrey,
                        width: 1
                      )
                    ),
                    formatButtonTextStyle: TextStyle(
                      color: cHeavyGrey,
                    ),
                    titleTextStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  "Agenda do dia $selectedDayString $selectedMonthString".toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: cHeavyGrey
                  ),
                ),
              ),
              ...CalendarEvent.events.map((e) => CalendarEventCard(e)),
              SizedBox(height: 70,)
            ],
          ),
        ),
    );
  }
}




