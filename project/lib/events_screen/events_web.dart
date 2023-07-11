import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/events/personal_event_data.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../Components/default_button.dart';
import '../components/500.dart';
import '../components/simple_dialog_box.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/events/event_data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EventsWebPage extends StatefulWidget {
  EventsWebPage({Key? key}) : super(key: key);

  @override
  State<EventsWebPage> createState() => _EventsWebPageState();
}

class _EventsWebPageState extends State<EventsWebPage> {
  ScrollController yourScrollController = ScrollController();
  late Future<int> fetchDone;

  int totalArticlesCount = Event.numEvents;
  int loadedArticlesCount = 5;

  @override
  void initState() {
    Event.events.clear();
    fetchEvents();
    super.initState();
  }

  Future<void> fetchEvents() async {
    fetchDone = Event.fetchEvents(loadedArticlesCount, "EMPTY", {});
    await fetchDone;
    setState(() {
      totalArticlesCount = Event.numEvents;
      loadedArticlesCount = min(loadedArticlesCount, totalArticlesCount);
    });
  }

  Widget build(BuildContext context) {

    Future<Uint8List> fetchImageFile(events) async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/Events/' + events);
        final byteData = await ref.getData();
        return byteData!.buffer.asUint8List();
      } catch (e) {
        print('Error fetching file: $e');
        return Uint8List(0);
      }
    }

    Future<String> fetchTextFile(events) async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/Events/' + events + '.txt');
        final response = await ref.getData();
        return utf8.decode(response as List<int>);
      } catch (e) {
        print('Error fetching text file: $e');
        return '';
      }
    }

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
                        height: totalArticlesCount > 5? 300 * loadedArticlesCount as double: 300 * totalArticlesCount as double,
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
                                            height: 250,
                                            decoration: BoxDecoration(
                                              color: cDirtyWhiteColor,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            margin: EdgeInsets.only(top: 5, bottom: 5),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: size.width / 3.5,
                                                  height: 250,
                                                  child: FutureBuilder<Uint8List>(
                                                      future: fetchImageFile(Event.events[index].id),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        } else if (snapshot.hasError) {
                                                          return Text('Error fetching image: ${snapshot.error}');
                                                        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                          return Image.memory(
                                                            snapshot.data!,
                                                            fit: BoxFit.contain,
                                                          );
                                                        } else {
                                                          return Text('Image not found');
                                                        }
                                                      },
                                                    ),
                                                ),
                                                SizedBox(width: 15),
                                                Container(
                                                  width: size.width / 1.95,
                                                  height: 250,
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
                                                      FutureBuilder<String>(
                                                        future: fetchTextFile(Event.events[index].id),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return CircularProgressIndicator();
                                                          } else if (snapshot.hasError) {
                                                            return Text('Error fetching file');
                                                          } else {
                                                            return Padding(
                                                              padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                                                              child: Text(
                                                                snapshot.data ?? '',
                                                                textAlign: TextAlign.start,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
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
                                                              onPressed: () async {
                                                                var response = await CalendarEvent.add(event.planner, event.title, event.department, event.location, event.startDate, "");
                                                                if(response == 200) {
                                                                  showDialog(context: context,
                                                                      builder: (BuildContext context){
                                                                        return const CustomDialogBox(
                                                                          title: "Sucesso",
                                                                          descriptions: "Já guardámos este evento no teu calendário! Podes aceder ao calendário e à tua agenda na nossa aplicação.",
                                                                          text: "OK",
                                                                        );
                                                                      }
                                                                  );
                                                                } else if(response == 500)
                                                                  context.go("/error");
                                                                else {
                                                                  showDialog(context: context,
                                                                      builder: (BuildContext context){
                                                                        return const CustomDialogBox(
                                                                          title: "Ups!",
                                                                          descriptions: "Não conseguimos guardar este evento no teu calendário. Tenta novamente, por favor.",
                                                                          text: "OK",
                                                                        );
                                                                      }
                                                                  );
                                                                }
                                                              },
                                                              icon: Icon(Icons.bookmark, color: cHeavyGrey),
                                                            ),
                                                          /*IconButton(
                                                            onPressed: () {
                                                              final urlPreview = "https://universe-fct.oa.r.appspot.com/#/events/full/${event.id.toString()}";
                                                              Share.share("${event.title.toString()} | UniVerse ּ FCT NOVA\n\n${urlPreview}", subject: "Um evento na FCT | UniVerse ּ  FCT NOVA");
                                                            },
                                                            icon: Icon(Icons.share, color: cHeavyGrey),
                                                          ),*/
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
                          bottom: 40.0,
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
                              fetchDone = Event.fetchEvents(
                                  loadedArticlesCount,
                                  Event.cursor,
                                  {});
                            });
                          },
                        ),
                      if (!(loadedArticlesCount < totalArticlesCount))
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 60.0,
                          ),
                        ),
                      SizedBox(height: 40),
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
