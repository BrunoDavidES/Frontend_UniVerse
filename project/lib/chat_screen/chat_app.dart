import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../bars/app_bar.dart';
import 'foruns_screen_app.dart';

class ChatScreenApp extends StatefulWidget {

  const ChatScreenApp({super.key});

  @override
  State<ChatScreenApp> createState() => _MyFindPageState();
}

class _MyFindPageState extends State<ChatScreenApp> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
          children: <Widget>[
            ForunsScreenApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            )
          ],
        ),
      );
  }
}
