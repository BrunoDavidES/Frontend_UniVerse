import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:UniVerse/news_screen/news_web_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:share_plus/share_plus.dart';

import '../Components/default_button.dart';
import '../components/500.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';

class NewsWebPage extends StatefulWidget {
  @override
  State<NewsWebPage> createState() => _NewsWebPageState();
}

class _NewsWebPageState extends State<NewsWebPage> {
  ScrollController yourScrollController = ScrollController();
  late Future<int> fetchDone;

  int loadedArticlesCount = 5;
  int totalArticlesCount = Article.news.length;

  @override
  void initState() {
    fetchDone = Article.fetchNews(loadedArticlesCount, 0, {});
    super.initState();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true,
        thickness: 8,
        interactive: true,
        radius: const Radius.circular(20),
        scrollbarOrientation: ScrollbarOrientation.right,
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Container(
            color: cDirtyWhite,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: size.height / 7),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 50, top: 20),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            "assets/titles/news.png",
                            scale: 4.5,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 30),
                        height: 315 * loadedArticlesCount as double,
                        width: size.width / 1.20,
                        color: cDirtyWhite,
                        child: FutureBuilder<int>(
                          future: fetchDone,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == 500) {
                                return Error500();
                              } else {
                                return ListView.builder(
                                  itemCount: loadedArticlesCount,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index >= Article.news.length) {
                                      return Container(); // Return an empty container if the index is out of range
                                    }

                                    final item = Article.news[index];
                                    return Column(
                                      children: [
                                        SizedBox(
                                          child: Divider(
                                            thickness: 2,
                                            color: toRandom[cindex],
                                          ),
                                        ),
                                        Container(
                                          height: 280,
                                          decoration: BoxDecoration(
                                            color: cDirtyWhiteColor,
                                            borderRadius:
                                            BorderRadius.circular(15),
                                          ),
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          padding: const EdgeInsets.all(5),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: size.width / 4,
                                                height: 260,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      15.0),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                      item.urlToImage!,
                                                    ),
                                                  ),
                                                  border: Border.all(
                                                    color: cHeavyGrey,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.75),
                                                      spreadRadius: 3,
                                                      blurRadius: 7,
                                                      offset:
                                                      const Offset(0, 0),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 15,
                                              ),
                                              Container(
                                                width: size.width / 1.95,
                                                height: 260,
                                                margin: EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${item.title}"
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "${item.text}",
                                                      maxLines: 10,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                    Spacer(),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Autoria de ${item.author} · ${item.date}",
                                                            style: TextStyle(
                                                              color: cHeavyGrey,
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            IconButton(
                                                              onPressed: () {
                                                                final urlPreview = "https://universe-fct.oa.r.appspot.com/#/news/full/${item.id.toString()}";
                                                                Share.share("${item.title.toString()} | UniVerse ּ FCT NOVA\n\n${urlPreview}", subject: "Uma notícia FCT | UniVerse ּ FCT NOVA");
                                                              },
                                                              icon: Icon(
                                                                Icons.share,
                                                                color:
                                                                cHeavyGrey,
                                                              ),
                                                            ),
                                                            IconButton(
                                                              onPressed: () =>
                                                                  context.go(
                                                                    "/news/full/${item.id}",
                                                                    extra: item,
                                                                  ),
                                                              icon: Icon(
                                                                Icons
                                                                    .remove_red_eye,
                                                                color:
                                                                cHeavyGrey,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                            return Center(
                              child: LinearProgressIndicator(),
                            );
                          },
                        ),
                      ),
                      if (loadedArticlesCount < totalArticlesCount)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 60.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultButton(
                                text: "Carregar mais",
                                press: () {
                                  setState(() {
                                    loadedArticlesCount += 5;
                                    if (loadedArticlesCount >
                                        totalArticlesCount) {
                                      loadedArticlesCount = totalArticlesCount;
                                    }
                                    fetchDone = Article.fetchNews(
                                      loadedArticlesCount,
                                      0,
                                      {},
                                    );
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      if (!(loadedArticlesCount < totalArticlesCount))
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 60.0,
                          ),
                        ),
                      BottomAbout(size: size),
                    ],
                  ),
                ),
                Container(
                  color: cDirtyWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWebBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
