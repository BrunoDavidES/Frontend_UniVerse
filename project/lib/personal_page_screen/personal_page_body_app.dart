import 'package:UniVerse/components/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/menu_card.dart';

class PersonalPageBodyApp extends StatelessWidget {
  const PersonalPageBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/area.png", scale:6),
        automaticallyImplyLeading: false,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
    body: Column(
          children: <Widget>[
            SizedBox(height:10),
            Container(
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

              height: 175,
              width: size.width-30,
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
                ],
              ),
            ),
            Container(
              height: size.height-350,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.all(10),
                  itemCount:10,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 15,);
                  },
                  itemBuilder: (context, index) {
                    return MenuCard(text: 'Test', icon: Icons.account_circle_outlined);
                  }
              ),
            ),
          ],
      ),
    );
  }
}



