
import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text(
              "Olá"
            ),
          )
        ],
      ),
    );

  }
}
