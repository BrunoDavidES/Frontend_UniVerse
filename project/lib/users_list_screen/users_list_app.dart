import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/profile_screen/profile_page_app.dart';
import 'package:UniVerse/users_list_screen/users_list_screen_app.dart';
import 'package:flutter/material.dart';

class UsersListApp extends StatelessWidget {
  const UsersListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          UsersListScreenApp(),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:1),
          ),
        ],
      ),
    );
  }
}