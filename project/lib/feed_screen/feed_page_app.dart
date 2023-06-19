import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../bars/app_bar.dart';
import '../components/simple_dialog_box.dart';
import '../find_screen/find_page_body_app.dart';
import '../utils/connectivity.dart';
import 'feed_page_body_app.dart';

class FeedPageApp extends StatefulWidget {

  const FeedPageApp({super.key});

  @override
  State<FeedPageApp> createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<FeedPageApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;

  @override
  void initState() {
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

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
            FeedPageBodyApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:2),
            )
          ],
        ),
      ),
    );

  }
}
