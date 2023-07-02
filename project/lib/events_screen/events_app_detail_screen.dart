
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../utils/events/event_data.dart';
import '../utils/news/article_data.dart';

class EventsDetailScreen extends StatefulWidget {
  EventsDetailScreen(this.data, this.color, {super.key});
  Event data;
  Color color;

  @override
  State<StatefulWidget> createState() => EventsDetailState();
}

class EventsDetailState extends State<EventsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left:10, top:40, bottom: 10, right: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: cDirtyWhiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: widget.color,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                  Container(
                    height: 190,
                    child: Column(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {Navigator.pop(context);},
                            color: cDirtyWhiteColor),
                      ],
                    ),
                  )
                ]
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left:10, bottom: 5),
              child: Text(
                widget.data.title!.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top:15, left: 10, right: 10),
                          child: Text("${widget.data.startDate} · ${widget.data.endDate}",
                            style: TextStyle(
                                color: cHeavyGrey
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15, left: 10, right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined, color: cHeavyGrey),
                              Text(
                                widget.data.location!,
                                style: TextStyle(
                                    color: cHeavyGrey
                                ),
                              ),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15, left: 10, right: 10),
                          child: Row(
                            children: [
                              Icon(Icons.people, color: cHeavyGrey),
                              Text(
                                widget.data.capacity!,
                                style: TextStyle(
                                    color: cHeavyGrey
                                ),
                              ),
                            ],
                          ),
                        ),
                        if(widget.data.isPaid=="yes")
                          Padding(
                            padding:  EdgeInsets.only(top:15, left: 10, right: 10),
                            child: Icon(Icons.euro_outlined, color: cHeavyGrey),
                          ),

                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.data.description!,
                        textAlign: TextAlign.justify,
                      ),
                      //SizedBox(height: 10,)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}