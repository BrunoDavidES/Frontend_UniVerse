import 'dart:convert';
import 'dart:math';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../consts/api_consts.dart';
import '../../login_screen/functions/auth.dart';

class Event {
  //static List<Event> events = <Event>[];
  static int numEvents = 0;
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
    urlToImage = images[Random().nextInt(images.length)];
    description="Olá";
    print(id);
    print(title);
    print(planner);
    print("OLÁ");
  }

  static Future<int> fetchEvents(int limit, int offset, Map<String, String> filters) async {
    /*String eventsUrl = '/feed/numberOf/Event';
    var response;
    if(numEvents == 0) {
      response = await http.post(
        Uri.parse(baseUrl + eventsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      if(response.statusCode==200) {
        numEvents = json.decode(response.body);
        print(numEvents);
      }
      else return 500;
    }
    eventsUrl = '/feed/query/Event?limit=$limit&offset=$offset';
    response = await http.post(
      Uri.parse(baseUrl + eventsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(filters),
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

  Future<int> postEvent(String title, String startDate, String endDate, String department, String isPublic, String isItPaid, String location, String capacity) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty)
      return 401;
        final http.Response response = await http.post(
          Uri.parse(postEventUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': token,
          },
          body: jsonEncode({
            'title': title,
            'startDate': startDate,
            'endDate': location,
            'department': department,
            //pode ser null
            'isPublic': isPublic,
            'capacity': capacity,
            //pode ser null
            'isItPaid': isItPaid,
          }),
        );

        if (response.statusCode == 200) {
          final String id = response.body;
          return 200;
        }
        return response.statusCode;
  }

  Future<int> editEvent(String id, String title, String startDate, String endDate, String department, String isPublic, String isItPaid, String location, String capacity) async {
    String url = '$magikarp/feed/edit/Event/$id';
    String token = await Authentication.getTokenID();
    if(token.isEmpty)
      return 403;

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'title': title,
        'startDate': startDate,
        'endDate': endDate,
        'location': location,
        'department': department,
        //pode ser null
        'isPublic': isPublic,
        'capacity': capacity,
        //pode ser null
        'isItPaid': isItPaid,
      }),
    );

    if (response.statusCode == 200) {
      final String id = response.body;
      return 200;
    }
    return response.statusCode;
  }

  Future<int> deleteEvent(String id) async {
    String url = '$magikarp/feed/delete/Event/$id';
    String token = await Authentication.getTokenID();
    if(token.isEmpty)
      return 403;

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final String id = response.body;
      return 200;
    }
    return response.statusCode;
  }

  static List<Event> events = [
    Event("Evento", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf"),
    Event("Evento", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf",),
    Event("Evento", "Este é apenas um teste, you see?", "https://www.fct.unl.pt/sites/default/files/imagecache/l740/imagens/noticias/2023/05/queima2023fct.png", "31 de maio 2023", "Edifício 7", "ninf",),
  ];

  static List<String> images = [
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/edsa2023.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/profnova23.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/05/destaque-fct_act_verao_3.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/esports.png"
  ];
}