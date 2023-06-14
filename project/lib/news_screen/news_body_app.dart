import 'package:flutter/material.dart';

import '../components/news_card.dart';
import '../consts/color_consts.dart';
import '../utils/news/article_data.dart';

class NewsFeed extends StatefulWidget {


  const NewsFeed({super.key});

  @override
  State<StatefulWidget> createState() => NewsState();
  }

  class NewsState extends State<NewsFeed> {
  late List<String> news;

  @override
  void initState() {
  super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: cDirtyWhiteColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder(
            future: Article.fetchNews(3, 0),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: Article.news.map((e) => NewsCard(e)).toList(),
                );
              }
              return Center(
                child: LinearProgressIndicator(),
              );
            },
          ),
          /*Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: Article.news.map((e) => NewsCard(e)).toList(),
            //SizedBox(height: 10,)
          ),*/
        ),
      ),
    );
  }
}