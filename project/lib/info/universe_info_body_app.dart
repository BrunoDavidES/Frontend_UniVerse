import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

class UniverseInfoBodyApp extends StatelessWidget {
  const UniverseInfoBodyApp({super.key});

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
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "UniVerse ּ FCT NOVA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "Com a UniVerse, o dia-a-dia no campus torna-se mais agora mais fácil\n Tudo fica mais fácil oh yeah\nahahaha\nahahahah",
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Encontra e segue-nos:"
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left:135),
                child: UrlLaunchableItem(icon: const Icon(Icons.facebook), text: "Website", url: "https://www.fct.unl.pt/"),
              ),
              Padding(
                padding: const EdgeInsets.only(left:135),
                child: UrlLaunchableItem(icon: const Icon(Icons.facebook), text: "Facebook", url: "https://www.facebook.com/fct.nova"),
              ),
              Padding(
                padding: const EdgeInsets.only(left:135),
                child: UrlLaunchableItem(icon: const Icon(Icons.account_circle_outlined), text: "Instagram", url: "https://www.instagram.com/fctnova"),
              ),
              Padding(
                padding: const EdgeInsets.only(left:135, bottom: 40),
                child: UrlLaunchableItem(icon: const Icon(Icons.account_circle_outlined), text: "Twitter", url: "https://www.twitter.com/FCTNOVA"),
              ),
              Text(
                  "Brevemente disponível em iOS"
                ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:10),
                    child: Text(
                      "Powered by:",
                          style: TextStyle(
                        color: cHeavyGrey,
                    )
                    ),
                  ),
                  Image.asset("assets/icon_no_white.png",scale:5),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}