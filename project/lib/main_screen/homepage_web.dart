import 'package:UniVerse/main_screen/components/body.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../find_screen/maps_screen/map_page_web.dart';
import '../consts/color_consts.dart';
import 'components/about_bottom.dart';
import 'components/about_bottom_body.dart';
import 'components/newsMain.dart';

class WebHomePage extends StatelessWidget {
  WebHomePage({super.key});
  @override
  ScrollController yourScrollController = ScrollController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Column(
              children: <Widget>[
                Container(                    //Zona principal
                  height: size.height-75,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/web/foto.jpg"),
                        colorFilter: ColorFilter.mode(cBlackOp, BlendMode.darken),
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
                  height: size.height/1.15,
                  width: size.width,
                  color: cDirtyWhite,
                  child: mainNews(width: size.width, height: size.height/1.15,),
                ),
                Container(                //Zona do google Maps
                  height: size.height*0.8,
                  width: size.width,
                  color: cDirtyWhite,
                  child: mainPageMap(),
                ),
                Container(                 //Zona de Download da app
                  //height: size.height/2,
                  //width: size.width,
                  color: cDirtyWhite,
                  //child: mainNews(),
                ),
                BottomAbout(size: size),
              ]
          ),
        ),
      )
    );
  }
}
