import 'package:UniVerse/users_list_screen/users_card.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/news/article_data.dart';

class UsersListScreenApp extends StatefulWidget {

  const UsersListScreenApp({super.key});

  @override
  State<StatefulWidget> createState() => ListState();
  }

  class ListState extends State<UsersListScreenApp> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;

    @override
    void initState() {
      scrollController.addListener(scrollListener);
      if(Authentication.userIsLoggedIn && UniverseUser.usersList.isEmpty)
        UniverseUser.queryPublicUsers("8", UniverseUser.cursor);
      super.initState();
    }

    Future<void> scrollListener() async {
      if(isLoadingMore) return;
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
        if (UniverseUser.usersList.length == UniverseUser.numUsers)
          setState(() {
            hasMore = false;
            isLoadingMore = false;
          });
        else {
          setState(() {
            isLoadingMore = true;
          });
          await UniverseUser.queryPublicUsers("8", UniverseUser.cursor);
          setState(() {
            isLoadingMore = false;
            if (UniverseUser.usersList.length == UniverseUser.numUsers)
              hasMore = false;
          });
        }
      }
    }

    @override
    void dispose() {
      scrollController.removeListener(scrollListener);
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: cDirtyWhiteColor,
              title: Image.asset("assets/titles/people.png", scale: 6),
              leading: Builder(
                  builder: (context) {
                    return IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {Navigator.pop(context);},
                        color: cDarkBlueColorTransparent);
                  }
              ),
              leadingWidth: 20,
              elevation: 0,
              pinned: true,
              stretch: true,
              expandedHeight: 200,
              flexibleSpace: const FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                ],
                background: Image(
                    image: AssetImage("assets/images/photo_3.jpg",),
                    colorBlendMode: BlendMode.lighten,
                    fit: BoxFit.fill
                ),
              ),
            ),
            Authentication.userIsLoggedIn
            ?SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: UniverseUser.usersList.length+1,
                      (BuildContext context, int index) {
                        if (index < UniverseUser.usersList.length) {
                          return UserCard(UniverseUser.usersList[index]);
                          //return NewsCard(UniverseUser.usersList[index]);
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
                                        ? "A CARREGAR UTILIZADORES"
                                        : "VISTE TODOS OS UTILIZADORES!",
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
              )
            )
                :SliverList(
              delegate: SliverChildBuilderDelegate(
              childCount: 1,
      (BuildContext context, int index) {
        return Text("SEM SESSÃO");
      }
            ),),
          ],
        )
              );
  }
      }

      /*
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
    if(Article.news.isEmpty)
    Article.fetchNews(3, Article.cursor, {});
    super.initState();
  }

  Future<void> scrollListener() async {
    if(isLoadingMore) return;
    if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
      if (Article.news.length == Article.numNews)
        setState(() {
          hasMore = false;
          isLoadingMore = false;
        });
      else {
        setState(() {
          isLoadingMore = true;
        });
        await Article.fetchNews(3, Article.cursor, {});
        setState(() {
          isLoadingMore = false;
          if (Article.news.length == Article.numNews)
            hasMore = false;
        });
      }
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
       */