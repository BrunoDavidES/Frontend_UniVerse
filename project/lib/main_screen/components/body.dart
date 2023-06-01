import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Finalmente, tão perto!".toUpperCase(),
            style: const TextStyle(
              fontSize: 80,
              color: cDirtyWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "E aqui que encontras o que precisas a qualquer altura\nBem vindo!!",
            style: TextStyle(
              fontSize: 20,
              color: cDirtyWhite,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FittedBox(
              child: Container (
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: cDarkBlueColorTransparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: <Widget>[

                    Text(
                      " ver mais".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: cDirtyWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}