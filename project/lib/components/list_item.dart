import 'package:flutter/material.dart';
import '../../consts.dart';

class ListItem extends StatelessWidget {
  final String title;
  final Function press;
  const ListItem({
    super.key, required this.title, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Text(
              title.toUpperCase(),
              style: TextStyle(
                color: cHeavyGrey,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            ),
          ],
        ),
      ),
    );
  }
}