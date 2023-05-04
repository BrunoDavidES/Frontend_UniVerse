import 'package:flutter/material.dart';
import 'package:UniVerse/consts.dart';

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
        child: ExpansionTile(
          title: Text(
              question,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              )),
          trailing: const Icon(Icons.arrow_drop_down_circle_rounded),
          controlAffinity: ListTileControlAffinity.trailing,
          backgroundColor: cDarkLightBlueColor,
          collapsedBackgroundColor: cPrimaryOverLightColor,
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
          childrenPadding: EdgeInsets.all(5),
        ),
      ),
    );
  }
}