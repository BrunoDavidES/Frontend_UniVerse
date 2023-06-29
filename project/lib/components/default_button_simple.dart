import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../consts/color_consts.dart';

class DefaultButtonSimple extends StatelessWidget {
  final String text;
  final Function press;
  final double height;
  final Color color;
  const DefaultButtonSimple({
    super.key, required this.text, required this.press, required this.height, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var horizPadding;
    if(kIsWeb)
      horizPadding = 20.0;
    else
      horizPadding = 10.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: cPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: horizPadding, vertical: height)
        ),
        onPressed: (){
          press();
        },
        child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color
            )
        ),
      ),
    );
  }
}