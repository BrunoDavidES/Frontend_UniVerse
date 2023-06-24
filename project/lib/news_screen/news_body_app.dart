import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../components/500_app.dart';
import '../components/news_card.dart';
import '../components/simple_dialog_box.dart';
import '../consts/color_consts.dart';
import '../utils/connectivity.dart';
import '../utils/news/article_data.dart';

class NewsFeed extends StatefulWidget {


  const NewsFeed({super.key});

  @override
  State<StatefulWidget> createState() => NewsState();
  }

  class NewsState extends State<NewsFeed> {

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
                if (snapshot.hasData) {
                  if (snapshot.data == 500) {
                    return Error500App();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: Article.news.map((e) => NewsCard(e)).toList(),
                    );
                  }
                }
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LinearProgressIndicator(color: cPrimaryOverLightColor, minHeight: 10, backgroundColor: cPrimaryLightColor,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "A CARREGAR NOTÍCIAS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: cPrimaryLightColor
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            /*Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: Article.news.map((e) => NewsCard(e)).toList(),*/
            //SizedBox(height: 10,)
          ),
          ),
        );
    }
}
