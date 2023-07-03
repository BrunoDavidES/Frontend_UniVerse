import 'package:UniVerse/main_screen/components/about_bottom_body.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';

class BottomAbout extends StatelessWidget {
  const BottomAbout({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(                  //Zona do About
      height: 280,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.centerLeft,
          colors: [
            cPrimaryLightColor,
            cHeavyGrey,
          ],
        ),
        //color: cPrimaryLightColor,

      ),
      //color: cHeavyGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Spacer(),
          AboutBottomBody(),
          const Spacer(), const Spacer(), const Spacer(), const Spacer(),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}