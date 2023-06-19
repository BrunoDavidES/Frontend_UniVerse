
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class WebMenuCard extends StatelessWidget {
  final String text;
  final String description;
  final IconData icon;
  const WebMenuCard({
    super.key, required this.text, required this.icon, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            height: 150,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: cDirtyWhite,
              border: Border.all(
                color: cPrimaryLightColor,
                width:2,
              ),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                //tileMode:TileMode.mirror,
                colors: [
                  cDirtyWhiteColor,
                  cDirtyWhite,
                  cPrimaryOverLightColor.withOpacity(0.4),
                  cPrimaryLightColor.withOpacity(0.5)
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size:30, color: cPrimaryColor),
                Padding(
                  padding: const EdgeInsets.only(top:5),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 15,
                        color: cHeavyGrey,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 15,
                      color: cHeavyGrey,
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}