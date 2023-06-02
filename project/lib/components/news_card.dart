import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';

class NewsCard extends StatefulWidget {
  NewsCard(this.data, {super.key});
  Article data;

  @override
  State<StatefulWidget> createState() => NewsCardState();
}

class NewsCardState extends State<NewsCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewsDetailScreen(widget.data)));
      },
      child: Container(
        width: 400,
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(2),
        height: 225,
        decoration: BoxDecoration(
          color: cDirtyWhiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: widget.data.color!,
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
                      height: 190,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: NetworkImage(widget.data.urlToImage!),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    Container(
                      height: 190,
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
                    "autoria de "+widget.data.author!,
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