

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
              gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.center,
                //tileMode:TileMode.mirror,
                colors: [
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                )),
            controlAffinity: ListTileControlAffinity.trailing,
            backgroundColor: cDarkLightBlueColor,
            textColor: Colors.white,
            collapsedIconColor: cHeavyGrey,
            iconColor: cDirtyWhiteColor,
            collapsedTextColor: cHeavyGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            childrenPadding: const EdgeInsets.all(10),
            children: [
              Text(
                  answer,
                  style: const TextStyle(
                    color: Colors.white,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}