import 'package:UniVerse/personal_page_screen/profile/profile_edit_screen.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import 'modify_password_screen.dart';

class ModifyPasswordPageWeb extends StatelessWidget {

  ModifyPasswordPageWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/3.5, height: size.height/2,
        child: ModifyPasswordScreen()
    );
  }
}