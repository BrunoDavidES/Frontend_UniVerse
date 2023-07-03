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
          Image.asset("assets/app/logo_nova_horiz.png", scale: 12),
       Spacer(),

       Container(
         padding: EdgeInsets.all(15),
         width: size.width,
         height: size.height/3,
         decoration: BoxDecoration(
           color: cHeavyGrey.withOpacity(0.4),
           borderRadius: BorderRadius.circular(15)
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text(
                   "HOJE NA FCT",
                   style: TextStyle(
                     color: cDirtyWhite,
                     fontWeight: FontWeight.bold,
                     fontSize: 20
                   ),
                 ),
                 Spacer(),
                 Text(
                   "${DateTime.now().day}-${DateTime.now().month}",
                   style: TextStyle(
                       color: cDirtyWhite,
                       fontSize: 20
                   ),
                 ),
               ],
             )
           ],
         ),
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


                    ),
                  ),
       ),
        ],
      ),
    );

  }
}