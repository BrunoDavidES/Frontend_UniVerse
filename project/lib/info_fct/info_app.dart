import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

import 'info_body_app.dart';

class FCTinfoApp extends StatelessWidget {
  const FCTinfoApp({super.key});

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
                color: cDarkBlueColor);
          }
        ),
        backgroundColor: cDirtyWhiteColor,

      ),

      body: const FCTinfoBodyApp(),
    );
  }
}
