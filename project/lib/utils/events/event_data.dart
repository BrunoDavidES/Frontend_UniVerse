import 'dart:convert';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../consts/api_consts.dart';

class Event {
  static List<Event> events = <Event>[];
  String? id;
  String? title;
  String? description;
  String? urlToImage;
  String? location;
  String? planner;
  String? capacity;
  String? department;
  String? startDate;
  String? endDate;
  String? isPaid;

  Event(
      this.title,
      this.description,
      this.urlToImage,
      this.location,
      this.planner,
      this.isPaid,
      );

  Event.fromJson(Map<String, dynamic> json ) {
    var properties = json['properties'];
    id = properties['id']['value'];
    title = properties['title']['value'];
    planner = properties['authorName']['value'];
    capacity= properties['capacity']['value'];
    department=properties['department']['value'];
    endDate =properties['endDate']['value'];
    location=properties['location']['value'];
    startDate =properties['startDate']['value'];
    isPaid = properties['isItPaid']['value'];
    //date = 'Teste Data';//json['properties']['time_creation']['value'].toString();
    urlToImage = "https://www.fct.unl.pt/sites/default/files/imagens/pagina_inicial/banner/banner_15mai_6578_4.png";
    description="Olá";
    print(id);
    print(title);
    print(planner);
    print("OLÁ");
  }

  static Future<int> fetchEvents(int limit, int offset, Map<String, String> filters) async {
    /*String eventsUrl = '/feed/query/Event?limit=$limit&offset=$offset';
    final response = await http.post(
      Uri.parse(baseUrl + eventsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
       //'filters': {"validated_backoffice": "true"}
      }),
    );
    if(response.statusCode==200) {
      var decodedEvents = json.decode(response.body);
      print(decodedEvents);
      for (var decoded in decodedEvents) {
        events.add(Event.fromJson(decoded));
      }
      print("DONE");
    }
    print(response.statusCode);
    print("OLÁ");
    return response.statusCode;*/
    return 200;
  }

  /*static List<Event> events = [
    Event("", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf", "https://ae.fct.unl.pt/wp-content/uploads/2020/04/aefct-logo-color.png", cPrimaryLightColor),
    Event("", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf", "https://ninf.ae.fct.unl.pt/img/logo.png", cHeavyGrey),
    Event("", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf", "https://ae.fct.unl.pt/wp-content/uploads/2020/04/aefct-logo-color.png", cPrimaryLightColor),
  ];*/
}