import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/find_screen/maps_screen/maps_for_web.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  child:
                  Image.asset("assets/app/map.png", scale: 4,)
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                      color: cHeavyGrey,
                      fontSize: 30,
                    ),
                  ),
                  onPressed: () => context.go('/find'),
                  child: const Text("+", textAlign: TextAlign.right, style: TextStyle( color: cHeavyGrey, fontSize: 30)),
                ),
              ),
            ],
          ),
          const SizedBox(
            child: Divider(
              thickness: 2,
              color: cDarkLightBlueColor,
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
