
import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';

class LinksBodyApp extends StatelessWidget {

  const LinksBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: cDirtyWhiteColor,
          title: Image.asset("assets/app/links.png", scale: 5),
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {Navigator.pop(context);},
                    color: cDarkBlueColorTransparent);
              }
          ),
          leadingWidth: 20,
          elevation: 0,
          pinned: true,
          stretch: true,
          expandedHeight: 200,
          flexibleSpace: const FlexibleSpaceBar(
            stretchModes: [
              StretchMode.zoomBackground,
            ],
            background: Image(
                image: AssetImage("assets/web/FCT-NOVA.jpg"),
                fit: BoxFit.fill
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 14,
              (BuildContext context, int index) {
                if (index == 0)
                  return ListButtonSimple(tobeBold: true,
                      text: "Clip",
                      press: () {});
                else if (index == 1)
                  return ListButtonSimple(tobeBold: true,
                      text: "Moodle",
                      press: () {});
                else if (index == 2)
                  return ListButtonSimple(tobeBold: true,
                      text: "Departamento de Ciências Sociais Aplicadas",
                      press: () {});
                else if (index == 3)
                  return ListButtonSimple(tobeBold: true,
                      text: "Website FCT", press: () {});
                else if (index == 4)
                  return ListButtonSimple(tobeBold: true,
                      text: "Website UNL",
                      press: () {});
                else if (index == 5)
                  return ListButtonSimple(tobeBold: true,
                      text: "Guia de Cursos", press: () {});
              }
          ),
        ),
      ],
      )
    );
  }

}