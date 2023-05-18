import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/maps_screen/map_page_web.dart';
import 'package:flutter/material.dart';

import '../maps_screen/maps_for_web.dart';

class RightSide extends StatefulWidget {
  const RightSide({super.key});
  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        height: size.height/1.5,
        width: size.width/1.8,
        color: cDirtyWhite,
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: cPrimaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: const MapsPageWeb(),
            ),
          ),
        ),
      ),
    );
  }
}