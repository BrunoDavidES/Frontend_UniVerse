
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
          title: Image.asset("assets/app/departments.png", scale: 5),
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
                  return ListButtonSimple(
                      text: "Edifício I",tobeBold: true,
                      press: () {});
                else if (index == 1)
                  return ListButtonSimple(
                      text: "Edifício II",tobeBold: true,
                      press: () {});
                else if (index == 2)
                  return ListButtonSimple(
                      text: "Edifício III",tobeBold: true,
                      press: () {});
                else if (index == 3)
                  return ListButtonSimple(
                      text: "Edifício IV",tobeBold: true,
                      press: () {});
                else if (index == 4)
                  return ListButtonSimple(
                      text: "Edifício V", tobeBold: true,press: () {});
                else if (index == 5)
                  return ListButtonSimple(
                      text: "Departamental",tobeBold: true,
                      press: () {});
                else if (index == 6)
                  return ListButtonSimple(
                      text: "Edifício VII", tobeBold: true,press: () {});
                else if (index == 7)
                  return ListButtonSimple(
                      text: "Edifício VIII",tobeBold: true,
                      press: () {});
                else if (index == 8)
                  return ListButtonSimple(
                      text: "Edifício IX",tobeBold: true,
                      press: () {});
                else if (index == 9)
                  return ListButtonSimple(
                      text: "Edifício X",tobeBold: true,
                      press: () {});
                else if (index == 10)
                  return ListButtonSimple(
                      text: "Edifício VI",tobeBold: true, press: () {});
                else if (index == 11)
                  return ListButtonSimple(
                      text: "CENIMAT", tobeBold: true,press: () {});
                else if (index == 12)
                  return ListButtonSimple(
                      text: "Divisão de Química",tobeBold: true, press: () {});
                else if (index == 13)
                  return SizedBox(height: 70);
              }
          ),
        ),
      ],
      )
    );
  }

}