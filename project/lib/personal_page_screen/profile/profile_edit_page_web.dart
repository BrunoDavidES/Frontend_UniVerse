import 'package:UniVerse/personal_page_screen/profile/profile_edit_screen.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';

class ProfileEditPageWeb extends StatelessWidget {
  UniverseUser? data;

  ProfileEditPageWeb({super.key, this.data});


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width/2, height: size.height/1.25,
        child: ProfileEditScreen(data: data!)
        );
  }
}