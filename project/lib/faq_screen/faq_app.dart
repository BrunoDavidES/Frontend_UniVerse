import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

import 'faq_item.dart';

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
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () {Navigator.pop(context);},
                color: cDarkBlueColor);
          }
        ),
        title: Image.asset('assets/app/faq_title.png', scale: 5),
        backgroundColor: cDirtyWhiteColor,

      ),
      body: ListView(
        children: [
          FAQbox(
            question: 'É necessário criar uma conta?',
            answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
          ),
        ],
      ),
    );
  }
}
