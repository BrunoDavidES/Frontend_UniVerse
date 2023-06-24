import 'package:UniVerse/main_screen/components/body.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/faq_item.dart';
import '../find_screen/maps_screen/map_page_web.dart';
import '../consts/color_consts.dart';

class Error500Web extends StatelessWidget {
  Error500Web({super.key});

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomWebBar(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height/8,),
              Image.asset("assets/app/ufo.png",scale: 8,),
              Text("Ups!",
                style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,),
              SizedBox(height: 5,),
              Text("Parece que perdemos contacto com o Universo. Dá-nos alguns minutos para que possamos voltar a estar em órbita.",
                textAlign: TextAlign.center,)
            ],
          ),
        )
          ],
        ),
    );
  }
}
