import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/maps_screen/map_page_web.dart';
import 'package:flutter/material.dart';

import '../maps_screen/maps_for_web.dart';

class RightSide extends StatefulWidget {
  const RightSide({super.key});
  @override
  State<RightSide> createState() => _RightSideState();
}

class _RightSideState extends State<RightSide> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var containerHeight = size.height/1.5;
    var containerWidth = size.width/1.5;
    return Container(
        height: containerHeight,
        width: containerWidth,
        color: cDirtyWhite,
            child: /*Container(
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: cHeavyGrey),
                  boxShadow: [ BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0,0),
                  ),
                  ],
                  image: DecorationImage(
                      image: AssetImage("assets/web/foto.jpg"),
                      fit: BoxFit.cover),
                  color: cDirtyWhiteColor
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Spacer(),
                      IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {},
                          color: cDirtyWhiteColor),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left:15, bottom:5),
                    child: Text(
                      "Divisão de Eventos e Apoio ao Estudante Diplomado",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          fontSize: 25
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: double.infinity,
                    height: containerHeight/2.25,
                    decoration: BoxDecoration(
                        boxShadow: [ BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                          offset: const Offset(0,0),
                        ),
                        ],
                        borderRadius: BorderRadius.circular(15),
                        color: cDirtyWhiteColor.withOpacity(0.60)
                    ),
                    child:SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "OLÁ",
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),*/
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: cPrimaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: MapsPageWeb()),
              ),

            /*child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: cPrimaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: MapsPageWeb()),
            )*/
      /*Container(
        height: containerHeight,
        width: containerWidth,
        color: cDirtyWhite,
        child: Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: cHeavyGrey),
              boxShadow: [ BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0,0),
              ),
              ],
              color: cDirtyWhiteColor
          ),
          child: /*Row(
            children: [

            ],
          ),
        ),*/*/
       /* Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                color: cPrimaryLightColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(child: MapsPageWeb()),*/
      );
  }
}