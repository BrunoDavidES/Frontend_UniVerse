import 'package:UniVerse/login_screen/login_screen.dart';
import 'package:flutter/material.dart';

import '../components/500_app.dart';
import '../components/events_card.dart';
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
    return Container(
      color: cDirtyWhiteColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
              future: Event.fetchEvents(3, 0),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 500) {
                    return Error500App();
                  } else if(snapshot.data == 403){
                    return LoginScreen();
                  } else { return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: Event.events.map((e) => EventsCard(e)).toList(),
                    );
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: LinearProgressIndicator(color: cPrimaryOverLightColor, minHeight: 10, backgroundColor: cPrimaryLightColor,),
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
      ),
    );
  }
}