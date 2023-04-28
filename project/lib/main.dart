import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'main_screen/app/homepage_app.dart';
import 'main_screen/homepage_web.dart';
import 'package:flutter/foundation.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if(kIsWeb) {
      return MaterialApp(
        title: 'UniVerse ּ  FCT NOVA',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: WebHomePage(),
      );
    } else {
      return MaterialApp(
        title: 'UniVerse ּ  FCT NOVA',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const AppHomePage(title: 'UniVerse'),
      );
    }

    }
  }