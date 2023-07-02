import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class PersonalWebCard extends StatelessWidget {
  const PersonalWebCard({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              cPrimaryLightColor,
              Colors.green,
            ],
          ),
          //color: cPrimaryLightColor,
          boxShadow: [ BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0,0),
          ),
          ]
      ),
      height: 140,
      width: size.width/4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:10, left: 13, bottom:5),
            child: Text(
              "Olá, Francisco",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, bottom:5),
            child: Text(
              "Aluno",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: cDirtyWhiteColor,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "Departamento de Informática",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: cDirtyWhite.withOpacity(0.75),
                fontSize: 20,
              ),
            ),
          ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(3),
                child: Image.asset("assets/dot.png", scale: 2, alignment: Alignment.bottomRight),
              ),
            ],
          )
        ],
      ),
    );
  }
}