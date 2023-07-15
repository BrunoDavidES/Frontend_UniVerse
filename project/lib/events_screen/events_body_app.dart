import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/news/article_data.dart';
import '../components/app/events_card.dart';
import '../utils/events/event_data.dart';

class EventsFeed extends StatefulWidget {

  const EventsFeed({super.key});

  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<EventsFeed> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;
  late Future<int> fetchDone;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
   fetchDone = initialize();
    super.initState();
  }

  Future<int> initialize() async {
    if(Event.events.isEmpty)
      return Event.fetchEvents(3, Event.cursor, {});
    else return 200;
  }

  Future<void> scrollListener() async {
    if(isLoadingMore) return;
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
      if (Event.events.length == Event.numEvents)
        setState(() {
          hasMore = false;
          isLoadingMore = false;
        });
      else {
        setState(() {
          isLoadingMore = true;
        });
        await Event.fetchEvents(3, Event.cursor, {});
        setState(() {
          isLoadingMore = false;
          if (Event.events.length == Event.numEvents)
            hasMore = false;
        });
      }
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDone,
        builder: (context, snaphot) {
      if(snaphot.hasData) {
        if (snaphot.data == 500)
          return Error500();
        else {
          return ListView.builder(
              controller: scrollController,
              itemCount: Event.events.length + 1,
              itemBuilder: (context, index) {
                if (index < Event.events.length) {
                  return EventsCard(Event.events[index]);
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(
                        top: 10, left: 10, right: 10, bottom: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(isLoadingMore)
                          LinearProgressIndicator(
                            color: cPrimaryOverLightColor,
                            minHeight: 10,
                            backgroundColor: cPrimaryLightColor,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            hasMore
                                ? "A CARREGAR EVENTOS"
                                : "VISTE TODOS OS EVENTOS!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: cPrimaryLightColor
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
              }
          );
        }
      }
          return Padding(
            padding: const EdgeInsets.only(
                top: 10, left: 10, right: 10, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LinearProgressIndicator(
                  color: cPrimaryOverLightColor,
                  minHeight: 10,
                  backgroundColor: cPrimaryLightColor,),
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
              ],
            ),
          );
        },
    );
    //),
    // );
  }/*FutureBuilder(
          future: fetchDone,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 500) {
                return Error500();
              } else {
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    controller: controller,
                    itemCount: Article.news.length + 1,
                    itemBuilder: (context, int index) {
                      if (index < Article.news.length)
                        return NewsCard(Article.news[index]);
                      else
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(hasMore)
                                LinearProgressIndicator(
                                  color: cPrimaryOverLightColor,
                                  minHeight: 10,
                                  backgroundColor: cPrimaryLightColor,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  hasMore
                                      ? "A CARREGAR NOTÍCIAS"
                                      : "VISTE TODAS AS NOTÍCIAS!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: cPrimaryLightColor
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                    }
                );
              }
            }
            else Text(
              "A CARREGAR NOTÍCIAS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cPrimaryLightColor
              ),
            );
          }
      );
    }

  /*return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(color: cPrimaryOverLightColor, minHeight: 10, backgroundColor: cPrimaryLightColor,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "A CARREGAR NOTÍCIAS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cPrimaryLightColor
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            /*Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: Article.news.map((e) => NewsCard(e)).toList(),*/
            //SizedBox(height: 10,)
          );
    }
}*/*/
}