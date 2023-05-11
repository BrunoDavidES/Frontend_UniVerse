import 'package:UniVerse/consts.dart';
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
              color: cPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "E aqui que encontras o que precisas a qualquer altura\nBem vindo!!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.75),
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
                    Container(
                      padding: const EdgeInsets.all(5),
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: cDarkBlueColorTransparent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "mais".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
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