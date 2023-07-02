
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Components/default_button.dart';
import '../bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/news/article_data.dart';

class NewsDetailScreenWeb extends StatelessWidget {
  final String id;
  final Article data;
  NewsDetailScreenWeb( {super.key, required this.id, required this.data});

  ScrollController yourScrollController = ScrollController();
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
                          Container(
                            width: size.width-size.width/2.75,
                            decoration: BoxDecoration(
                              color: cDirtyWhiteColor,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text("${data.title}".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                ),
                                Container(
                                  width: size.width-size.width/2.75,
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    "${data.text}",
                                    style: TextStyle(
                                      fontSize: 15
                                    ),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:20, right: 20),
                                      child:Text("Autoria de ${data.author} · ${data.date}",
                                        style: TextStyle(
                                            color: cHeavyGrey
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
                                  Navigator.pop(context); }),
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
