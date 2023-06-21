import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/findTest/left_side.dart';
import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../main_screen/components/about_bottom_body.dart';

class findWebTest extends StatefulWidget {
  const findWebTest({super.key});

  @override
  State<findWebTest> createState() => _FindWebTestState();
}

class _FindWebTestState extends State<findWebTest> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height:size.height+size.height/3+size.height/7,
        color: cDirtyWhite,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:50, top: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/web/findTitle.jpeg", scale: 4,)
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30),
                  child: SizedBox(
                    height: size.height-size.height/7,
                    width: size.width/4.5,
                    child: const LeftSide(),
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.all(50.0),
                 child: RightSide(),
               ),
              ],
            ),
            BottomAbout(size: size,),
          ],
        ),
      ),
    );
  }
}