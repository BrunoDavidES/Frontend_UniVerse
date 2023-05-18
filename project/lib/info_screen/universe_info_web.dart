import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/info_screen/universe_info_body_web.dart';
import 'package:flutter/material.dart';
import '../bars/web_bar.dart';
import '../main_screen/components/bodyAbout.dart';

class UniverseInfoWeb extends StatelessWidget {
  const UniverseInfoWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Scrollbar(
      thumbVisibility: true, //always show scrollbar
      thickness: 8, //width of scrollbar
      interactive: true,
      radius: const Radius.circular(20), //corner radius of scrollbar
      scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
      child: SingleChildScrollView(
        child: Container(
          color: cDirtyWhite,
          child: Column(
            children: <Widget> [
              Container(
                height: size.height/7.5,
                color: cDirtyWhite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomWebBar(),
                  ],
                ),
              ),
              Container(                //Zona da Info
                height: size.height/1.4,
                width: size.width,
                color: cDirtyWhite,
                child: const UniverseInfoBodyWeb(),
              ),
              Container(                  //Zona do About
                height: size.height/3,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Spacer(),
                    BodyAbout(),
                    const Spacer(), const Spacer(), const Spacer(), const Spacer(),
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
    );
  }
}