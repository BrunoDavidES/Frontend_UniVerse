import 'package:UniVerse/main_screen/components/body.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import 'package:go_router/go_router.dart';
import '../components/faq_item.dart';
import '../find_screen/maps_screen/map_page_web.dart';
import '../consts/color_consts.dart';
import 'components/about_bottom.dart';
import 'components/about_bottom_body.dart';
import 'components/newsMain.dart';

class WebHomePage extends StatelessWidget {
  WebHomePage({super.key});

  ScrollController yourScrollController = ScrollController();
  bool showbtn = false;
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    return Scaffold(
      backgroundColor: cDirtyWhite,
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
                WelcomeArea(size: size, yourScrollController: yourScrollController),
                Container(                //Zona das noticias
                  height: 700,
                  width: size.width,
                  color: cDirtyWhite,
                  child: MainNews(width: size.width, height: size.height/1.15,),
                ),
                Container(                //Zona do google Maps
                  height: size.height*0.9,
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
                      Image.asset("assets/titles/faq.png", scale: 4,)
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
                      onPressed: () => context.go('/help'),
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
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    FAQbox(
                      question: 'O que é a UniVerse?',
                      answer: 'A UniVerse é a mais recente plataforma que vai trazer uma nova vida ao campus da tua faculdade!\nCom todo o Universo da FCT NOVA num só lugar, vai ser mais fácil encontrares informações básicas, avisos, eventos, organizares o teu dia-a-dia e muito mais. Junta-te já ao Universo!',
                    ),
                    FAQbox(
                      question: 'É necessário criar uma conta?',
                      answer: 'Sim. Estamos a trabalhar no sentido de tornar a UniVerse mais acessível para ti e, por isso, por enquanto, é necessário registares-te. Insere o teu e-mail institucional, nome e uma palavra-passe e está feito. Fazes agora parte da UniVerse!',
                    ),
                    FAQbox(
                      question: 'Onde posso saber mais sobre a UniVerse?',
                      answer: 'Não queremos que o Universo esteja distante. Podes saber mais na nossa página de Ajuda.',
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
                          Image.asset("assets/images/bigger_dot.png", scale: 3.5,),
                          Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: SelectableText(
                              "Instala já a nossa aplicação!".toUpperCase(),
                              style: const TextStyle(
                                color: cPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                fontSize: 35
                              ),
                            ),
                          ),
                          Image.asset("assets/images/bigger_dot.png", scale: 3.5,),
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
                          Image.asset("assets/images/icon_no_white.png", scale: 4),
                          const SizedBox(width: 10),
                          Image.asset("assets/web/qr.png", scale: 25),
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

class WelcomeArea extends StatelessWidget {
  const WelcomeArea({
    super.key,
    required this.size,
    required this.yourScrollController,
  });

  final Size size;
  final ScrollController yourScrollController;

  @override
  Widget build(BuildContext context) {
    return Container(                    //Zona principal
      height: size.height-75,
      width: size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/welcome_photo.jpg"),
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
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Todo o universo, num só lugar!".toUpperCase(),
              style: const TextStyle(
                fontSize: 70,
                color: cDirtyWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Com a UniVerse, o dia-a-dia no campus nunca foi tão fácil!\nSê bem-vindo!",
              style: TextStyle(
                fontSize: 20,
                color: cDirtyWhite,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  yourScrollController.animateTo(650,
                      duration: Duration(seconds: 1), curve: Curves.easeIn);
                },
                child: FittedBox(
                  child: Container (
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cDarkBlueColorTransparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          " ver mais".toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: cDirtyWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
          SizedBox(height: 150,)
        ],
      ),
    );
  }
}
