import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

class WelcomeBodyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: Column(
        children: <Widget>[
          /*Padding(
            padding: const EdgeInsets.only(right: 255, top: 40),
            child: Text(
              "Sobre Nós"
            )
          ),
          Padding(
              padding: const EdgeInsets.only(right: 283),
              child: Text(
                  "Ajuda"
              )
          ),*/
          Padding(
            padding: const EdgeInsets.only(top:60, bottom: 20),
            child:Image.asset("assets/app/logo_no_reference_no_white.png", scale: 3.5),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Image.asset("assets/app/logo_nova_horiz.png", scale: 12),
          ),
          Container(
            child: Stack(
              children: <Widget>[

                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.facebook_rounded,
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.facebook_rounded,)
                ),
              ],
            )

          ),
          /*Padding(
            padding: const EdgeInsets.only(right:20),
            child: Text(
                "Finalmente, tão perto!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryColor,
                )
            ),
          ),*/
        ],
      ),
    );

  }
}