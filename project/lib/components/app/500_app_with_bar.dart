
import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

class Error500WithBar extends StatelessWidget {
  final int i;
  final Image title;
  const Error500WithBar({super.key, required this.i, required this.title});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          title: title,
          automaticallyImplyLeading: false,
          backgroundColor: cDirtyWhiteColor,
          titleSpacing: 15,
          elevation: 0,
        ),
      body: Column(
        children: <Widget>[
          const Error500(),
          Spacer(),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:i),
          )
        ],
      ),
    );
  }
}