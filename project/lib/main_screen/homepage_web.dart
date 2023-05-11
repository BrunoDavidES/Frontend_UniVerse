import 'package:UniVerse/main_screen/components/body.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts.dart';
import 'components/bodyAbout.dart';
import 'components/newsMain.dart';

class WebHomePage extends StatelessWidget {
  const WebHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        child: SingleChildScrollView(
          child: Column(
              children: <Widget>[
                Container(                    //Zona principal
                  height: size.height-75,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/web/FCT-NOVA.jpg"),
                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.saturation),
                        fit: BoxFit.cover
                    ),
                    color: cDirtyWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const CustomWebBar(),
                      const Spacer(),
                      Body(),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
                Container(                //Zona das noticias
                  height: size.height,
                  width: size.width,
                  color: cDirtyWhite,
                  child: mainNews(),
                ),
                Container(                //Zona do google Maps
                  height: size.height*0.8,
                  width: size.width,
                  color: cDirtyWhite,
                  child: mainNews(),
                ),
                Container(                 //Zona de Download da app
                  height: size.height/2,
                  width: size.width,
                  color: cDirtyWhite,
                  child: mainNews(),
                ),
                Container(                  //Zona do About
                  height: size.height/3,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Spacer(),
                      BodyAbout(),
                      const Spacer(), const Spacer(), const Spacer(), const Spacer(),
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                )
              ]
          ),
        ),
      )
    );
  }
}