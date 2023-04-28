import 'package:flutter/material.dart';
import '../../consts.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final Function press;
  const MenuItem({
    super.key, required this.title, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Text(
          title,
          style: TextStyle(
            color: cDarkBlueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}