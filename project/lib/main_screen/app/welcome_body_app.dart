

import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/info_fct_screen/info_app.dart';
import 'package:flutter/material.dart';

import '../../components/list_item.dart';

class WelcomeBodyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pad;
    Size size = MediaQuery.of(context).size;
    if(size.width>=600) {
      if(MediaQuery.of(context).orientation==Orientation.landscape)
      pad=size.width/3.9;
      else pad = size.width/5.5;
    }
    else pad=0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top:60, bottom: 20),
            child:Image.asset("assets/app/logo_no_reference_no_white.png", scale: 3.5),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Image.asset("assets/app/logo_nova_horiz.png", scale: 12),
          ),
       Spacer(),
       Padding(
         padding: EdgeInsets.only(bottom:80, right: pad),
         child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 50,
                        decoration: BoxDecoration(
                          color: cDarkBlueColorTransparent,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: TextButton(
                          onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FCTinfoApp()));},
                          child:
                            Icon(
                                Icons.info_outline,
                              color: Colors.white,
                              size:25
                            ),
                        ),
                        /*Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /*Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(
                                    "Redes Sociais FCT NOVA:",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    )
                                )
                            ),*/

                            ListItem(
                              title: "Facebook",
                              press: () {},
                            ),
                            ListItem(
                              title: "Instagram",
                              press: () {},
                            ),
                            ListItem(
                              title: "Twitter",
                              press: () {},
                            ),
                            ListItem(
                              title: "LinkedIn",
                              press: () {},
                            ),
                            ListItem(
                              title: "Whatsapp",
                              press: () {},
                            ),
                          ],
                        )*/

                    ),
                  ),
       ),
          /*Padding(
            padding: const EdgeInsets.only(right:20),
            child: Text(
                "Finalmente, tão perto!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: cPrimaryColor,
                )
            ),
          ),
          */
        ],
      ),
    );

  }
}