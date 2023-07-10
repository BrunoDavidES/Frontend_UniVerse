import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../components/500.dart';
import '../components/app/events_card.dart';
import '../components/news_card.dart';
import '../components/simple_dialog_box.dart';
import '../consts/color_consts.dart';
import '../utils/events/event_data.dart';
import '../utils/news/article_data.dart';

class EventsFeed extends StatefulWidget {
  const EventsFeed({super.key});

  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<EventsFeed> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: cDirtyWhiteColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            !Authentication.userIsLoggedIn
            ?Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              width: size.width,
              child:
                  Text(
                      "Inicia sessão na tua conta UniVerse para poderes aceder a mais eventos e guardá-los no teu calendário pessoal.",
                    textAlign: TextAlign.justify,
                  ),
            )
            :SizedBox(height: 1,),
            Padding(
              padding: EdgeInsets.all(10),
              child: FutureBuilder(
                  future: Event.fetchEvents(3, Event.cursor, {}),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 500)
                        return Error500();
                      else
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: Event.events.map((e) => EventsCard(e)).toList(),
                        );
                    }
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    LinearProgressIndicator(color: cPrimaryOverLightColor, minHeight: 10, backgroundColor: cPrimaryLightColor,),
                    Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                    "A CARREGAR EVENTOS",
                    style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cPrimaryLightColor
                    ),
                    ),
                    )
                    ]
                    )
                    );
                  },
                ),
              /*Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: Event.events.map((e) => EventsCard(e)).toList()
                //SizedBox(height: 10,)
              ),*/
            ),
          ],
        ),
      ),
    );
  }
}