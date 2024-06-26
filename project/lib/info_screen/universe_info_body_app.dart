import 'package:UniVerse/components/url_launchable_icon_item.dart';
import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
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
                padding: const EdgeInsets.only(top:5, left: 15, right: 15, bottom: 30),
                child: Text(
                  "Desenvolvida por 5 estudantes de Engenharia Informática da FCT NOVA, no âmbito de Atividade de Desenvolvimento Curricular, a UniVerse permite que todos presentes na faculdade possam agora encontrar informações úteis, saber mais sobre notícias e eventos, organizar a sua agenda e muito mais na sua área pessoal.\nAlém disso, para quem tem interesse em conhecer mais sobre a FCT, continua a ser possível explorar o universo da nossa faculdade, limitadamente.\nJunta-te ao Universo!",
                  textAlign: TextAlign.justify,
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
              UrlLaunchableItem(text: "Website", url: "https://www.universe-fct.oa.r.appspot.com", color: Colors.black,),
              UrlLaunchableItem(text: "Instagram", url: "https://www.instagram.com/universe.fct", color: Colors.black,),
                //UrlLaunchableIconItem(icon: const Icon(Icons.account_circle_outlined), text: "Instagram", url: "https://www.instagram.com/universe.fct", color: Colors.black,)),
             SizedBox(height: 10,),
              Text(
                  "Brevemente disponível em iOS"
                ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: Text(
                      "Powered by:",
                          style: TextStyle(
                        color: cHeavyGrey,
                    )
                    ),
                  ),
                  Image.asset("assets/images/capi_logo.png",scale:6,),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      "© 2023 Todos os direitos reservados",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
  ]
      )
      );
  }
}