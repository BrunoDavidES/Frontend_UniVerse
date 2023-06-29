import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import '../personal_page_screen/profile/profile_page_app.dart';

class PersonalAppCard extends StatelessWidget {
  const PersonalAppCard({
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
              //Colors.green,
              //Colors.orange
              Colors.red
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
      height: 175,
      width: size.width-30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:10, left: 13, bottom:5),
            child: Text(
              "Olá, Capi",
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
            padding: const EdgeInsets.only(left: 18, bottom:5),
            child: Text(
              "Departamento de Informática",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: cDirtyWhite.withOpacity(0.75),
                fontSize: 20,
              ),
            ),
          ),
          Spacer(),
          Row(

            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/app/dot.png", scale: 2, alignment: Alignment.bottomRight),
              ),
            ],
          )
        ],
      ),
    );
  }
}