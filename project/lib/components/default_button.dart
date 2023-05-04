import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../consts.dart';
import '../main_screen/components/body.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  const DefaultButton({
    super.key, required this.text, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: cPrimaryColor,
          width: 3,
        )
      ),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: cDarkBlueColor,
            backgroundColor: cDirtyWhite,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
        ),
        onPressed: (){
          press();
        },
        child: Text(
          text,
        ),
      ),
    );
  }
}