
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../utils/events/event_data.dart';
import '../utils/news/article_data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class EventsDetailScreen extends StatelessWidget {
  EventsDetailScreen(this.data, this.color, {super.key});
  Event data;
  Color color;

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
        throw Exception('Failed to fetch image file.');
      }
    }

    Future<String> fetchTextFile() async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/Events/' + data.id! + '.txt');
        final response = await ref.getData();
        return utf8.decode(response as List<int>);
      } catch (e) {
        return '';
      }
    }
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
                color: color,
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
                data.title!.toUpperCase(),
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
                          child: Text("${data.startDate} · ${data.endDate}",
                            style: TextStyle(
                                color: cHeavyGrey
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:15, left: 10, right: 10),
                          child: Row(
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
                        ),
                        if(data.isPaid=="yes")
                          Padding(
                            padding:  EdgeInsets.only(top:15, left: 10, right: 10),
                            child: Icon(Icons.euro_outlined, color: cHeavyGrey),
                          ),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: cHeavyGrey),
                          Text(
                            data.location!,
                            maxLines: 1,
                            style: TextStyle(
                                color: cHeavyGrey
                            ),
                          ),

                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: fetchTextFile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error fetching file');
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(left:10, top: 10, right: 10),
                            child: Text(
                              snapshot.data ?? '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 15
                              ),
                            ),
                          );
                        }
                      },
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