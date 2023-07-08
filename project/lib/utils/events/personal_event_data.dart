
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import '../authentication/auth.dart';
import 'package:http/http.dart' as http;

class CalendarEvent {
  static Map<String, List<Map<String, CalendarEvent>>> events = {
    "05-07-2023": [{"10":CalendarEvent("UNKNOWN ERROR", "10", "Teste", "Ninf", "loacti", "9:00", "23-07-2023")},{"11":CalendarEvent("bm", "11", "Teste", "Ninf", "loacti", "9:00", "23-07-2023")}]
  };
  String? authorUsername;
  String? id;
  String? title;
  String? department;
  String? location;
  String? hour;
  String? date;

  CalendarEvent(
      this.authorUsername,
      this.id,
      this.title,
      this.department,
      this.location,
      this.hour,
      this.date
      );

   CalendarEvent.fromJson(Map<String, dynamic> json) {
    var properties = json['properties'];
    id = properties['id']['value'];
    title = properties['title']['value'];
    authorUsername = properties['username']['value'];
    location = properties['location']['value'];
    department = properties['department']['value'];
    hour = properties['hours']['value'];
    date = properties['beginningDate']['value'];
  }

  static Future<int> fetchEvents(month, year) async {
    String token = await Authentication.getTokenID();

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    String query = "$month-$year";
    String eventsUrl = '$baseUrl/profile/personalEvent/monthly/$query';
    var response = await http.get(
      Uri.parse(eventsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if(response.statusCode==200) {
      var decodedEvents = json.decode(response.body);
      for (var decoded in decodedEvents) {
        var event = CalendarEvent.fromJson(decoded);
        events[event.date]?.add({event.id.toString():event});
      }
    } else if(response.statusCode == 401) {
      Authentication.userIsLoggedIn=false;
      Authentication.revoke();
    }
    return response.statusCode;
  }

  static bool areCompliant(title,location, date, hour) {
    return title.isNotEmpty && location.isNotEmpty && date.isNotEmpty && hour.isNotEmpty;
  }

  static Future<int> add(username, title, String? department, location, date, hour) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    String apiUrl = '$baseUrl/profile/personalEvent/add';
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'title': title,
        'username': username,
        "department": "Departamento de Teste",
        'beginningDate': date,
        'username': 'gab.silva',
        'hours': hour,
        'location': location
        }),
      );

     if (response.statusCode == 200) {
        if(events[date]!=null) {
          events[date]!.add({response.body.toString():CalendarEvent(username,response.body, title, department, location, hour, date)});
        } else {
          var toAdd = {date.toString():[{response.body.toString():CalendarEvent(username, response.body, title, department, location, hour, date)}]};
          events.addAll(toAdd);
        }
    } else if(response.statusCode == 401) {
       Authentication.userIsLoggedIn = false;
       Authentication.revoke();
     }
    return response.statusCode;
  }

  static Future<int> edit(id, title, location, date, hour) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final String apiUrl = '$baseUrl/profile/personalEvent/edit/$id';
    String username = UniverseUser.getUsername();
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'title': title,
        'username': UniverseUser.getUsername(),
        'beginningDate': date,
        'department': 'Departamento de Teste',
        'hours': hour,
        'location': location
      }),
    );

      if (response.statusCode == 200) {
        events[date]!.removeWhere((element) => element.containsKey(id.toString())==id.toString());
        if(events[date]!=null) {
          events[date]!.add({response.body.toString():CalendarEvent(username,response.body, title, "", location, hour, date)});
        } else {
          var toAdd = {date.toString():[{response.body.toString():CalendarEvent(username, response.body, title,"", location, hour, date)}]};
          events.addAll(toAdd);
        //events[date]!.add({id.toString(): CalendarEvent(username,response.body, title, "", location, hour, date)});
      } } else if(response.statusCode == 401) {
        Authentication.userIsLoggedIn = false;
        Authentication.revoke();
      }
      return response.statusCode;
  }

  static Future<int> delete(String id, String date) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final String apiUrl = '$baseUrl/profile/personalEvent/delete/$id';
    final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        events[date]?.removeWhere((element) => element.keys.first==id.toString());
     } else if(response.statusCode == 401) {
        Authentication.userIsLoggedIn = false;
        Authentication.revoke();
      }
      return response.statusCode;
  }


}