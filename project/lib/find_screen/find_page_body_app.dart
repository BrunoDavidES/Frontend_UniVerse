import 'package:flutter/material.dart';
import 'package:UniVerse/consts.dart';

class FindPageBodyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 20,
        leading: Builder(
        builder: (context) {
      return IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {Navigator.pop(context);},
          color: cDarkBlueColor);
    }
    ),

    title: Image.asset('assets/faq_title.png', scale: 5),
    backgroundColor: cDirtyWhiteColor,
        ),
    );

  }
}