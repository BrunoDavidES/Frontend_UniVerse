import 'package:flutter/material.dart';

import '../components/events_card.dart';
import '../components/news_card.dart';
import '../consts/color_consts.dart';
import '../utils/events/event_data.dart';
import '../utils/news/article_data.dart';

class EventsFeed extends StatelessWidget {
  const EventsFeed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cDirtyWhiteColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: EventData.events.map((e) => EventsCard(e)).toList(),
            //SizedBox(height: 10,)
          ),
        ),
      ),
    );
  }
}