import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
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
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NewsWebPage extends StatefulWidget {
  @override
  State<NewsWebPage> createState() => _NewsWebPageState();
}

class _NewsWebPageState extends State<NewsWebPage> {
  ScrollController yourScrollController = ScrollController();
  late Future<int> fetchDone;

  int totalArticlesCount = Article.numNews;
  int loadedArticlesCount = 5;

  @override
  void initState() {
    print(Article.numNews);
    fetchNews();
    super.initState();
  }

  Future<void> fetchNews() async {
    fetchDone = Article.fetchNews(loadedArticlesCount, Article.cursor, {});
    await fetchDone;
    setState(() {
      totalArticlesCount = Article.numNews;
      loadedArticlesCount = min(loadedArticlesCount, totalArticlesCount);
    });
  }

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
                        height: 300 * loadedArticlesCount as double,
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
                                          height: 250,
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
                                                width: size.width /3.5,
                                                height: 250,
                                                child: FutureBuilder<Uint8List>(
                                                  future: fetchImageFile(Article.news[index].id),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return CircularProgressIndicator();
                                                    } else if (snapshot.hasError) {
                                                      return Text('Error fetching image: ${snapshot.error}');
                                                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                                                      return Image.memory(
                                                        snapshot.data!,
                                                        fit: BoxFit.contain,
                                                      );
                                                    } else {
                                                      return Text('Image not found');
                                                    }
                                                  },
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
                                                    FutureBuilder<String>(
                                                      future: fetchTextFile(Article.news[index].id),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                                          return CircularProgressIndicator();
                                                        } else if (snapshot.hasError) {
                                                          return Text('Error fetching file');
                                                        } else {
                                                          return Padding(
                                                            padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
                                                            child: Text(
                                                              snapshot.data ?? '',
                                                              textAlign: TextAlign.start,
                                                              style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      },
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
                                                            /*IconButton(
                                                              onPressed: () {
                                                                final urlPreview = "https://universe-fct.oa.r.appspot.com/#/news/full/${item.id.toString()}";
                                                                Share.share("${item.title.toString()} | UniVerse ּ FCT NOVA\n\n${urlPreview}", subject: "Uma notícia FCT | UniVerse ּ FCT NOVA");
                                                              },
                                                              icon: Icon(
                                                                Icons.share,
                                                                color:
                                                                cHeavyGrey,
                                                              ),
                                                            ),*/
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
                                      Article.cursor,
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
