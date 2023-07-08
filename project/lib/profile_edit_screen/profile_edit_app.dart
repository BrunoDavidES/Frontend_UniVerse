import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/profile_edit_screen/profile_edit_screen.dart';
import 'package:UniVerse/profile_screen/profile_page_app.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';

class ProfileEditApp extends StatelessWidget {
  final UniverseUser user;
  const ProfileEditApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ProfileEditScreen(data: user),
          Container(
            alignment: Alignment.bottomCenter,
            child:CustomAppBar(i:3),
          ),
        ],
      ),
    );
  }
}