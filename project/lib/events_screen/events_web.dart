import 'dart:math';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/events/personal_event_data.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../Components/default_button.dart';
import '../components/500.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/events/event_data_aux.dart';

class EventsWebPage extends StatefulWidget {
  EventsWebPage({Key? key}) : super(key: key);

  @override
  State<EventsWebPage> createState() => _EventsWebPageState();
}

class _EventsWebPageState extends State<EventsWebPage> {
  ScrollController yourScrollController = ScrollController();
  late Future<int> fetchDone;

  int totalArticlesCount = Event.events.length;
  int loadedArticlesCount = 5;

  @override
  void initState() {
    fetchDone = Event.fetchEvents(loadedArticlesCount, 0, {});
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(20),
        scrollbarOrientation: ScrollbarOrientation.right,
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Container(
            color: cDirtyWhite,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height / 7),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: Authentication.userIsLoggedIn
                            ? Container(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "assets/titles/events.png",
                            scale: 4,
                          ),
                        )
                            : Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Image.asset(
                                  "assets/titles/events.png",
                                  scale: 4,
                                )),
                            Spacer(),
                            Icon(Icons.info_outline),
                            Text(
                              "Inicia sessão na tua conta UniVerse para poderes aceder a mais eventos e guardares no teu calendário pessoal.",
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(width: 50)
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        height: totalArticlesCount > 5? 315 * loadedArticlesCount as double: 315 * totalArticlesCount as double,
                        width: size.width / 1.20,
                        color: cDirtyWhite,
                        child: FutureBuilder(
                          future: fetchDone,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == 500) {
                                return Error500();
                              }
                              final events = Event.events;
                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: totalArticlesCount > 5? loadedArticlesCount: totalArticlesCount,
                                    itemBuilder: (BuildContext context, int index) {
                                      final event = events[index];
                                      return Column(
                                        children: [
                                          SizedBox(
                                            child: Divider(
                                              thickness: 2,
                                              color: toRandom[cindex],
                                            ),
                                          ),
                                          Container(
                                            height: 280,
                                            decoration: BoxDecoration(
                                              color: cDirtyWhiteColor,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            margin: EdgeInsets.only(top: 5, bottom: 5),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width / 4,
                                                  height: 260,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(15.0),
                                                    image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(event.urlToImage!),
                                                    ),
                                                    border: Border.all(
                                                      color: cHeavyGrey,
                                                    ),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey.withOpacity(0.75),
                                                        spreadRadius: 3,
                                                        blurRadius: 7,
                                                        offset: const Offset(0, 0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 15),
                                                Container(
                                                  width: size.width / 1.95,
                                                  height: 260,
                                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                                  padding: EdgeInsets.all(10),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        "${event.title}".toUpperCase(),
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight.bold, fontSize: 20),
                                                        maxLines: 1,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${event.startDate} · ${event.endDate}",
                                                            style: TextStyle(color: cHeavyGrey),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.location_on_outlined, color: cHeavyGrey),
                                                              Text(
                                                                event.location!,
                                                                style: TextStyle(color: cHeavyGrey),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10),
                                                          Row(
                                                            children: [
                                                              Icon(Icons.people, color: cHeavyGrey),
                                                              Text(
                                                                event.capacity!,
                                                                style: TextStyle(color: cHeavyGrey),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(width: 10),
                                                          if (event.isPaid == "yes")
                                                            Row(
                                                              children: [
                                                                Icon(Icons.euro_outlined, color: cHeavyGrey),
                                                                Text(
                                                                  "PAGO",
                                                                  style: TextStyle(color: cHeavyGrey),
                                                                ),
                                                              ],
                                                            ),
                                                        ],
                                                      ),
                                                      SizedBox(height: 15),
                                                      Text(
                                                        "${event.description}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "${event.planner} · ${event.department}",
                                                            style: TextStyle(color: cHeavyGrey),
                                                          ),
                                                          Spacer(),
                                                          if (Authentication.userIsLoggedIn)
                                                            IconButton(
                                                              onPressed: () {
                                                                CalendarEvent.add(event.planner, event.title, event.department, event.location, event.startDate, "");
                                                              },
                                                              icon: Icon(Icons.bookmark, color: cHeavyGrey),
                                                            ),
                                                          IconButton(
                                                            onPressed: () {
                                                              final urlPreview = "https://universe-fct.oa.r.appspot.com/#/events/full/${event.id.toString()}";
                                                              Share.share("${event.title.toString()} | UniVerse ּ FCT NOVA\n\n${urlPreview}", subject: "Um evento na FCT | UniVerse ּ  FCT NOVA");
                                                            },
                                                            icon: Icon(Icons.share, color: cHeavyGrey),
                                                          ),
                                                          IconButton(
                                                            onPressed: () => context.go(
                                                              "/events/full/${event.id}",
                                                              extra: event,
                                                            ),
                                                            icon: Icon(Icons.remove_red_eye, color: cHeavyGrey),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              );
                            }
                            return Center(child: LinearProgressIndicator());
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 0,
                          bottom: 60.0,
                        ),
                      ),
                      if (loadedArticlesCount < totalArticlesCount)
                        DefaultButton(
                          text: "Carregar mais",
                          press: () {
                            setState(() {
                              loadedArticlesCount += 5;
                              if (loadedArticlesCount >
                                  totalArticlesCount) {
                                loadedArticlesCount = totalArticlesCount;
                              }
                              fetchDone = Event.fetchEvents(loadedArticlesCount, 0, {});
                            });
                          },
                        ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 60.0,
                        ),
                      ),
                      BottomAbout(size: size),
                    ],
                  ),
                ),
                Container(
                  color: cDirtyWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWebBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
