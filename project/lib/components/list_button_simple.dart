import 'package:flutter/material.dart';
import '../consts/color_consts.dart';

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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: tobeBold ? FontWeight.bold :FontWeight.normal,
                        color: cHeavyGrey,
                    )
                ),
            ),
        ),
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