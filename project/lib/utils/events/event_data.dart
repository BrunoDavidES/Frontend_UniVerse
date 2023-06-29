import 'dart:convert';
import 'dart:math';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../consts/api_consts.dart';
import '../../tester/utils/FirebaseAuthentication.dart';

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
    urlToImage = images[Random().nextInt(images.length)];
    description="Olá";
    print(id);
    print(title);
    print(planner);
    print("OLÁ");
  }

  static Future<int> fetchEvents(String limit, String offset, Map<String, String> filters) async {
    final String apiUrl = '$feedsUrl/query/Event';

    String token = await FirebaseAuthentication.getIdToken();
    if(token.isEmpty) {
      return 403;
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(filters);

    final Uri uri = Uri.parse(apiUrl);
    final Map<String, String> queryParameters = {
      if (limit.isNotEmpty) 'limit': limit,
      if (offset.isNotEmpty) 'offset': offset,
    };

    try {
      final http.Response response = await http.post(
          uri.replace(queryParameters: queryParameters),
          headers: headers,
          body: requestBody
      );

      if (response.statusCode == 200) {
        var decodedEvents = json.decode(response.body);
        print(decodedEvents);
        for (var decoded in decodedEvents) {
          events.add(Event.fromJson(decoded));
        }
        print("DONE");
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return 500;
    }
  }

  static List<String> images = [
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/edsa2023.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/profnova23.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/05/destaque-fct_act_verao_3.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/esports.png"
  ];
}