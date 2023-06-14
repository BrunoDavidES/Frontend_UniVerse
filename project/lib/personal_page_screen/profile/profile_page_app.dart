import 'package:UniVerse/components/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import 'edit_profile_page_app.dart';

class ProfilePageApp extends StatelessWidget {
  const ProfilePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(left:10, top:40, bottom: 10, right: 10),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                cPrimaryLightColor,
                //Colors.green,
                //Colors.orange
                Colors.red
              ],
            ),
            //color: cDirtyWhiteColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
            ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                children: [
                  IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {Navigator.pop(context);},
                      color: cDirtyWhiteColor.withOpacity(0.75)),
                  Image.asset("assets/app/profile_title.png", scale: 7,),
                ],
              ),
            Row(
              children: [
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProfilePageApp()));
                  },
                  child: Row(
                    children: [
                      Text(
                          "Editar".toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: cDirtyWhite.withOpacity(0.85)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Icon(Icons.edit_outlined, color: cDirtyWhite.withOpacity(0.85),),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}




