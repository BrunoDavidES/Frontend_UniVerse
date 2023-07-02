import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/findTest/left_side.dart';
import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/web/find_list_item.dart';
import '../main_screen/components/about_bottom_body.dart';

class findWebTest extends StatefulWidget {
  const findWebTest({super.key});

  @override
  State<findWebTest> createState() => _FindWebTestState();
}

class _FindWebTestState extends State<findWebTest> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height:size.height+size.height/3+size.height/7,
        color: cDirtyWhite,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:50, top: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/web/findTitle.jpeg", scale: 4.5,)
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30),
                  child: SizedBox(
                    height: size.height-size.height/7,
                    width: size.width/4.5,
                    child:ListView(
                      children:  [
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.work_outline_rounded), name: "Serviços", i:0),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.local_phone), name: "Contactos", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.link_outlined), name: "Links", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.account_balance_outlined), name: "Departamentos", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.home_work_outlined), name: "Edifícios", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.restaurant_outlined), name: "Restaurantes", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.local_activity_outlined), name: "Núcleos", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.camera_alt_outlined), name: "Galeria", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.directions_bus), name: "Transportes", i:1),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom:5),
                              child: FindListItem(icon: Icon(Icons.person_search_outlined), name: "Pessoas", i:1),
                            ),
                            FindListItem(icon: Icon(Icons.rule_outlined), name: "Regras", i:1),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
               Padding(
                 padding: const EdgeInsets.all(50.0),
                 child: RightSide(),
               ),
              ],
            ),
            BottomAbout(size: size,),
          ],
        ),
      ),
    );
  }
}