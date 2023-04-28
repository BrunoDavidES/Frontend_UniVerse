import 'package:UniVerse/Screens/Home/home_screen.dart';
import 'package:UniVerse/consts.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'main_screen/homepage_app.dart';
import 'main_screen/homepage_web.dart';
import 'package:flutter/foundation.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
        home: const WebHomePage(title: 'UniVerse'),
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



    return MaterialApp(
      title: 'UniVerse ּ  FCT NOVA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: cPrimaryColor,
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        //height: 60,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0, 128, 255, 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: Offset(0,0),
          ),
          ]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            backgroundColor: Color.fromRGBO(0, 128, 255, 1),
            color: Colors.white60,
            activeColor: Colors.white,
            gap:5,
            padding: EdgeInsets.all(8),
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Início',
              ),
              GButton(
                icon: Icons.search_rounded,
                text: 'Encontrar',
              ),
              GButton(
                icon: Icons.newspaper_rounded,
                text: 'Feed',
              ),
              GButton(
                icon: Icons.qr_code_scanner,
                text: 'Scan',
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Área Pessoal',
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
                'You are operating on ${kIsWeb ? "the web" : Platform.operatingSystem}',
            ),   //PLATFORM TESTING
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
