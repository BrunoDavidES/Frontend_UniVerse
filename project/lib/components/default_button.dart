import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../consts.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function press;
  const DefaultButton({
    super.key, required this.text, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: cDarkBlueColor,
            backgroundColor: cDirtyWhite,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20)
        ),
        onPressed: (){},
        child: Text(
          text,
        ),
      ),
    );
  }
}