
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:UniVerse/find_screen/info_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';

class ServicesBodyApp extends StatelessWidget {

  const ServicesBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: cDirtyWhiteColor,
          title: Image.asset("assets/app/services.png", scale: 6),
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
            childCount: 15,
              (BuildContext context, int index) {
                if (index == 0)
                  return ListButtonSimple(
                      text: "Divisão Académica", tobeBold: true, press: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDetailScreen(Article.news[0])));
                  });
                else if (index == 1)
                  return ListButtonSimple(
                      text: "Divisão de Acompanhamento de Parcerias",
                      tobeBold: true,
                      press: () {});
                else if (index == 2)
                  return ListButtonSimple(
                      text: "Divisão de Apoio à Formação Avançada",
                      tobeBold: true,
                      press: () {});
                else if (index == 3)
                  return ListButtonSimple(
                      text: "Divisão de Apoio Geral",tobeBold: true, press: () {});
                else if (index == 4)
                  return ListButtonSimple(
                      text: "Divisão de Apoio Técnico",tobeBold: true, press: () {});
                else if (index == 5)
                  return ListButtonSimple(
                      text: "Divisão de Comunicação e Relações Exteriores",
                      tobeBold: true,
                      press: () {});
                else if (index == 6)
                  return ListButtonSimple(
                      text: "Divisão de Documentação e Cultura",tobeBold: true, press: () {});
                else if (index == 7)
                  return ListButtonSimple(
                      text: "Divisão de Eventos e Apoio ao Estudante Diplomado",
                      tobeBold: true,
                      press: () {});
                else if (index == 8)
                  return ListButtonSimple(
                      text: "Divisão de Infraestruturas Informáticas",
                      tobeBold: true,
                      press: () {});
                else if (index == 9)
                  return ListButtonSimple(
                      text: "Divisão de Planeamento e Gestão de Qualidade",
                      tobeBold: true,
                      press: () {});
                else if (index == 10)
                  return ListButtonSimple(
                      text: "Divisão de Recursos Financeiros", tobeBold: true,
                      press: () {});
                else if (index == 11)
                  return ListButtonSimple(
                      text: "Divisão de Recursos Humanos", tobeBold: true,
                      press: () {});
                else if (index == 12)
                  return ListButtonSimple(
                      text: "Divisão de Relações Internacionais", tobeBold: true,
                      press: () {});
                else if (index == 13)
                  return ListButtonSimple(
                      text: "Gabinete de Apoio à Direção",tobeBold: true, press: () {});
                else if (index == 14)
                  return SizedBox(height: 70);
              }
          ),
        ),
      ],
      )
    );
  }

}