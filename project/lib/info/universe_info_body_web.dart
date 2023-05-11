import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

class UniverseInfoBodyWeb extends StatelessWidget {
  const UniverseInfoBodyWeb({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        color: cDirtyWhite,
      ),
      child: Column(
        children: <Widget>[
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "UniVerse ּ FCT NOVA",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                  ),
                ),
              ),
            ],
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  "Com a UniVerse, o dia-a-dia no campus torna-se mais agora mais fácil\n Tudo fica mais fácil oh yeah\nahahaha\nahahahah",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                  "Encontra e segue-nos:",
                style: TextStyle(
                  fontSize: 18
                ),
              ),
              SizedBox(
                width: size.width/18,
                child: const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: UrlLaunchableItem(icon: Icon(Icons.facebook), text: "Website", url: "https://www.fct.unl.pt/"),
                ),
              ),
              SizedBox(
                width: size.width/18,
                child: const Padding(
                  padding: EdgeInsets.only(),
                  child: UrlLaunchableItem(icon: Icon(Icons.facebook), text: "Facebook", url: "https://www.facebook.com/fct.nova"),
                ),
              ),
              SizedBox(
                width: size.width/18,
                child: const Padding(
                  padding: EdgeInsets.only(),
                  child: UrlLaunchableItem(icon: Icon(Icons.account_circle_outlined), text: "Instagram", url: "https://www.instagram.com/fctnova"),
                ),
              ),
              SizedBox(
                width: size.width/18,
                child: const Padding(
                  padding: EdgeInsets.only(),
                  child: UrlLaunchableItem(icon: Icon(Icons.account_circle_outlined), text: "Twitter", url: "https://www.twitter.com/FCTNOVA"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 40),
                child: Text(
                    "Brevemente disponível em IOS",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                ),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:10, bottom: 15),
                    child: Text(
                        "Powered by:",
                        style: TextStyle(
                          color: cHeavyGrey,
                          fontSize: 18,
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