import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

class BodyAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: size.height/6,
                width: size.width/6,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/web/logoNovaBranco.png"),
                    fit: BoxFit.cover
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Text(
                    "FCT",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                height: size.height/6,
                width: size.width/6,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Largo da Torre\n2829-516,\nCaparica\n\n+351 21 294 8300",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: <Widget>[
              Container(
                height: size.height/6,
                width: size.width/6,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Eventos",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: <Widget>[
              Container(
                height: size.height/6,
                width: size.width/6,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Ajuda",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: <Widget>[
              Container(
                height: size.height/6,
                width: size.width/6,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Text(
                    "Sobre",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}