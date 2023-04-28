import 'package:UniVerse/Screens/Home/home_screen.dart';
import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'dart:io';
import 'package:flutter/foundation.dart';
=======
import 'package:google_nav_bar/google_nav_bar.dart';
>>>>>>> 928e325634893425ae85c3b5a4f62f093ad53de0

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniVerse ּ  FCT NOVA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
<<<<<<< HEAD
        primaryColor: cPrimaryColor,
=======
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
>>>>>>> 928e325634893425ae85c3b5a4f62f093ad53de0
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
<<<<<<< HEAD
      appBar: AppBar(
        title: Text(widget.title),
=======
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
>>>>>>> 928e325634893425ae85c3b5a4f62f093ad53de0
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
