import 'package:UniVerse/components/personal_web_card.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/personal_page_screen//left_side.dart';
import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main_screen/components/about_bottom_body.dart';

class PersonalWebBody extends StatefulWidget {
  const PersonalWebBody({super.key});

  @override
  State<PersonalWebBody> createState() => PersonalWebBodyState();
}

class PersonalWebBodyState extends State<PersonalWebBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height:size.height+size.height/3+size.height/7,
        color: cDirtyWhite,
        child: Column(
          children: [
           Row(
             children: [
               Padding(
                 padding: const EdgeInsets.only(left: 15, top: 15, right: 15),
                 child: PersonalWebCard(size: size),
               ),
             ],
           ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: SizedBox(
                    height: size.height-size.height/7,
                    width: size.width/6,
                    child: const LeftSide(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: RightSide(),
                ),
              ],
            ),
            Spacer(),
            BottomAbout(size: size,),
          ],
        ),
      ),
    );
  }
}