import 'package:UniVerse/components/url_launchable_icon_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

class FCTinfoBodyApp extends StatelessWidget {
  const FCTinfoBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
        color: cDirtyWhiteColor,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Text(
              "Telefone: (+351) 212 948 300\nFax: (+351) 212 954 461",
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
            Padding(
              padding: const EdgeInsets.only(top: 10, left:135),
              child: UrlLaunchableIconItem(icon: const Icon(Icons.facebook), text: "Website", url: "https://www.fct.unl.pt/"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:135),
              child: UrlLaunchableIconItem(icon: const Icon(Icons.facebook), text: "Facebook", url: "https://www.facebook.com/fct.nova"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:135),
              child: UrlLaunchableIconItem(icon: const Icon(Icons.account_circle_outlined), text: "Instagram", url: "https://www.instagram.com/fctnova"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:135),
              child: UrlLaunchableIconItem(icon: const Icon(Icons.account_circle_outlined), text: "Twitter", url: "https://www.twitter.com/FCTNOVA"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:135),
              child:UrlLaunchableIconItem(icon: const Icon(Icons.account_circle_outlined), text: "LinkedIn", url: "https://pt.linkedin.com/school/nova-school-of-science-and-technology/"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:135),
              child: UrlLaunchableIconItem(icon: const Icon(Icons.web), text: "Youtube", url: "https://www.youtube.com/user/fctunltv"),
            ),
            Padding(
              padding: const EdgeInsets.only(left:135),
              child: UrlLaunchableIconItem(icon: const Icon(Icons.web), text: "Whatsapp", url: "https://wa.me/+351924008005"),
            ),
            ],
          ),
],
    ),
    );
  }
}