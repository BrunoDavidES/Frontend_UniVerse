import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

class EventData {
  //String? id;
  String? title;
  String? description;
  String? urlToImage;
  String? date;
  String? location;
  String? planner;
  String? plannerPhoto;
  Color? color;

  EventData(
      this.title,
      this.description,
      this.urlToImage,
      this.date,
      this.location,
      this.planner,
      this.plannerPhoto,
      this.color,
      );

  static List<EventData> events = [
    EventData("", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf", "https://ae.fct.unl.pt/wp-content/uploads/2020/04/aefct-logo-color.png", cPrimaryLightColor),
    EventData("", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf", "https://ninf.ae.fct.unl.pt/img/logo.png", cHeavyGrey),
    EventData("", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf", "https://ae.fct.unl.pt/wp-content/uploads/2020/04/aefct-logo-color.png", cPrimaryLightColor),

  ];
}