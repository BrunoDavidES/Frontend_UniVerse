import 'package:UniVerse/components/app/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

class EditProfilePageApp extends StatelessWidget {
  const EditProfilePageApp({super.key});

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
                cPrimaryLightColor.withOpacity(0.65),
                Colors.green.withOpacity(0.65),
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
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top:5, right: 10),
                    child: Text(
                          "Cancelar".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: cHeavyGrey
                          ),
                        ),
                  ),
                ),
                InkWell(
                  child:
                      Padding(
                        padding: const EdgeInsets.only(top:5, right: 5),
                        child: Text(
                          "Concluir".toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: cHeavyGrey
                          ),
                        ),
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




