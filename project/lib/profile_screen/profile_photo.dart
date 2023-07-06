import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: 140,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kIsWeb ?cDirtyWhite :cDirtyWhiteColor, width: 5),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/man.png")
          )
      ),
    );
  }
}