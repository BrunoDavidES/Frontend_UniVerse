import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import 'universe_info_body_app.dart';

class UniverseInfoApp extends StatelessWidget {
  const UniverseInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 20,
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {Navigator.pop(context);},
                  color: cDarkBlueColorTransparent);
            }
        ),
        title: Image.asset("assets/titles/about_us.png", scale: 6),
        backgroundColor: cDirtyWhiteColor,

      ),
      body: const UniverseInfoBodyApp(),
    );
  }
}
