
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/find_screen/find_page_app.dart';
import 'package:UniVerse/info_screen/universe_info_app.dart';
import 'package:UniVerse/login_screen/login_app.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../find_screen/services_screen/services_body_app.dart';

class CustomAppBar extends StatelessWidget {
  final int i;

  const CustomAppBar({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: cPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0,0),
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
          padding: const EdgeInsets.all(8),
          tabs: [
            GButton(
              icon: Icons.home_rounded,
              text: 'Início',
              onPressed: (){
                _navigateToNextScreenHome(context);
              },
            ),
            GButton(
              icon: Icons.search_rounded,
              text: 'Procurar',
              onPressed: (){
                _navigateToNextScreenFind(context);
              },
            ),
            GButton(
              icon: Icons.newspaper_rounded,
              text: 'Feed',
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => DialogTestPage()));
              },
            ),
            /*GButton(
              icon: Icons.qr_code_scanner,
              text: 'Scan',
            ),*/
            GButton(
              icon: Icons.person_rounded,
              text: 'Área Pessoal',
              onPressed: (){
                _navigateToNextScreenPersonal(context);
              },
            ),
            GButton(
              icon: Icons.settings_rounded,
              text: 'Definições',
              onPressed: (){
                _navigateToNextScreenSettings(context);
                },
            ),
          ],
          selectedIndex: i,
        ),
      ),
    );
  }

  void _navigateToNextScreenHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppHomePage()));
  }

  void _navigateToNextScreenSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UniverseInfoApp()));
  }

  void _navigateToNextScreenPersonal(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageApp()));
  }

  void _navigateToNextScreenFind(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindPageApp()));
  }


}