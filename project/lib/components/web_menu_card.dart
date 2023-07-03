import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../consts/color_consts.dart';

class WebMenuCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? press;

  const WebMenuCard({
    Key? key,
    required this.text,
    required this.icon,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: press, // Call the press function when the card is tapped
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 75,
          width: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: cDirtyWhite,
            border: Border.all(
              color: cPrimaryLightColor,
              width: 2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
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
              Icon(icon, size: 30, color: cPrimaryColor),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: cHeavyGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}