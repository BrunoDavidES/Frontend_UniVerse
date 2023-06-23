import 'package:UniVerse/find_screen/find_test.dart';
import 'package:UniVerse/personal_page_screen/personal_page_web_body.dart';
import 'package:UniVerse/personal_page_screen/profile/profile_screen_web.dart';
import 'package:UniVerse/report_screen/report_screen_web.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/personal_web_card.dart';
import 'package:UniVerse/components/custom_shape.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../main_screen/components/about_bottom_body.dart';
import 'calendar_screen_web.dart';


class PersonalPageWeb extends StatelessWidget {
  final int i;
  PersonalPageWeb({super.key, required this.i});
  ScrollController yourScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: cDirtyWhite,
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
                  if(i==1)
                    ClipPath(
                      clipper: CustomShape(),
                      child: Container(
                        height: size.height / 2.25,
                        width: size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              cPrimaryColor,
                              cPrimaryLightColor,
                              cPrimaryOverLightColor
                            ],
                          ),
                        ),
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height/7),
                    child: Column(
                      children: [
                       if(i==1)
                         ProfileScreenWeb(),
                       if(i==2)
                          CalendarScreenWeb(),
                       // ReportScreenWeb(),
                        BottomAbout(size: size,),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Column(
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