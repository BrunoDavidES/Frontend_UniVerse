import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import 'list_button_simple.dart';

class FindListItem extends StatelessWidget {
  final Icon icon;
  final String name;
  const FindListItem({
    super.key, required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              //tileMode:TileMode.mirror,
              colors: [
                cDirtyWhite,
                cPrimaryOverLightColor.withOpacity(0.5)
              ],
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: cPrimaryLightColor,
              width:2,
            )
        ),
        child: ExpansionTile(
          leading: icon,
          title: Text(name),
          backgroundColor: cDirtyWhiteColor,
          textColor: Colors.black,
          iconColor: cPrimaryColor,
          collapsedIconColor: cPrimaryColor,
          collapsedTextColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          children: [
  ]
      ),
      ),
    );
  }
}