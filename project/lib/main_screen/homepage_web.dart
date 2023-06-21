import 'package:UniVerse/main_screen/components/body.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/faq_item.dart';
import '../find_screen/maps_screen/map_page_web.dart';
import '../consts/color_consts.dart';
import 'components/about_bottom.dart';
import 'components/about_bottom_body.dart';
import 'components/newsMain.dart';

class WebHomePage extends StatelessWidget {
  WebHomePage({super.key});
  @override
  ScrollController yourScrollController = ScrollController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Column(
              children: <Widget>[
                Container(                    //Zona principal
                  height: size.height-75,
                  width: size.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/web/foto.jpg"),
                        colorFilter: ColorFilter.mode(cBlackOp, BlendMode.darken),
                        fit: BoxFit.cover
                    ),
                    color: cDirtyWhite,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWebBar(),
                      const Spacer(),
                      Body(),
                      const Spacer(
                        flex: 2,
                      ),
                      /*Row(
                        children: [
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Image.asset("assets/web/logoNovaBranco.png", scale:9.5),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),
                Container(                //Zona das noticias
                  height: size.height/1.15,
                  width: size.width,
                  color: cDirtyWhite,
                  child: MainNews(width: size.width, height: size.height/1.15,),
                ),
                Container(                //Zona do google Maps
                  height: size.height*0.8,
                  width: size.width,
                  color: cDirtyWhite,
                  child: mainPageMap(),
                ),
                Container(
                  color: cDirtyWhite,
                  child: Container(
                      margin: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
                      color: cDirtyWhite,
                      child: Column(
                          children: <Widget>[
                      Row(
                      children: <Widget>[
                      Padding(
                      padding: const EdgeInsets.only(top: 10, left: 20),
                      child:
                      Image.asset("assets/web/faq_title.png", scale: 4,)
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                          color: cHeavyGrey,
                          fontSize: 30,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/help');
                      },
                      child: const Text("+", textAlign: TextAlign.right, style: TextStyle( color: cHeavyGrey, fontSize: 30)),
                    ),
                  ),
              ],
          ),
          const SizedBox(
            child: Divider(
              thickness: 2,
              color: cDarkLightBlueColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    FAQbox(
                      question: 'É necessário criar uma conta?',
                      answer: 'Não! \nSe és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito. \n',
                    ),
                    FAQbox(
                      question: 'É necessário criar uma conta?',
                      answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                    ),
                    FAQbox(
                      question: 'É necessário criar uma conta?',
                      answer: 'Não! Se és estudante, docente ou funcionário na FCT NOVA, então podes juntar-te já ao universo. Insere as tuas credenciais do clip e está feito.',
                    ),
            ]
                        ),
          ),
          ],
                  ),
                  ),
                ),
                Container(                 //Zona de Download da app
                  height: size.height*0.30,
                  width: size.width,
                  color: cDirtyWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 10),
                      child: Row(
                        children: [
                          const Spacer(),
                          Image.asset("assets/web/bigger_dot.png", scale: 3.5,),
                          Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: Text(
                              "Instala já a nossa aplicação!".toUpperCase(),
                              style: const TextStyle(
                                color: cPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 35
                              ),
                            ),
                          ),
                          Image.asset("assets/web/bigger_dot.png", scale: 3.5,),
                          const Spacer()
                        ],
                      ),

                ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Atualmente disponível para ANDROID™",
                          style: TextStyle(
                              color: cHeavyGrey,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              fontSize: 15
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Spacer(),
                          Image.asset("assets/icon_no_white.png", scale: 4),
                          const SizedBox(width: 10),
                          Image.asset("assets/web/Example.png", scale: 25),
                          const Spacer(),
                        ],
                      ),
            ]
                  ),
                ),
                BottomAbout(size: size),
              ]
          ),
        ),
      )
    );
  }
}
