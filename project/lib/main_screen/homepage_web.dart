import 'package:flutter/material.dart';

import 'package:UniVerse/bars/web_bar.dart';

class WebHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/web/BackGround.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            CustomWebBar()],
        ),
      ),
    );
  }
}