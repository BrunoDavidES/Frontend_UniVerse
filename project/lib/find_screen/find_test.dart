import 'package:UniVerse/find_screen/findTest/left_side.dart';
import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class findWebTest extends StatefulWidget {
  const findWebTest({super.key});

  @override
  State<findWebTest> createState() => _FindWebTest();
}

class _FindWebTest extends State<findWebTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          LeftSide(),
          RightSide(),
        ],
      ),
    );
  }
}