import 'package:UniVerse/components/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../find_screen/findTest/right_side.dart';
import '../main_screen/components/about_bottom_body.dart';

class FAQWebPage extends StatelessWidget {
  FAQWebPage({super.key});
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:50, top: 20),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                child: Image.asset("assets/web/findTitle.jpeg", scale: 4,)
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 100, left: 100, bottom: size.height/3.48, top: 50),
                            child: Container(
                              color: cDirtyWhite,
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width/2.4,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: const [
                                        FAQlist(question: 'FAQ:', starts: true),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size.width/2.4,
                                    child: ListView(
                                      shrinkWrap: true,
                                      children: const [
                                        FAQlist(question: "Tem dúvidas? Fale connosco:", starts: false),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BottomAbout(size: size)
                        ],
                      ),
                    ),
                    Container(
                      color: cDirtyWhite,
                      child: const Column(
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