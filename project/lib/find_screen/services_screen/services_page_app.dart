import 'package:UniVerse/find_screen/services_screen/services_body_app.dart';
import 'package:flutter/material.dart';

import '../../bars/app_bar.dart';
import '../../consts/color_consts.dart';

class ServicesPageApp extends StatefulWidget {

  const ServicesPageApp({super.key});

  @override
  State<ServicesPageApp> createState() => _MyServicesPageState();
}

class _MyServicesPageState extends State<ServicesPageApp> {

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
            ServicesBodyApp(),
            Container(
              alignment: Alignment.bottomCenter,
              child:CustomAppBar(i:1),
            )
          ],
        ),
      ),
    );
  }
}