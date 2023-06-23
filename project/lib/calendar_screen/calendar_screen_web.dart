
import 'dart:math';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../components/web_menu_card.dart';
import '../consts/list_consts.dart';
import 'calendar_event.dart';
import 'package:UniVerse/components/calendar_event_card.dart';
import 'package:UniVerse/consts/text_consts.dart';
import 'package:intl/date_symbol_data_local.dart';

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


  @override
  void initState() {
    Random random = Random();
    int cindex = random.nextInt(toRandom2.length);
    color = toRandom2[cindex];
    initializeDateFormatting('pt_PT', null);
    selectedDayString = selectedDay.day.toString();
    selectedMonthString = monthsInText[selectedDay.month-1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    return Row(
          children: [
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left:20, top:20, bottom: 5),
          child: Text(
              "MENU DE OPÇÕES",
          style:TextStyle(
            color: cHeavyGrey,
            fontWeight: FontWeight.bold
          ),),
        ),
        Container(
        decoration: BoxDecoration(
        color: cDirtyWhiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow:[ BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ]
        ),
        alignment: Alignment.bottomCenter,
        width: size.width/9,
        height: size.height/1.75,
        margin: EdgeInsets.only(left:20, right:20, bottom: 20),
        child: ListView(
        children:  [
        Column(
        children: <Widget>[
        WebMenuCard(text: 'Logout', description: 'Vê e altera as tuas informações pessoais.', icon: Icons.logout_outlined),
        WebMenuCard(text: 'O Meu Perfil', description: 'Vê e altera as tuas informações pessoais.', icon: Icons.person_outline),
        WebMenuCard(text: 'QR Scan', description: 'Entra numa sala digitalizando o código QR na sua porta.', icon: Icons.qr_code_scanner_outlined),
        WebMenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined),
        WebMenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined),
        WebMenuCard(text: 'Fóruns', description: 'Encontra os teus fóruns aqui. Nunca foi tão fácil encontrar',icon: Icons.message_outlined),
        WebMenuCard(text: 'Calendário', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
        WebMenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
        WebMenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
        WebMenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
        WebMenuCard(text: 'Upload', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
        ],
        ),
        ],
        ),
        ),
      ],
    ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: Image.asset("assets/titles/calendar.png", scale: 4.5,)
                      ),
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
                          Container(
                            width: size.width/2,
                            child: Column(
                              children: CalendarEvent.events.map((e) => CalendarEventCard(e, color: color,)).toList(),
                            ),
                          )
                        ],
                      ),
                  ],
                )
              ],
            ),
          ],
                ),
                ]
    );
  }
}