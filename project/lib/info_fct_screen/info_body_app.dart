import 'package:UniVerse/components/url_launchable_icon_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/url_launchable_item.dart';

class FCTinfoBodyApp extends StatelessWidget {
  const FCTinfoBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          focal: Alignment.bottomCenter,
          focalRadius: 0.1,
          center: Alignment.bottomCenter,
          radius: 0.65,
          colors: [
            cPrimaryOverLightColor,
            cDirtyWhiteColor,
          ],
        ),
        //color: cPrimaryLightColor,

      ),
    child: Column(
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Faculdade de Ciências e Tecnologia",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:5, bottom:40),
            child: Text(
              "Universidade Nova de Lisboa",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Faculdade de Ciências e Tecnologia\n2829-516 Caparica\nPortugal",
            ),
          ),
          InkWell(
            onTap: () {
              launchUrl(Uri.parse("tel://212948300"));
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text(
                "Telefone: (+351) 212 948 300\nFax: (+351) 212 954 461",
              ),
            ),
          ),
        ],
      ),
     Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "FCT NOVA nas redes:"
            ),
            UrlLaunchableItem(text: "Website", url: "https://www.fct.unl.pt/", color: Colors.black),
            UrlLaunchableItem(text: "Facebook", url: "https://www.facebook.com/fct.nova", color: Colors.black),
            UrlLaunchableItem(text: "Instagram", url: "https://www.instagram.com/fctnova", color: Colors.black),
            UrlLaunchableItem(text: "Twitter", url: "https://www.twitter.com/FCTNOVA", color: Colors.black),
            UrlLaunchableItem(text: "LinkedIn", url: "https://pt.linkedin.com/school/nova-school-of-science-and-technology/", color: Colors.black),
            UrlLaunchableItem(text: "Youtube", url: "https://www.youtube.com/user/fctunltv", color: Colors.black),
            UrlLaunchableItem(text: "Whatsapp", url: "https://wa.me/+351924008005", color: Colors.black),
            ],
          ),
],
    ),
    );
  }
}