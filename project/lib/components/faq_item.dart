import 'dart:math';

import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

class FAQbox extends StatelessWidget {
  final String question;
  final String answer;
  const FAQbox({
    super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.center,
                //tileMode:TileMode.mirror,
                colors: [
                  cPrimaryOverLightColor.withOpacity(0.5),
                  cDirtyWhite,
                  cDirtyWhiteColor,
                ],
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: cPrimaryLightColor,
                width:2,
              )
          ),
          child: ExpansionTile(
            title: Text(
                question,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            controlAffinity: ListTileControlAffinity.trailing,
            backgroundColor: cDarkLightBlueColor,
            textColor: Colors.white,
            iconColor: Colors.white60,
            collapsedIconColor: cHeavyGrey,
            collapsedTextColor: cHeavyGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            children: [
              Text(
                  answer,
                  style: TextStyle(
                    color: Colors.white,
                  )
              ),
            ],
            childrenPadding: EdgeInsets.all(10),
          ),
        ),
      ),
    );
  }
}