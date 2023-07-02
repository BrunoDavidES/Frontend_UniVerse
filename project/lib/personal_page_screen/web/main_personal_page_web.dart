import 'dart:convert';
import 'dart:io';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/components/personal_web_card.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/utils/camera/camera_screen.dart';
import 'package:UniVerse/utils/report/report_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../components/web/web_menu.dart';
import '../../utils/users/user_data.dart';


class MainPersonalPageWeb extends StatefulWidget {
  const MainPersonalPageWeb({super.key});

  @override
  State<MainPersonalPageWeb> createState() => _PublishEventScreenState();
}

class _PublishEventScreenState extends State<MainPersonalPageWeb> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String job = User.getJob();
    return Row(
        children: [
          WebMenu(width: size.width/9, height: size.height/1.25,),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/titles/area.png", scale: 4.5,)
                  ),
                ),
                PersonalWebCard(size: size),
              ]
          ),

        ]
    );


  }
}