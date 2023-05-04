
import 'package:UniVerse/consts.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/find_screen/find_page_app.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class CustomAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      //height: 60,
      decoration: BoxDecoration(
          color: cPrimaryColor,
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
          backgroundColor: cPrimaryColor,
          color: Colors.white60,
          activeColor: Colors.white,
          gap:5,
          padding: EdgeInsets.all(8),
          tabs: [
            GButton(
              icon: Icons.home_rounded,
              text: 'Início',

            ),
            GButton(
              icon: Icons.search_rounded,
              text: 'Encontrar',
              onPressed: (){
                _navigateToNextScreenFind(context);
              },
            ),
            GButton(
              icon: Icons.newspaper_rounded,
              text: 'Feed',
            ),
            /*GButton(
              icon: Icons.qr_code_scanner,
              text: 'Scan',
            ),*/
            GButton(
              icon: Icons.person_rounded,
              text: 'Área Pessoal',
              /*onPressed: (){
                _navigateToNextScreenPersonal(context);
              },*/
            ),
            GButton(
              icon: Icons.settings_rounded,
              text: 'Definições',
              onPressed: (){
                _navigateToNextScreenSettings(context);
                },
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreenSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaqApp()));
  }

  /*void _navigateToNextScreenPersonal(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PersonalPageApp()));
  }*/

  void _navigateToNextScreenFind(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindPageApp()));
  }

}