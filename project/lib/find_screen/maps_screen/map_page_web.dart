import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/maps_screen/maps_for_web.dart';
import 'package:flutter/material.dart';

import 'maps_page_app.dart';
class mainPageMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
      decoration: const BoxDecoration(
        color: cDirtyWhite,
      ),
      child: Column(
        children: <Widget> [
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, left: 30),
                child: Text(
                  "Google Maps",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 25, right: 30),
                  child: Text(
                    "Ver mais",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            child: Divider(
              thickness: 2,
              color: cBlackOp,
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: cPrimaryLightColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const MapsPageWeb(),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
