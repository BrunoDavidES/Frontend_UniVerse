
import 'dart:math';

import 'package:UniVerse/Components/default_button.dart';
import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/default_button_simple.dart';
import '../components/web_menu_card.dart';
import '../consts/list_consts.dart';
import '../login_screen/login_web.dart';
import 'personal_event_web.dart';
import '../utils/events/personal_event_data.dart';
import 'package:UniVerse/components/calendar_event_card.dart';
import 'package:UniVerse/consts/text_consts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CalendarScreenWeb extends StatefulWidget {
  const CalendarScreenWeb({super.key});

  @override
  State<CalendarScreenWeb> createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreenWeb> {
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  late String selectedDayString;
  late String selectedMonthString;
  late Map<DateTime, List<CalendarEvent>> selectedEvents;
  late int op;
  late Color color;
  late String dateString;


  @override
  void initState() {
    CalendarEvent.fetchEvents("07", "2023");
    Random random = Random();
    int cindex = random.nextInt(toRandom2.length);
    color = toRandom2[cindex];
    initializeDateFormatting('pt_PT', null);
    selectedDayString = selectedDay.day.toString();
    selectedMonthString = monthsInText[selectedDay.month-1];
    dateString =  DateFormat('dd-MM-yyyy').format(focusedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(DateTime.now());
    print(size.height);
    return Row(
          children: [
            WebMenu(width: size.width/9, height: size.height/1.75,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset("assets/titles/calendar.png", scale: 4.5,)
                          ),
                        ),


                      ],
                    ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: size.width/3.5,
                          margin: EdgeInsets.only(left: 30, top: 20, bottom: 20, right: 10),
                          padding: EdgeInsets.only(left:10, right:10),
                          decoration: BoxDecoration(
                              color: cDirtyWhiteColor,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: cHeavyGrey
                              ),

                          ),
                          child: Column(
                            children: [
                              TableCalendar(
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
                                    dateString =  DateFormat('dd-MM-yyyy').format(focusedDay);
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
                                        color: color,
                                        borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle
                                    ),
                                    todayTextStyle: TextStyle(
                                        color: Colors.black
                                    ),
                                    todayDecoration: BoxDecoration(
                                        color: cPrimaryOverLightColor,
                                        borderRadius: BorderRadius.circular(10),
                                      shape: BoxShape.rectangle
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
                                    shape: BoxShape.rectangle,
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
                              Row(
                                children: [
                                  Spacer(),
                                  Padding(
                                    padding: EdgeInsets.only(top:20, bottom: 10),
                                    child: DefaultButtonSimple(
                                        color: cHeavyGrey,
                                        height: 10,
                                        text: 'Adicionar à minha agenda',
                                        press: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) => const Dialog(
                                                backgroundColor: cDirtyWhiteColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius.circular(10.0)
                                                    )
                                                ),
                                                child: PersonalEventWeb(toCreate: true/*focusDay: focusedDay*/),
                                              )
                                          );
                                        }
                                    ),
                                  )
                                ],
                              )
                            ],

                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 10, bottom: 5),
                            child: Text(
                              "Agenda do dia $selectedDayString $selectedMonthString".toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: cHeavyGrey
                              ),
                            ),
                          ),
                          /*if(CalendarEvent.events[dateString]!=null)
                          Container(
                            width: size.width/2,
                            child: Column(
                              children: CalendarEvent.events[dateString]!.map((element) => CalendarEventCard(element, color: color)).toList(),*/
                                  ]),
                        ],
                      ),
                  ],
                )
              ],
            ),
          ],
    );
  }
}