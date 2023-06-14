import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../components/faq_item.dart';
import 'list_faqs.dart';

class FaqApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 20,
        leading: Builder(
          builder: (context) {
            return IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {Navigator.pop(context);},
                color: cDarkBlueColor);
          }
        ),
        title: Image.asset('assets/app/faq_title.png', scale: 5),
        backgroundColor: cDirtyWhiteColor,

      ),

      body: Container(                //Zona das Perguntas
        color: Colors.white,
        child: ListView(
          children: const [
            FAQlist(question: 'FAQ:', starts: true,),
          ],
        ),
      ),
    );
  }
}
