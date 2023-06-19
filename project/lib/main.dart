import 'dart:async';

import 'package:UniVerse/events_screen/events_web.dart';
import 'package:UniVerse/info_screen//universe_info_web.dart';
import 'package:UniVerse/news_screen/news_web.dart';
import 'package:UniVerse/personal_page_screen/personal_page_web.dart';
import 'package:UniVerse/utils/network_controller.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'faq_screen/faq_web.dart';
import 'find_screen/find_page_web.dart';
import 'find_screen/find_test.dart';
import 'find_screen/maps_screen/maps_page_app.dart';
import 'find_screen/test.dart';
import 'info_screen/universe_info_app.dart';
import 'login_screen/login_web.dart';
import 'main_screen/app/homepage_app.dart';
import 'main_screen/homepage_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
 // if(kIsWeb)
    //usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(kIsWeb) {
     // Article.fetchNews(3, 0);
      return MaterialApp(
        title: 'UniVerse ּ  FCT NOVA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        routes: {
          '/home': (context) => WebHomePage(),
          '/help': (context) => FAQWebPage(),
          '/find': (context) => FindWebPage(),
          '/news': (context) => NewsWebPage(),
          '/events': (context) => EventWebPage(),
          '/about/us': (context) => UniverseInfoWeb(),
          '/personal/main': (context) => PersonalWebPage(),
        },
      );
    } else {
      return MaterialApp(
        title: 'UniVerse ּ  FCT NOVA',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AppHomePage(),
      );
    }
  }
}