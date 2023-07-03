
import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/utils/search/info.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';
import '../info_detail_screen.dart';

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
          title: Image.asset("assets/app/links.png", scale: 6),
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
            childCount: 5,
              (BuildContext context, int index) {
              final item = links[index];
              return ListButtonSimple(tobeBold: true,
                  text: item.keys.first,
                  press: () {
                launchUrl(Uri.parse(item.values.first),  mode: LaunchMode.externalApplication);
                  });
                /*if (index == 0)
                  return ListButtonSimple(tobeBold: true,
                      text: "Clip",
                      press: () async {
                        Uri toLaunch = Uri.parse("https://clip.fct.unl.pt");
                        var urllaunchable = await canLaunchUrl(toLaunch);
                        if (urllaunchable) {
                          await launchUrl(
                              toLaunch,
                              mode: LaunchMode.inAppWebView
                          );
                        }
                      });
                else if (index == 1)
                  return ListButtonSimple(tobeBold: true,
                      text: "Moodle",
                      press: () {
                        //https://moodle.fct.unl.pt/
                      });
                else if (index == 2)
                  return ListButtonSimple(tobeBold: true,
                      text: "Website FCT", press: () {
                    //https://www.fct.unl.pt/pt-pt
                      });
                else if (index == 3)
                  return ListButtonSimple(tobeBold: true,
                      text: "Website UNL",
                      press: () {
                    //https://www.unl.pt/
                      });
                else if (index == 4)
                  return ListButtonSimple(tobeBold: true,
                      text: "Guia de Cursos", press: () {
                    //https://guia.unl.pt/pt/2023/fct
                      });
                else if (index == 5)
                  return ListButtonSimple(tobeBold: true,
                      text: "AEFCT", press: () {
                        //https://ae.fct.unl.pt/
                      });
                else if (index == 6)
                  return SizedBox(height:70);*/
              }
          ),
        ),
      ],
      )
    );
  }

}