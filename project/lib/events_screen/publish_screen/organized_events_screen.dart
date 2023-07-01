import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/events/event_data.dart';
import '../../utils/news/article_data.dart';

class OrganizedEventsFeed extends StatefulWidget {


  const OrganizedEventsFeed({super.key});

  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<OrganizedEventsFeed> {
  late Future<int> fetchDone;
  late ScrollController controller;
  late int offset;
  late bool hasMore = true;

  @override
  void initState() {
    offset = 0;
    fetchDone = Event.fetchEvents(5, offset, {});
    controller = ScrollController()
      ..addListener(handleScrolling);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }

  void handleScrolling() {
    if (controller.offset == controller.position.maxScrollExtent) {
      setState(() {
        offset = offset + 3;
        if (Article.news.length == Event.numEvents)
          hasMore = false;
        else
          Event.fetchEvents(5, offset, {});
      });
    }
  }

  Future refresh() async {
    setState(() {
      hasMore = true;
      offset = 0;
      Event.events.clear();
    });
    Event.fetchEvents(5, offset, {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("OS EVENTOS QUE CRIEI",
        style: TextStyle(
          color: cHeavyGrey,
          fontWeight: FontWeight.bold,
            fontSize: 20
        ),),
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      backgroundColor: cDirtyWhiteColor,
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Event.fetchEvents(5, 0, {}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 500) {
                    return Error500();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: Event.events.map((e) => InkWell(
                        child: Text(
                          e.title!,
                          style: TextStyle(
                            color: cDarkBlueColor,
                            fontWeight: FontWeight.bold,
                            //fontSize: 13
                          ),
                        ),
                      )).toList(),
                    );
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(color: cPrimaryOverLightColor,
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
            ),
            /*Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: Article.news.map((e) => NewsCard(e)).toList(),*/
            //SizedBox(height: 10,)
          ),
        ),
    );
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