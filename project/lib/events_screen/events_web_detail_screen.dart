
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Components/default_button.dart';
import '../bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/events/event_data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EventsDetailScreenWeb extends StatelessWidget {
  final String id;
  final Event data;
  EventsDetailScreenWeb( {super.key, required this.id, required this.data});

  ScrollController yourScrollController = ScrollController();
  Widget build(BuildContext context) {

    Future<Uint8List> fetchImageFile(events) async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/Events/' + events);
        final byteData = await ref.getData();
        return byteData!.buffer.asUint8List();
      } catch (e) {
        return Uint8List(0);
      }
    }

    Future<String> fetchTextFile(events) async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/Events/' + events + '.txt');
        final response = await ref.getData();
        return utf8.decode(response as List<int>);
      } catch (e) {
        return '';
      }
    }

    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                focal: Alignment.centerLeft,
                focalRadius: 0.2,
                center: Alignment.centerLeft,
                radius: 0.40,
                colors: [
                  cPrimaryOverLightColor,
                  cDirtyWhite,
                ],
              ),
            ),
            child: Stack(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top: size.height/7),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:50, top: 20, bottom: 30),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Image.asset("assets/titles/events.png", scale: 4.5,)
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 20),
                              width: size.width/3.5,
                              height: size.height/2.5,
                            child: FutureBuilder<Uint8List>(
                              future: fetchImageFile(data.id.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: MemoryImage(
                                              snapshot.data!,
                                            )
                                        )
                                    ),
                                  );
                                } else {
                                  return Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: cHeavyGrey.withOpacity(0.5)
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            width: size.width-size.width/2.75,
                            decoration: BoxDecoration(
                              color: cDirtyWhiteColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text("${data.title}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                ),
                                Row(
                                  children: [
                                    Text("${data.startDate} · ${data.endDate}",
                                      style: TextStyle(
                                          color: cHeavyGrey
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined, color: cHeavyGrey),
                                        Text(
                                          data.location!,
                                          style: TextStyle(
                                              color: cHeavyGrey
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    Row(
                                      children: [
                                        Icon(Icons.people, color: cHeavyGrey),
                                        Text(
                                          data.capacity!,
                                          style: TextStyle(
                                              color: cHeavyGrey
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10,),
                                    if(data.isPaid=="yes")
                                      Row(
                                        children: [
                                          Icon(Icons.euro_outlined, color: cHeavyGrey),
                                          Text(
                                            "PAGO",
                                            style: TextStyle(
                                                color: cHeavyGrey
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                                SizedBox(height: 15,),
                                FutureBuilder<String>(
                                  future: fetchTextFile(data.id),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Ocorreu um erro.');
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                                        child: Text(
                                          snapshot.data ?? '',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:20, right: 20),
                                      child:Text("Autoria de ${data.planner} · ${data.endDate}",
                                        style: TextStyle(
                                            color: cHeavyGrey
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: size.width/2-100, top: 20, bottom: 60),
                            child: DefaultButton(
                                text: "Página Anterior",
                                press: () {
                                  Navigator.pop(context); }),
                          ),
                        ],
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
        )
              )
    );
  }
}