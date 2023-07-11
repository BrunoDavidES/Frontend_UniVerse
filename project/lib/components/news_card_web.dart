import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/app/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../consts/list_consts.dart';

class NewsCardWeb extends StatefulWidget {
  NewsCardWeb(this.data, {super.key, this.width, this.height});
  Article data;
  final width;
  final height;

  @override
  State<StatefulWidget> createState() => NewsCardStateWeb();
}

class NewsCardStateWeb extends State<NewsCardWeb> {
  @override

  Future<Uint8List> fetchImageFile(news) async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref('/News/' + news);
      final byteData = await ref.getData();
      return byteData!.buffer.asUint8List();
    } catch (e) {
      print('Error fetching file: $e');
      return Uint8List(0);
    }
  }

  Future<String> fetchTextFile(news) async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref('/News/' + news + '.txt');
      final response = await ref.getData();
      return utf8.decode(response as List<int>);
    } catch (e) {
      print('Error fetching text file: $e');
      return '';
    }
  }

  Widget build(BuildContext context) {
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    bool isHovering = false;
    return InkWell(
      onTap: () => context.go(
          "/news/full/${widget.data.id}",
          extra: widget.data),
      onHover: (hovering) {
        setState(() => isHovering = hovering);
      },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: widget.width/4,
          padding: const EdgeInsets.all(5),
          height: widget.height-230,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: toRandom[cindex],
                  width: 2
              ),
              boxShadow: [ BoxShadow(
                color: Colors.grey.withOpacity(0.75),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0,0),
              ),
              ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: widget.height/3,
                child: FutureBuilder<Uint8List>(
                  future: fetchImageFile(widget.data.id),
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
                padding: const EdgeInsets.all(5),
                child: Text(
                  widget.data.date!,
                  style: const TextStyle(
                      fontSize: 13,
                      color: cHeavyGrey
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:5, top: 10),
                child: Text(
                  widget.data.title!.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black
                  ),
                  maxLines: 4,
                ),
              ),
              FutureBuilder<String>(
                future: fetchTextFile(widget.data.id),
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }
                },
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
                    child: Text(
                      "Autoria de " + widget.data.author!,
                      style: const TextStyle(
                          fontSize: 13,
                          color: cHeavyGrey
                      ),
                    ),
                  ),
                ],
              ),
             /* Container(
                child: Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                widget.data.date!,
                                style: const TextStyle(
                                    fontSize: 15,
                                    color: cHeavyGrey
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10),
                        child: Text(
                          widget.data.title!.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 5, top: 10, bottom: 10),
                            child: Text(
                              "Autoria de: " + widget.data.author!,
                              style: const TextStyle(
                                fontSize: 13,
                                color: cHeavyGrey
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),*/
            ],
          ),
        ),
      );
  }
}