import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../consts/color_consts.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
class ListButtonSimple extends StatelessWidget {
  final String text;
  final Function press;
  final bool tobeBold;
  const ListButtonSimple({
    super.key, required this.text, required this.press, required this.tobeBold,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center :CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: cPrimaryLightColor,
              alignment: Alignment.center,
            ),
            onPressed: (){
              press();
            },
            child:
                Text(
                    text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: tobeBold ? FontWeight.bold :FontWeight.normal,
                        color: cHeavyGrey,
                    )
                ),
            ),
        ),
        if(kIsWeb)
        SizedBox(
          width: 150,
          child: Divider(
            thickness: 1,
            color: cHeavyGrey.withOpacity(0.2),
          ),
        )
      ],
    );
  }
}