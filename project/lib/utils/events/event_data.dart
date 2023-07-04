import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:UniVerse/consts/color_consts.dart';
import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../consts/api_consts.dart';
import '../authentication/auth.dart';
import '../users/user_data.dart';

class Event {
  //static List<Event> events = <Event>[];
  static Map<String, Event> organizedEvents = Map<String, Event>();
  static int numEvents = 0;
  String? id;
  String? title;
  String? location;
  //authorName no Datastore
  String? planner;
  String? capacity;
  String? department;
  String? startDate;
  String? endDate;
  String? isPaid;

  String? description;
  String? urlToImage;

  Event(
      this.id,
      this.title,
      this.location,
      this.planner,
      this.capacity,
      this.department,
      this.startDate,
      this.endDate,
      this.isPaid,
      this.description,
      this.urlToImage,
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
    String eventsUrl = '/feed/numberOf/Event';
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
    }
    return response.statusCode;
    //return 200;
  }


  static bool areCompliant(title, startDate, location, capacity, description) {
    return title.isNotEmpty && startDate.isNotEmpty && location.isNotEmpty && capacity.isNotEmpty;
  }

  static Future<int> post(title, startDate, endDate, isPublic, isItPaid, location, capacity, description, Uint8List thumbnail) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    final http.Response response = await http.post(
      Uri.parse(postEventUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'title': title,
        'startDate': startDate,
        //pode ser null
        'endDate': location,
        //pode ser null
        'isPublic': isPublic,
        'capacity': capacity,
        //pode ser null
        'isItPaid': isItPaid,
      }),
    );

    if (response.statusCode == 200) {
      var id = response.body;
      organizedEvents.addAll({id:Event("", title, location, "", capacity, "", startDate, endDate, "", "", "")});
      final ref = FirebaseStorage.instance.ref().child("Events/$id");
      ref.putData(thumbnail, SettableMetadata(contentType: 'image/jpeg'));
      /*var txt = File("/$id.txt");
        txt.writeAsString(description, encoding: utf8);
        ref.putFile(txt, SettableMetadata(contentEncoding: 'text/plain;charset=UTF-8'));*/
      return 200;
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoge();
    }
    return response.statusCode;
  }

  static Future<int> edit(id, title, startDate, endDate, department, isPublic, isItPaid, location, capacity, description, File? thumbnail) async {
    String url = '$magikarp/feed/edit/Event/$id';

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final http.Response response = await http.patch(
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
        'isPublic': isPublic,
        'capacity': capacity,
        'isItPaid': isItPaid,
      }),
    );

    if (response.statusCode == 200) {
      String id = response.body;
      organizedEvents[id] = Event("", title, location, "", capacity, "", startDate, endDate, "", "", "");
      return 200;
    }
    return response.statusCode;
  }
  /*
  var response = await Event.edit(title, startDate, endDate, isPublic, isItPaid, location, capacity, description, thumbnail);
  //meter validacao internet
        if (response == 200) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Sucesso!",
                  descriptions: "Já recebemos a tua submissão. Após validação, constará no feed da UniVerse!",
                  text: "OK",
                );
              }
          );
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens sessão iniciada.",
                  text: "OK",
                );
              }
          );
        } else if (response==403) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens permissões para esta operação.",
                  text: "OK",
                );
              }
          );
        } else if (response==400) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                  text: "OK",
                );
              }
          );
        }else {
            context.go("/error");
        }
      }
    setState(() {
      isLoading = false;
    });
  }
   */

  static Future<int> delete(String id) async {
    String url = '$magikarp/feed/delete/Event/$id';
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    final http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      organizedEvents.remove(id);
      return 200;
    }
    return response.statusCode;
  }
  /*
  var response = await Event.delete(title, startDate, endDate, isPublic, isItPaid, location, capacity, description, thumbnail);
  //meter validação internet
        if (response == 200) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Sucesso!",
                  descriptions: "Já recebemos a tua submissão. Após validação, constará no feed da UniVerse!",
                  text: "OK",
                );
              }
          );
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens sessão iniciada.",
                  text: "OK",
                );
              }
          );
        } else if (response==403) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não tens permissões para esta operação.",
                  text: "OK",
                );
              }
          );
        } else if (response==400) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                  text: "OK",
                );
              }
          );
        }else {
            context.go("/error");
        }
      }
    setState(() {
      isLoading = false;
    });
  }

   */

  static List<Event> events = [
    Event("Evento", "Este é apenas um teste, you see?", "Sala 127 Ed2", "31 de maio 2023", "Edifício 7", "yes", "4", "", "", "", "",),
    Event("Evento", "Este é apenas um teste, you see?", "Sala 127 Ed2", "31 de maio 2023", "Edifício 7", "31 de maio 2023", "Edifício 7", "ninf", "10", "", "",),
    Event("Evento", "Este é apenas um teste, you see?", "Sala 127 Ed2", "31 de maio 2023", "Edifício 7", "31 de maio 2023", "Edifício 7", "ninf", "11",  "", "",)
  ];

  static List<String> images = [
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/edsa2023.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/profnova23.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/05/destaque-fct_act_verao_3.png",
    "https://www.fct.unl.pt/sites/default/files/imagecache/l440/imagens/noticias/2023/06/esports.png"
  ];
}