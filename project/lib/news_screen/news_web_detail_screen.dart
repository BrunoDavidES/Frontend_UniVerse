
import 'dart:math';

import 'package:flutter/material.dart';

import '../Components/default_button.dart';
import '../bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/news/article_data.dart';

class NewsDetailScreenWeb extends StatefulWidget {
  NewsDetailScreenWeb(/*this.data, this.color,*/ {super.key});
  //Article data;
  //Color color;

  @override
  State<StatefulWidget> createState() => NewsDetailState();
}

class NewsDetailState extends State<NewsDetailScreenWeb> {
  ScrollController yourScrollController = ScrollController();
  final item = _articles[0];
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
            decoration: BoxDecoration(
              gradient: RadialGradient(
                focal: Alignment.centerLeft,
                focalRadius: 0.2,
                center: Alignment.centerLeft,
                radius: 0.40,
                colors: [
                  cPrimaryOverLightColor,
                  cDirtyWhite,
                ],
              ),
            ),
            child: Stack(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top: size.height/7),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:50, top: 20, bottom: 30),
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Image.asset("assets/web/noticias.png", scale: 4,)
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 20),
                              width: size.width/3.5,
                              height: size.height/2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage("https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/06/santanderexpresso.png"),
                                ),
                                border: Border.all(
                                  color: cHeavyGrey,
                                ),
                                boxShadow: [ BoxShadow(
                                  color: Colors.grey.withOpacity(0.75),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0,0),
                                ),
                                ],
                              )
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Text("${item.title}".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                              Container(
                                width: size.width-size.width/2.75,
                                margin: EdgeInsets.only(bottom: 10),
                                child: Text(
                                  "${item.preNews}",
                                  style: TextStyle(
                                    fontSize: 15
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Spacer(),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top:20, bottom: 60),
                child: Icon(Icons.arrow_back_ios_new_outlined, size: 50, color: cPrimaryColor),
              ),
            ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 60),
                            child: DefaultButton(
                                text: "Página Anterior",
                                press: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Spacer()
                        ],
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
        )
              )
    );
  }
}

class Article {
  final String title;
  final String preNews;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {
        required this.title,
        required this.preNews,
        required this.imageUrl,
        required this.author,
        required this.postedOn});
}

final List<Article> _articles = [
Article(
title: "Instagram quietly limits ‘daily time limit’ option",
preNews: "Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim. A notícia ser for muito grande pode ser um problema, nao sei, veremos. Este é um teste para tornar a página fazívle. Isto e um teste so para ter o inicio das noticias, secalhar a primeira frase ou as primerias frases, so para as pessoas poderem ler a noticia ou perceberem a mesma sem terem de clicar nela porque isso e mesmo muito chato, nao? Pessoalmente acho que sim. A notícia ser for muito grande pode ser um problema, nao sei, veremos. Este é um teste para tornar a página fazívle.",
author: "MacRumors",
imageUrl: "https://picsum.photos/id/1000/960/540",
postedOn: "Yesterday",
),
];