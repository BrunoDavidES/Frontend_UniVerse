
import 'package:flutter/material.dart';
import '../consts/color_consts.dart';

class DefaultButton2 extends StatelessWidget {
  final double width;
  final String text;
  final Function press;
  const DefaultButton2({
    super.key, required this.text, required this.press, required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: cHeavyGrey.withOpacity(0.7),
          width: 2,
        )
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: cPrimaryLightColor,
            backgroundColor: cDirtyWhiteColor,
            padding: const EdgeInsets.symmetric(vertical: 20)
        ),
        onPressed: (){
          press();
        },
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: cDarkBlueColor
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}