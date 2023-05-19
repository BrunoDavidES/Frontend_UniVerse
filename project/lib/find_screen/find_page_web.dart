import 'package:UniVerse/find_screen/find_test.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/bodyAbout.dart';

class FindWebPage extends StatelessWidget {
  FindWebPage({super.key});
  ScrollController yourScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
                  child: Container(                //Zona das do Find
                    height: size.height*1.2,
                    width: size.width,
                    color: cDirtyWhite,
                    child:
                      const findWebTest(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: size.height * 1.15),
                  child: Container(                  //Zona do About
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