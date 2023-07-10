
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import '../authentication/auth.dart';
import 'package:http/http.dart' as http;

class CalendarEvent {
  static Map<String, List<CalendarEvent>> events = {};
  String authorUsername = '';
  String id = '';
  String title = '';
  String department = '';
  String location = '';
  String hour = '';
  String date = '';

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
    id = json['id'];
    title = json['title'];
    authorUsername = json['username'];
    location = json['location'];
    //department = json['department'];
    hour = json['hours'];
    date = json['beginningDate'];
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
        final event = CalendarEvent.fromJson(decoded);

        if (!events.containsKey(event.date)) {
          events[event.date] = [];
        }

        events[event.date]!.add(event);
      }
    } else if(response.statusCode == 401) {
      Authentication.userIsLoggedIn=false;
      Authentication.revoke();
    }
    print(response.body);
    print(response.statusCode);
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
        "department": "dep-informatica",
        'beginningDate': date,
        //'username': UniverseUser.getUsername(),
        'hours': hour,
        'location': location
      }),
    );

    if (response.statusCode == 200) {
      if(events[date]!=null) {
        //events[date]!.add({response.body.toString():CalendarEvent(username,response.body, title, department, location, hour, date)});
      } else {
        //var toAdd = {date.toString():[{response.body.toString():CalendarEvent(username, response.body, title, department, location, hour, date)}]};
        //events.addAll(toAdd);
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
        'department': 'dep-informatica',
        'hours': hour,
        'location': location
      }),
    );

    if (response.statusCode == 200) {
      //events[date]!.removeWhere((element) => element.containsKey(id.toString())==id.toString());
      if(events[date]!=null) {
        var decoded = json.decode(response.body);
        final event = CalendarEvent.fromJson(decoded);
        int index = events[date]!.indexWhere((element) => element.id == event.id);
        if (index != -1) {
          events[date]![index] = event;
        }
        //events[date]!.add({response.body.toString():CalendarEvent(username,response.body, title, "", location, hour, date)});
      } else {
        var toAdd = {date.toString():[{response.body.toString():CalendarEvent(username, response.body, title,"", location, hour, date)}]};
        //events.addAll(toAdd);
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
      events[date]!.removeWhere((element) => element.id == id);
      //events[date]?.removeWhere((element) => element.keys.first==id.toString());
    } else if(response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
    }
    return response.statusCode;
  }


}