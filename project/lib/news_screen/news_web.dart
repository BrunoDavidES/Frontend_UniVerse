import 'dart:math';

import 'package:UniVerse/news_screen/news_web_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:go_router/go_router.dart';
import '../Components/default_button.dart';
import '../components/500.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/news/article_data.dart';
import 'news_web_Aux.dart';
import 'news_web_AuxEndPage.dart';

class NewsWebPage extends StatefulWidget {
  NewsWebPage({super.key});

  @override
  State<NewsWebPage> createState() => _NewsWebPageState();
}

class _NewsWebPageState extends State<NewsWebPage> {
  ScrollController yourScrollController = ScrollController();
  late Future<int> fetchDone;

  @override
  void initState() {
    fetchDone = Article.fetchNews("4", "0", {});
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
    return Scaffold(
        body: Scrollbar(
          thumbVisibility: true, //always show scrollbar
          thickness: 8, //width of scrollbar
          interactive: true,
          radius: const Radius.circular(20), //corner radius of scrollbar
          scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
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
                              child: Image.asset("assets/web/noticias.png", scale: 4,)
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 30),
                          //Zona do Feed
                          height: size.height * 1.60,
                          width: size.width - 300,
                          color: cDirtyWhite,

                          child: FutureBuilder(
                              future: fetchDone,
                              builder: (context, snapshot) {
                                if (snapshot.data == 500) {
                                  return Error500();
                                }
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (BuildContext context, int index) {
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
                                            height: size.height / 3,
                                            decoration: BoxDecoration(
                                              color: cDirtyWhiteColor,
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            margin: EdgeInsets.only(top: 5, bottom: 5),
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: size.width / 4,
                                                    height: size.height / 3,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(
                                                          15.0),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(item.urlToImage!),
                                                      ),
                                                      border: Border.all(
                                                        color: cHeavyGrey,
                                                      ),
                                                      boxShadow: [ BoxShadow(
                                                        color: Colors.grey.withOpacity(0.75),
                                                        spreadRadius: 3,
                                                        blurRadius: 7,
                                                        offset: const Offset(0, 0),
                                                      ),
                                                      ],
                                                    )
                                                ),
                                                SizedBox(width: 15,),
                                                Container(
                                                    width: size.width / 1.95,
                                                    height: size.height / 3,
                                                    margin: EdgeInsets.only(
                                                        top: 5, bottom: 5),
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Text(
                                                          "${item.title}".toUpperCase(),
                                                          style: const TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 20),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(height: 15,),
                                                        Text(
                                                          "${item.text}",
                                                          maxLines: 3,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        Spacer(),
                                                        Row(
                                                          children: [
                                                              Text(
                                                                "Autoria de ${item.author} · ${item
                                                                    .date}",
                                                                style: TextStyle(
                                                                    color: cHeavyGrey
                                                                ),
                                                              ),
                                                            Spacer(),
                                                            IconButton(onPressed: () {}, icon: Icon(Icons.share, color: cHeavyGrey,)),
                                                            IconButton(onPressed: () =>context.go("/news/full/${item.id}", extra: item), icon: Icon(Icons.remove_red_eye, color: cHeavyGrey,))
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                                return Center(
                                    child: LinearProgressIndicator());
                              }
                          ),
                        ),
                        SizedBox(
                          width: size.width - 300,
                          child: Divider(
                            thickness: 2,
                            color: toRandom[cindex],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 60.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DefaultButton(
                                  text: "Próxima Página",
                                  press: () {
                                    Article.news.length > 6 ?
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            NewsWebPageAux(indexAux: 1))) :
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            NewsWebPageAuxEnd(indexAux: 1)));
                                  }),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icons.navigate_next_outlined,
                                ].map((e) {
                                  return InkWell(
                                    onTap: () {
                                      Article.news.length > 6 ?
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              NewsWebPageAux(indexAux: 1))) :
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>
                                              NewsWebPageAuxEnd(indexAux: 1)));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: Icon(e, size: 50, color: cPrimaryColor),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
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
        )
    );
  }

}
