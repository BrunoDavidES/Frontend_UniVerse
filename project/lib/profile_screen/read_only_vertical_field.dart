import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class MyReadOnlyVerticalField extends StatelessWidget {
  final IconData icon;
  final String text;
  final String content;
  const MyReadOnlyVerticalField({
    super.key, required this.icon, required this.text, required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10, top: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: cHeavyGrey),
              SizedBox(width: 5,),
              Text(
                text,
                style: TextStyle(
                    fontSize: 15,
                    color: cHeavyGrey
                ),
              ),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            width: 450,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: cDirtyWhiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: cHeavyGrey,
                    width: 2
                )
            ),
            child: Text(
              content,
              style: TextStyle(
                  fontSize: 15,
                  color: cHeavyGrey
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}