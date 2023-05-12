import 'package:UniVerse/faq_screen/faq_item.dart';
import 'package:UniVerse/faq_screen/list_faqs.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/bodyAbout.dart';

class FAQWebPage extends StatelessWidget {
  const FAQWebPage({super.key});
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
          child: SingleChildScrollView(
              child: Container(
                color: cDirtyWhite,
                child: Column(
                  children: <Widget> [
                    Container(
                      height: size.height/7.5,
                      color: cDirtyWhite,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomWebBar(),
                        ],
                      ),
                    ),
                    Container(                //Zona das Perguntas
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