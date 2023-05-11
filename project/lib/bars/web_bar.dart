import 'package:UniVerse/components/default_button_simple.dart';
import 'package:UniVerse/faq_screen/faq_web.dart';
import 'package:flutter/material.dart';
import '../Components/default_button.dart';
import '../consts.dart';
import '../main_screen/components/body.dart';
import '../main_screen/homepage_web.dart';

class CustomWebBar extends StatelessWidget {
  const CustomWebBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 30,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Image.asset("assets/web/combo_logo.png",
            scale: 6,
            alignment: Alignment.center,),
          const SizedBox(width: 5),
          const Spacer(),
          DefaultButtonSimple(
            text: "Início",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WebHomePage()),
              );
            },
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Notícias",
            press: () {},
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Eventos",
            press: () {},
            height: 20,
          ),
          DefaultButtonSimple(
            text: "Ajuda",
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQWebPage()),
              );
            },
            height: 20,
          ),
          DefaultButton(text: "Área Pessoal",
              press: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Body()),
                );
              }),
        ],

      ),
    );
  }
}