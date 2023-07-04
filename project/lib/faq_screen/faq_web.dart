import 'package:UniVerse/components/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../find_screen/findTest/right_side.dart';
import '../main_screen/components/about_bottom_body.dart';
import 'aux2_faq.dart';
import 'aux_faq.dart';

class FAQWebPage extends StatelessWidget {
  TextEditingController? controller;

  FAQWebPage({super.key});
  ScrollController yourScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 900;
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
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    focal: Alignment.centerRight,
                    focalRadius: 0.1,
                    center: Alignment.centerRight,
                    radius: 0.40,
                    colors: [
                      cPrimaryOverLightColor,
                      cDirtyWhite,
                    ],
                  ),
                ),
                child: Stack(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.only(top: size.height/7),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:50, top: 20),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Image.asset("assets/titles/help.png", scale: 4,)
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 100, left: 50, bottom: 10, top: 30),
                            child: Container(
                              color: Colors.transparent,
                              child: isSmallScreen? FAQWebPageAux2(): FAQWebPageAux(),
                            ),
                          ),
                          BottomAbout(size: size)
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