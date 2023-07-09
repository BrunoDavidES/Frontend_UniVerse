import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../main_screen/components/about_bottom.dart';

class UniverseInfoBodyWeb extends StatelessWidget {
  const UniverseInfoBodyWeb({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height+size.height/3+size.height/7,
        width: size.width,
          color: cDirtyWhite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left:50, top: 20),
              child: Container(
                  alignment: Alignment.centerLeft,
                  child: Image.asset("assets/titles/about_us.png", scale: 4.5,)
              ),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 30),
                  child: SizedBox(
                    height: size.height/1.5-size.height/7,
                    width: size.width/3.5,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/icon_no_white.png", scale: 3),
                        ),
                        SizedBox(height: 15),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: cPrimaryOverLightColor,
                                width:2
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: cDirtyWhiteColor
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:10),
                                child: Text("Já disponível para ANDROID",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold
                                )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset("assets/web/android.png", scale: 12),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 300,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: cPrimaryOverLightColor,
                                  width:2
                              ),
                              borderRadius: BorderRadius.circular(15),
                              color: cDirtyWhiteColor
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:10),
                                child: Text("Brevemente disponível para iOS",
                                    style: TextStyle(
                                      color: cHeavyGrey,
                                        fontWeight: FontWeight.bold
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Image.asset("assets/web/ios.png", scale: 27, color: cHeavyGrey),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
               Column(
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
                          Container(
                            width: size.width-size.width/3.5-100,
                            child: Padding(
                              padding: const EdgeInsets.only(top:5, left: 15, right: 15, bottom: 30),
                              child: Text(
                                "Desenvolvida por 5 estudantes de Engenharia Informática da FCT NOVA, no âmbito de Atividade de Desenvolvimento Curricular, a UniVerse permite que todos presentes na faculdade possam agora encontrar informações úteis, saber mais sobre notícias e eventos, organizar a sua agenda e muito mais na sua área pessoal.\nAlém disso, para quem tem interesse em conhecer mais sobre a FCT, continua a ser possível explorar o universo da nossa faculdade, de forma limitada.\nJunta-te ao Universo!",
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
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
                              Image.asset("assets/images/capi_logo.png",scale:5.5,),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
              ],
            ),
            Spacer(),
            BottomAbout(size: size,),
            /*Column(
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
                    child: UrlLaunchableItem(text: "Website", url: "https://www.fct.unl.pt/", color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width/18,
                  child: const Padding(
                    padding: EdgeInsets.only(),
                    child: UrlLaunchableItem(text: "Facebook", url: "https://www.facebook.com/fct.nova", color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width/18,
                  child: const Padding(
                    padding: EdgeInsets.only(),
                    child: UrlLaunchableItem(text: "Instagram", url: "https://www.instagram.com/fctnova", color: Colors.black),
                  ),
                ),
                SizedBox(
                  width: size.width/18,
                  child: const Padding(
                    padding: EdgeInsets.only(),
                    child: UrlLaunchableItem(text: "Twitter", url: "https://www.twitter.com/FCTNOVA", color: Colors.black,),
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
        ),*/
      ],
      ),
    ),
    );
  }
}