import 'dart:math';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/app/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';

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
        margin: EdgeInsets.only(bottom: 20),
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
                      width: double.infinity,
                      height: sizeHeight-40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(widget.data.urlToImage),
                              fit: BoxFit.cover
                          )
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