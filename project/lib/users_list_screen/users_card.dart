import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/app/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../consts/list_consts.dart';

class UserCard extends StatelessWidget {
  UserCard(this.data, {super.key});
  UniverseUser data;

  @override
  Widget build(BuildContext context) {

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
    return Container(
      padding: EdgeInsets.all(10),
     // width: sizeWidth,
      margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
     // height: sizeHeight,
      decoration: BoxDecoration(
          color: cDirtyWhiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: toRandom[cindex],
              width: 2
          ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Text(
                 data.name.toUpperCase(),
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                 color: cHeavyGrey,
               ),
             ),
              Text(
                data.email,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: cHeavyGrey,
                ),
              ),
              if(data.linkedin.isNotEmpty)
              Text(
                "Linkedin: ${data.linkedin}",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: cHeavyGrey,
                ),
              ),
              if(data.linkedin.isNotEmpty)
                Text(
                  "Gabinete: ${data.office}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: cHeavyGrey,
                  ),
                ),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                data.department,
                style: TextStyle(
                  color: cHeavyGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}