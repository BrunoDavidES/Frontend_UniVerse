import 'package:flutter/material.dart';
import '../consts.dart';

class DefaultButtonSimple extends StatelessWidget {
  final String text;
  final Function press;
  const DefaultButtonSimple({
    super.key, required this.text, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: TextButton(
        style: TextButton.styleFrom(
            foregroundColor: cPrimaryColor,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20)
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