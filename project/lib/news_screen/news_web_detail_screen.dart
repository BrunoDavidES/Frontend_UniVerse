
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Components/default_button.dart';
import '../bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../utils/news/article_data.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class NewsDetailScreenWeb extends StatelessWidget {
  final String id;
  final Article data;
  NewsDetailScreenWeb( {super.key, required this.id, required this.data});

  ScrollController yourScrollController = ScrollController();
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
        return String.fromCharCodes(response as Iterable<int>);
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
                            child: Image.asset("assets/titles/news.png", scale: 4,)
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 50, right: 20),
                              width: size.width/3.5,
                              height: size.height/2.5,
                              child: FutureBuilder<Uint8List>(
                                future: fetchImageFile(data.id),
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
                                  child: FutureBuilder<String>(
                                    future: fetchTextFile(data.id),
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
