import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class MyReadOnlyField extends StatelessWidget {
  final IconData icon;
  final String text;
  final String content;

  const MyReadOnlyField({
    super.key, required this.icon, required this.text, required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          Spacer(),
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