
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/faq_screen/faq_app.dart';
import 'package:UniVerse/feed_screen/feed_page_app.dart';
import 'package:UniVerse/find_screen/find_page_app.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/login_screen/login_app.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CustomAppBar extends StatelessWidget {
  final int i;

  const CustomAppBar({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (size.width >= 600) {
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        return Row(
          children: [
            const Spacer(),
            SizedBox(
              width: size.width / 1.5,
              child: UniverseAppBar(i: i,),
            ),
            const Spacer()
          ],
        );
      } else {
        return Row(
          children: [
            const Spacer(),
            SizedBox(
              width: size.width / 2,
              child: UniverseAppBar(i: i,),
            ),
            const Spacer()
          ],
        );
      }
    }
    else {
      return UniverseAppBar(i: i);
    }
  }
}

class UniverseAppBar extends StatelessWidget {
  final int i;

  const UniverseAppBar({super.key, required this.i});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
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
                _navigateToScreenHome(context);
              },
            ),
            GButton(
              icon: Icons.search_rounded,
              text: 'Procurar',
              onPressed: (){
                _navigateToScreenFind(context);
              },
            ),
            GButton(
              icon: Icons.newspaper_rounded,
              text: 'Feed',
              onPressed: () {
                _navigateToScreenFeed(context);
              },
            ),
            GButton(
              icon: Icons.person_rounded,
              text: 'Área Pessoal',
              onPressed: (){
                _navigateToScreenPersonal(context);
              },
            ),
            GButton(
              icon: Icons.settings_rounded,
              text: 'Definições',
              onPressed: (){
                _navigateToScreenSettings(context);
              },
            ),
          ],
          selectedIndex: i,
        ),
      ),
    );
  }

  void _navigateToScreenHome(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppHomePage()));
  }

  void _navigateToScreenFeed(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FeedPageApp()));
  }

  void _navigateToScreenSettings(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => FaqApp()));
  }

  void _navigateToScreenPersonal(BuildContext context) {
    Authentication.userIsLoggedIn
    ?Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppPersonalPage()))
       : Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageApp()));
  }

  void _navigateToScreenFind(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FindPageApp()));
  }
}