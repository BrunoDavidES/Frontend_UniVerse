import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';
import '../../../Components/default_button.dart';
import 'menu_Item.dart';


class CustomWebBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
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
          SizedBox(width: 5),
          Spacer(),
          MenuItem(
              title: "Início",
              press: () {},
          ),
          MenuItem(
            title: "Notícias",
            press: () {},
          ),
          MenuItem(
            title: "Eventos",
            press: () {},
          ),
          MenuItem(
            title: "Ajuda",
            press: () {},
          ),
          DefaultButton(text: "Área Pessoal", press: (){}),
        ],

      ),
    );
  }
}