import 'package:UniVerse/personal_page_screen/profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';

class ProfileEditPageWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/2, height: size.height/1.25,
        child: ProfileEditScreen()
        );
  }
}