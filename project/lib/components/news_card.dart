import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/app/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

import '../consts/list_consts.dart';

class NewsCard extends StatefulWidget {
  NewsCard(this.data, {super.key});
  Article data;

  @override
  State<StatefulWidget> createState() => NewsCardState();
}

class NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {

    Future<Uint8List> fetchImageFile(String id) async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/News/$id');
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetailScreen(widget.data, toRandom[cindex])));
      },
      child: Container(
        width: sizeWidth,
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
        padding: EdgeInsets.all(2),
        height: sizeHeight,
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
            Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    width: double.infinity,
                    height: sizeHeight-40,
                    child: FutureBuilder<Uint8List>(
                      future: fetchImageFile(widget.data.id.toString()),
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
                    height: sizeHeight-40,
                    child: Column(
                      children: [
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(left:10, bottom: 5),
                          child: Text(
                            widget.data.title!.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: cDirtyWhiteColor
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]
            ),
            Padding(
              padding: const EdgeInsets.only(top:5, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.data.date!,
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Autoria de ${widget.data.author!}",
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}