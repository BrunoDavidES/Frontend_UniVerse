import 'dart:math';

import 'package:UniVerse/Components/default_button.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/default_button_simple.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../consts/list_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/events/event_data.dart';
import '../../utils/news/article_data.dart';
import '../components/default_button_2.dart';
import 'organized_events_info_screen.dart';

/*class OrganizedEventsFeed extends StatefulWidget {


  const OrganizedEventsFeed({super.key});

  @override
  State<StatefulWidget> createState() => EventsState();
}

class EventsState extends State<OrganizedEventsFeed> {
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
    if(Event.events.isEmpty) {
      String? author = FirebaseAuth.instance.currentUser?.uid;
      if (UniverseUser.g != null) {
        return Event.fetchEvents(5, Event.cursor, {'authorName': author});
      }
    }
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

<<<<<<< HEAD
=======
  void handleScrolling() {
    if (controller.offset == controller.position.maxScrollExtent) {
      setState(() {
        offset = offset + 3;
        if (Article.news.length == Event.numEvents)
          hasMore = false;
        else {
          String? author = FirebaseAuth.instance.currentUser?.uid;
          if (author != null) {
            fetchDone =
                Event.fetchEvents(5, Event.cursor, {'authorName': author});
          }
        }
      });
    }
  }

  Future<int> fetchOrganizedEvents() {
    String? author = FirebaseAuth.instance.currentUser?.uid;
    if(author != null) {
      fetchDone = Event.fetchEvents(5, Event.cursor, {'authorName': author});
    }
    return fetchDone;
  }

  Future refresh() async {
    setState(() {
      hasMore = true;
      offset = 0;
      Event.events.clear();
    });
    String? author = FirebaseAuth.instance.currentUser?.uid;
    if(author != null) {
      fetchDone = Event.fetchEvents(5, Event.cursor, {'authorName': author});
    }
  }

>>>>>>> 1b966c073307f8b3e32b2352a9c12c6cd6a4525b
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width;
    if(kIsWeb)
      width = size.width/2.75;
    else
      width = size.width;
    return Container(
      color: cDirtyWhiteColor,
width: width,
      height: size.height/2,
      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment,
        children: [
          Text("OS EVENTOS QUE CRIEI",
            style: TextStyle(
                color: cHeavyGrey,
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),),
          Container(
            height: size.height/2.75,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: FutureBuilder(
<<<<<<< HEAD
                  future: fetchDone,
=======
                  future: fetchOrganizedEvents(),
>>>>>>> 1b966c073307f8b3e32b2352a9c12c6cd6a4525b
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == 500) {
                        return Error500();
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: Event.events.map((element) => InkWell(
                            onTap: () =>
                              showDialog(
                                  context: context,
                                  builder: (_) =>  AlertDialog(
                                    backgroundColor: cDirtyWhiteColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(10.0)
                                          )
                                      ),
                                      content: OrganizedEventInfo(data: element)
                                  )
                                  ),
                            child: DefaultButton2(
                              width: size.width,
                              text: element.title!,
                              press: () {},
                            )
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
          ),
          Spacer(),
          DefaultButtonSimple(
              text: "OK",
              color: cPrimaryColor,
              press: () {
                Navigator.pop(context);
              },
              height: 20),
        ],
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
}*/