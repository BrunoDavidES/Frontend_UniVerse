import 'dart:async';

import 'package:UniVerse/components/500_web.dart';
import 'package:UniVerse/events_screen/events_web.dart';
import 'package:UniVerse/info_screen//universe_info_web.dart';
import 'package:UniVerse/news_screen/news_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'calendar_screen/personal_page_web_test.dart';
import 'components/not_found.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'faq_screen/faq_web.dart';
import 'find_screen/find_page_web.dart';
import 'main_screen/app/homepage_app.dart';
import 'main_screen/homepage_web.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'news_screen/news_web_detail_screen.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(!kIsWeb) {
    var data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    if(data.size.shortestSide<600) {
      SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    }
  }
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          '/error': (context) => Error500Web(),
          '/home': (context) => WebHomePage(),
          '/help': (context) => FAQWebPage(),
          '/find': (context) => FindWebPage(),
          '/news': (context) => NewsWebPage(),
          '/news/id_detail': (context) => NewsDetailScreenWeb(),
          '/events': (context) => EventWebPage(),
          '/about/us': (context) => UniverseInfoWeb(),
          '/personal/main': (context) => PersonalPageWeb(i: 0,),
          '/personal/profile': (context) => PersonalPageWeb(i: 1,),
          '/personal/report': (context) => PersonalPageWeb(i: 2,),
          '/personal/calendar': (context) => PersonalPageWeb(i: 3),
          '/personal/messages': (context) => PersonalPageWeb(i:4),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) => PageNotFound());
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