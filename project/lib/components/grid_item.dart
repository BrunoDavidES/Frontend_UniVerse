import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class GridBox extends StatelessWidget {
  final String text;
  final IconData icon;
  const GridBox({
    super.key, required this.text, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
            height: 10,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                //tileMode:TileMode.mirror,
                colors: [
                  cDirtyWhite,
                  cPrimaryOverLightColor.withOpacity(0.5)
                ],
              ),
                //color: cDirtyWhite,
                border: Border.all(
                  color: cPrimaryLightColor,
                  width:2,
                ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size:40, color: cPrimaryColor),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 15,
                      color: cHeavyGrey
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}