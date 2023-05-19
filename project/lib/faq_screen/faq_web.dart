import 'package:UniVerse/faq_screen/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/bodyAbout.dart';

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
                      padding: EdgeInsets.only(top: size.height/6, left: size.width/4),
                      child: Container(                //Zona das Perguntas
                        height: size.height,
                        width: size.width/2,
                        color: cDirtyWhite,
                        child: ListView(
                          children: const [
                            FAQlist(question: 'FAQ:'),
                            FAQlist(question: "Tem dúvidas? Fale connosco:"),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height),
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
                        children: const <Widget>[
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