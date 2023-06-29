import 'package:UniVerse/components/app/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../../components/custom_shape.dart';
import 'edit_profile_page_app.dart';

class ProfilePageApp extends StatelessWidget {
  const ProfilePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
          title: Image.asset("assets/app/profile_title.png", scale:6),
          leadingWidth: 20,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {Navigator.pop(context);},
                    color: cDirtyWhiteColor);
              }
          ),
          backgroundColor: cPrimaryColor,
          titleSpacing: 15,
          elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
              },
            icon: Icon(Icons.edit_outlined, color: cDirtyWhiteColor,),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 240,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child:
                      Container(
                        height: 130,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            cPrimaryColor,
                            cPrimaryLightColor,
                            cPrimaryOverLightColor
                          ],
                        ),
                        ),
                      ),

                  ),
                  Row(
                    children: [

                      Column(
                        children: [
                          Container(
                            height: 140,
                            width: 140,
                            margin: EdgeInsets.only(left:10, top: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: cDirtyWhiteColor, width: 5),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/man.png")
                              )
                            ),
                          ),
                          Text("Bruno David",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("bm.david",
                            style: TextStyle(
                              fontSize: 15,
                              color: cHeavyGrey
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 90,),
                            Text("Aluno",
                            style: TextStyle(
                              fontSize: 18,
                              color: cHeavyGrey
                            )),
                            SizedBox(height: 5),
                            Text("Presidente de Núcleo",
                                style: TextStyle(
                                fontSize: 15,
                                color: cHeavyGrey
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
              ],
            ),
          )
        ],
      )
    );
  }
}




