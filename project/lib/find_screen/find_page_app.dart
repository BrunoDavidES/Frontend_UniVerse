import 'package:flutter/material.dart';
import 'package:UniVerse/consts.dart';

import '../bars/app_bar.dart';
import 'find_page_body_app.dart';

class FindPageApp extends StatefulWidget {

  const FindPageApp({super.key});

  @override
  State<FindPageApp> createState() => _MyFindPageState();
}

class _MyFindPageState extends State<FindPageApp> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white70,
        ),
        child: Column(
          children: <Widget>[
            FindPageBodyApp(),
            Spacer(),
            CustomAppBar(),
          ],
        ),
      ),
    );
  }
}
