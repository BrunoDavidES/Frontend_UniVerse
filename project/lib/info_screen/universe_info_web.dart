import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/info_screen/universe_info_body_web.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:flutter/material.dart';
import '/bars/web_bar.dart';
import '/main_screen/components/about_bottom_body.dart';

class UniverseInfoWeb extends StatelessWidget {
  const UniverseInfoWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ScrollController yourScrollController = ScrollController();
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Scrollbar(
      thumbVisibility: true, //always show scrollbar
      thickness: 8, //width of scrollbar
      interactive: true,
      radius: const Radius.circular(20), //corner radius of scrollbar
      scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
      controller: yourScrollController,
      child: SingleChildScrollView(
        controller: yourScrollController,
        child: Container(
          color: cDirtyWhite,
          child: Stack(
            children: <Widget> [
              Padding(
                padding: EdgeInsets.only(top: size.height/7),
                child: Container(                //Zona da Info
                  height: size.height/1.5+size.height/3,
                  width: size.width,
                  color: cDirtyWhite,
                  child: const UniverseInfoBodyWeb(),
                ),
              ),
              Container(
                color: cDirtyWhite,
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomWebBar(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}