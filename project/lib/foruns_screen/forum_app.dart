import 'package:flutter/material.dart';

import '../bars/app_bar.dart';
import 'foruns_screen_app.dart';

class ForumScreenApp extends StatelessWidget {
  const ForumScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            ForunsScreenApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:3),
            )
          ],
        );
  }
}
