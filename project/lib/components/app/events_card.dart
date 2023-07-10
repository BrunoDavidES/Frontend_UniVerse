
import 'dart:math';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/events/event_data.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../consts/list_consts.dart';
import '../../events_screen/events_app_detail_screen.dart';
import '../../utils/events/personal_event_data.dart';

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
        height: 250,
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
                            image: NetworkImage("https://www.fct.unl.pt/sites/default/files/imagens/noticias/2018/11/campus.jpg"),
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
                  ?IconButton(icon: Icon(Icons.bookmark_outline), onPressed: () {
                    CalendarEvent.add(widget.data.planner, widget.data.title, widget.data.department, widget.data.location, widget.data.startDate, "");
                  },)
                  :SizedBox(),
                  IconButton(icon: Icon(Icons.share_outlined), onPressed: () {
                    final urlPreview = "https://universe-fct.oa.r.appspot.com/#/news/full/${widget.data.id.toString()}";
                    Share.share("${widget.data.title.toString()} | UniVerse ּ FCT NOVA\n\n${urlPreview}", subject: "Um evento na FCT | UniVerse ּ  FCT NOVA");
                  },),
                ],
              ),
            ),
  ]
        ),
      ),
    );
  }
}