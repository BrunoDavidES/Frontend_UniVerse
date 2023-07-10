import 'dart:convert';

import 'package:UniVerse/components/fct_today_card.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/info_fct_screen/info_app.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../consts/text_consts.dart';

class WelcomeBodyApp extends StatelessWidget {
  var monthString = monthsInText[DateTime.now().month-1];
  @override
  Widget build(BuildContext context) {
    var pad;
    Size size = MediaQuery.of(context).size;
    if(size.width>=600) {
      if(MediaQuery.of(context).orientation==Orientation.landscape)
        pad=size.width/3.9;
      else pad = size.width/5.5;
    }
    else pad=0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:60, bottom: 20),
            child:Image.asset("assets/app/logo_no_reference_no_white.png", scale: 3.5),
          ),
          Image.asset("assets/app/logo_nova_horiz.png", scale: 12),
          const Spacer(),
          Authentication.userIsLoggedIn
              ?TodayWidget(size: size, monthString: monthString)
              :WelcomeTextWidget(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom:80, right: pad),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                    color: cDarkBlueColorTransparent,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: TextButton(
                  onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FCTinfoApp()));},
                  child:
                  const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                      size:25
                  ),
                ),


              ),
            ),
          ),
        ],
      ),
    );

  }
}

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            "Todo o Universo,\nnum só lugar!".toUpperCase(),
            style: TextStyle(
                color: cDirtyWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 30
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Text(
            "Inicia sessão para saberes o que se passa Hoje na FCT.",
            style: TextStyle(
                color: cDirtyWhite.withOpacity(0.8),
                fontSize: 15
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class TodayWidget extends StatelessWidget {
  const TodayWidget({
    super.key,
    required this.size,
    required this.monthString,
  });

  final Size size;
  final String monthString;

  Future<String> fetchTextFile() async {
    try {
      final ref = firebase_storage.FirebaseStorage.instance.ref('hojenafct.txt');
      final response = await ref.getData();
      return utf8.decode(response as List<int>);
    } catch (e) {
      print('Error fetching text file: $e');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchTextFile(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          LinearProgressIndicator(color: cDirtyWhite,
          minHeight: 10,
          backgroundColor: cDirtyWhiteColor,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "A CARREGAR",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cDirtyWhiteColor
            ),
          ),
        ),
        ]
    )
      );
    } else if (snapshot.hasError) {
    return Text('Error fetching file');
    } else {
    return Container(
    padding: const EdgeInsets.all(15),
    width: size.width,
    height: size.height/3,
    decoration: BoxDecoration(
    color: cDirtyWhiteColor.withOpacity(0.6),
    borderRadius: BorderRadius.circular(15)
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    const Text(
    "HOJE NA FCT",
    style: TextStyle(
    color: cHeavyGrey,
    fontWeight: FontWeight.bold,
    fontSize: 20
    ),
    ),
    const Spacer(),
    Text(
    "${DateTime.now().day} $monthString",
    style: const TextStyle(
    color: cHeavyGrey,
    fontSize: 20
    ),
    ),
    ],
    ),
      Spacer(),
      Text(snapshot.data!,
      textAlign: TextAlign.justify,
      style: TextStyle(
        fontSize: 18
      ),),
      Spacer()
    ],
    ),
    );
    }});
    }
  }