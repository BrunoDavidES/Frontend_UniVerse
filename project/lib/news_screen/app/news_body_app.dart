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
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;

    @override
    void initState() {
      scrollController.addListener(scrollListener);
      Article.fetchNews(3, Article.cursor, {});
      super.initState();
    }

    Future<void> scrollListener() async {
      if(isLoadingMore) return;
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadingMore = true;
        });
        await Article.fetchNews(3, Article.cursor, {});
        setState(() {
          isLoadingMore = false;
          if(Article.news.length == Article.numNews)
            hasMore = false;
        });
      }
    }

    @override
    void dispose() {
      scrollController.removeListener(scrollListener);
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return ListView.builder(
          controller: scrollController,
          itemCount: Article.news.length+1,
          itemBuilder: (context, index) {
            if(index<Article.news.length) {
              return NewsCard(Article.news[index]);
            } else {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 10, left: 10, right: 10, bottom: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if(isLoadingMore)
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
          }
      );
        //),
     // );
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