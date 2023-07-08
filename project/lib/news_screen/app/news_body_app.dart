import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/news/article_data.dart';

class NewsFeed extends StatefulWidget {


  const NewsFeed({super.key});

  @override
  State<StatefulWidget> createState() => NewsState();
  }

  class NewsState extends State<NewsFeed> {
    late Future<int> fetchDone;
    late ScrollController controller;
    late int offset;
    late bool hasMore = true;

    @override
    void initState() {
      offset = 0;
      fetchDone = Article.fetchNews(3, "EMPTY", {});
      controller = ScrollController()
        ..addListener(handleScrolling);
      super.initState();
    }

    @override
    void dispose() {
      controller.removeListener(handleScrolling);
      super.dispose();
    }

    void handleScrolling() {
      if (controller.offset == controller.position.maxScrollExtent) {
        setState(() {
          offset = offset + 3;
          if (Article.news.length == Article.numNews)
            hasMore = false;
          else
            Article.fetchNews(3, "EMPTY", {});
        });
      }
    }

    Future refresh() async {
      setState(() {
        hasMore = true;
        offset = 0;
        Article.news.clear();
      });
      Article.fetchNews(3, "EMPTY", {});
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        color: cDirtyWhiteColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder(
              future: Article.fetchNews(3, "EMPTY", {}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == 500) {
                    return Error500();
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
                      LinearProgressIndicator(color: cPrimaryOverLightColor,
                        minHeight: 10,
                        backgroundColor: cPrimaryLightColor,),
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
    }/*FutureBuilder(
          future: fetchDone,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == 500) {
                return Error500();
              } else {
                return ListView.builder(
                    padding: EdgeInsets.all(10),
                    controller: controller,
                    itemCount: Article.news.length + 1,
                    itemBuilder: (context, int index) {
                      if (index < Article.news.length)
                        return NewsCard(Article.news[index]);
                      else
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 80),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(hasMore)
                                LinearProgressIndicator(
                                  color: cPrimaryOverLightColor,
                                  minHeight: 10,
                                  backgroundColor: cPrimaryLightColor,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  hasMore
                                      ? "A CARREGAR NOTÍCIAS"
                                      : "VISTE TODAS AS NOTÍCIAS!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: cPrimaryLightColor
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                    }
                );
              }
            }
            else Text(
              "A CARREGAR NOTÍCIAS",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cPrimaryLightColor
              ),
            );
          }
      );
    }

  /*return Padding(
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
          );
    }
}*/*/
  }