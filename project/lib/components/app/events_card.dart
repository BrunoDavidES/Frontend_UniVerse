
import 'dart:math';
import 'dart:typed_data';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/events/event_data.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../consts/list_consts.dart';
import '../../events_screen/events_app_detail_screen.dart';
import '../../utils/events/personal_event_data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class EventsCard extends StatefulWidget {
  EventsCard(this.data, {super.key});
  Event data;

  @override
  State<StatefulWidget> createState() => EventsCardState();
}

class EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    Future<Uint8List> fetchImageFile(String id) async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/Events/$id');
        final downloadUrl = await ref.getDownloadURL();
        final response = await http.get(Uri.parse(downloadUrl));
        if (response.statusCode == 200) {
          return response.bodyBytes;
        } else {
          throw Exception('Failed to fetch image file.');
        }
      } catch (e) {
        print('Error fetching file: $e');
        throw Exception('Failed to fetch image file.');
      }
    }
    var sizeWidth;
    var sizeHeight;
    Size size = MediaQuery.of(context).size;
    if(size.width>600) {
      if(MediaQuery.of(context).orientation==Orientation.portrait) {
        sizeWidth = size.width-200;
        sizeHeight= size.height/4;
      }
      else {
        sizeWidth = size.width/2;
        sizeHeight= size.height/2;
      }
    }
    else {
      sizeWidth=double.infinity;
      sizeHeight=size.height/3;
    }
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventsDetailScreen(widget.data, toRandom[cindex])));
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        padding: EdgeInsets.all(2),
        height: 235,
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
              height: sizeHeight-40,
              child: FutureBuilder<Uint8List>(
                future: fetchImageFile(widget.data.id.toString()),
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