import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/news_screen/news_app_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';

class NewsCardWeb extends StatefulWidget {
  NewsCardWeb(this.data, {super.key});
  Article data;

  @override
  State<StatefulWidget> createState() => NewsCardStateWeb();
}

class NewsCardStateWeb extends State<NewsCardWeb> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var hover = true;

    return Material(
      color: cDirtyWhite,
      child: InkWell(
        onTap:(){},
        onHover: (hover) {
          setState(() {
            hover = false;
          });
        },
        child: Container(
          width: width/4,
          padding: EdgeInsets.all(8),
          height: 400,
          decoration: BoxDecoration(
              color: cDirtyWhiteColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [ BoxShadow(
                color: hover ? cPrimaryLightColor.withOpacity(0.5):cDirtyWhite,
                spreadRadius: hover ? 3:0,
                blurRadius:  hover ? 7:0,
                offset: const Offset(0,0),
              ),
              ]
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height/3.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: NetworkImage(widget.data.urlToImage!),
                        fit: BoxFit.fitHeight
                    )
                ),
              ),
              Container(
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
                            Spacer(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}