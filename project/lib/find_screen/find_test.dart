import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/findTest/left_side.dart';
import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

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
                  padding: const EdgeInsets.only(left: 50, bottom: 50, top: 30),
                  child: SizedBox(
                    height: size.height,
                    width: size.width/4.5,
                    child: const LeftSide(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: (size.width - size.width/1.1), bottom: 50, top: 10),
                  child: const RightSide(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}