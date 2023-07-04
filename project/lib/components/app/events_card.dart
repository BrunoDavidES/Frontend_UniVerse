
import 'dart:math';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/events/event_data.dart';
import 'package:flutter/material.dart';
import '../../consts/list_consts.dart';
import '../../events_screen/events_app_detail_screen.dart';

class EventsCard extends StatefulWidget {
  EventsCard(this.data, {super.key});
  Event data;

  @override
  State<StatefulWidget> createState() => EventsCardState();
}

class EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventsDetailScreen(widget.data, toRandom[cindex])));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(2),
        height: 230,
        decoration: BoxDecoration(
            color: cDirtyWhiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: toRandom[cindex],
                width: 2
            ),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ]
        ),
        child: Column(
          children: [
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(widget.data.urlToImage!),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top:5, left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    "Organizado por "+widget.data.planner!,
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                  Spacer(),
                  Authentication.userIsLoggedIn
                  ?Icon(Icons.bookmark_outline)
                  :SizedBox(width: 1,),
                  Icon(Icons.share_outlined),
                ],
              ),
            ),
  ]
        ),
      ),
    );
  }
}