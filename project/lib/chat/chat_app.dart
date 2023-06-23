import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../bars/app_bar.dart';
import 'contacts_screen_app.dart';

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
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: cDirtyWhiteColor,
        ),
        child: Stack(
          children: <Widget>[
            ContactsScreenApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            )
          ],
        ),
      ),
    );
  }
}
