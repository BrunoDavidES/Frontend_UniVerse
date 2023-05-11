import 'package:flutter/material.dart';
import '../consts.dart';

class ListButtonSimple extends StatelessWidget {
  final String text;
  final Function press;
  const ListButtonSimple({
    super.key, required this.text, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: cPrimaryLightColor,
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left:20)
        ),
        onPressed: (){
          press();
        },
        child:
            Text(
                text,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: cHeavyGrey,
                )
            ),
        ),
    );
  }
}