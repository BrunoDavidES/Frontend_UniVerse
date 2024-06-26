import 'package:UniVerse/report_screen/report_screen_app.dart';
import 'package:flutter/material.dart';

import '../bars/app_bar.dart';
import '../consts/color_consts.dart';

class ReportPageApp extends StatefulWidget {

  const ReportPageApp({super.key});

  @override
  State<ReportPageApp> createState() => _MyReportPageState();
}

class _MyReportPageState extends State<ReportPageApp> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          ReportScreenApp(),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:3),
          )
        ],
      ),
    );
  }
}
