import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class ProfilePhoto extends StatelessWidget {
  final Uint8List? image;
  const ProfilePhoto({
    super.key, this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left:20),
      height: 140,
      width: 140,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: kIsWeb ?cDirtyWhite :cDirtyWhiteColor, width: 5),
          image: image!=null
          ?DecorationImage(
              fit: BoxFit.cover,
              image: MemoryImage(image!)
          )
              :DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/man.png")
          )
      ),
    );
  }
}