import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../info_screen/universe_info_body_app.dart';
import '../utils/users/users_local_storage.dart';

class PersonalPageApp extends StatelessWidget {
  const PersonalPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leadingWidth: 20,
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {Navigator.pop(context);},
                  color: cDarkBlueColorTransparent);
            }
        ),
        title: Text(
          "THIS IS A TEMPORARY PERSONAL PAGE"
        ),
        backgroundColor: cDirtyWhiteColor,

      ),
    );
  }
}
