
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../consts/color_consts.dart';
import '../../utils/news/article_data.dart';

class NewsDetailScreen extends StatelessWidget {
  NewsDetailScreen(this.data, this.color, {super.key});
  Article data;
  Color color;

  @override
  Widget build(BuildContext context) {
    Future<String> fetchTextFile() async {
      try {
        final ref = firebase_storage.FirebaseStorage.instance.ref('/News/' + data.id! + '.txt');
        final response = await ref.getData();
        return utf8.decode(response as List<int>);
      } catch (e) {
        print('Error fetching text file: $e');
        return '';
      }
    }

    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left:10, top:40, bottom: 10, right: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: cDirtyWhiteColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: color,
                width: 2
            ),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(data.urlToImage),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Container(
                    height: 190,
                    child: Column(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {Navigator.pop(context);},
                            color: cDirtyWhiteColor),
                      ],
                    ),
                  )
                ]
            ),
            Padding(
              padding: const EdgeInsets.only(top:5, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    data.date!,
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                  SizedBox(width: 25,),
                  Text(
                    "Autoria de ${data.author!}",
                    style: TextStyle(
                        fontSize: 13,
                        color: cHeavyGrey
                    ),
                  ),
                  Spacer(),
                  InkWell(child: Icon(Icons.share_outlined, color: cHeavyGrey,), onTap: () {
                    final urlPreview = "https://universe-fct.oa.r.appspot.com/#/news/full/${data.id!.toString()}";
                    Share.share("${data.title!.toString()} | UniVerse ּ FCT NOVA\n\n${urlPreview}", subject: "Uma notícia FCT | UniVerse ּ FCT NOVA");
                  },),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left:10, right: 10, bottom: 5),
                      child: Text(
                        data.title!.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: fetchTextFile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error fetching file');
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(left:10, top: 10, right: 10),
                            child: Text(
                              snapshot.data ?? '',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 15
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}