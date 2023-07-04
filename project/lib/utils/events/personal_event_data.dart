
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/user_data.dart';

import '../authentication/auth.dart';
import 'package:http/http.dart' as http;

class CalendarEvent {

  static Map<String, List<CalendarEvent>> events = {};

  String? authorUsername;
  String? id;
  String? title;
  //final String? planner;
  String? location;
  String? hour;
  String? date;

  CalendarEvent(
      this.authorUsername,
      this.id,
      this.title,
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
    hour = properties['hour']['value'];
    date = properties['beginning']['value'];
  }

  static Future<int> fetchEvents(month, year) async {
    String eventsUrl = '$magikarp/profile/personalEvent/monthly/$month-$year';
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    var response;
    response = await http.get(
      Uri.parse(eventsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if(response.statusCode==200) {
      var decodedEvents = json.decode(response.body);
      print(decodedEvents);
      for (var decoded in decodedEvents) {
        var event = CalendarEvent.fromJson(decoded);
        events[event.date]?.add(event);
      }
    }
    return response.statusCode;
    //return 200;
  }

  static bool areCompliant(title, location, date, hour) {
    return title.isNotEmpty && location.isNotEmpty && date.isNotEmpty && hour.isNotEmpty;
  }

  static Future<int> add(username, title, location, date, hour) async {
    String apiUrl = '$magikarp/profile/personalEvent/add';

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'title': title,
        'username': username,
        'beginningDate': date,
        'hours': hour,
        'location': location
        }),
      );

      if (response.statusCode == 200) {
        if(events[date]!=null) {
          events[date]!.add(CalendarEvent(username,response.body, title, location, hour, date));
        } else {
          events[date]=[CalendarEvent(username, response.body, title, location, hour, date)];
        }
      }
      return response.statusCode;
  }

  static Future<int> edit(id, title, location, date, hour) async {
    final String apiUrl = '$magikarp/profile/personalEvent/edit/$id';

    String username = User.getUsername();

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'title': title,
        'username': User.getUsername(),
        'beginningDate': date,
        'hours': hour,
        'location': location
      }),
    );

      if (response.statusCode == 200) {
        events[date]!.remove(CalendarEvent(username, id, title, location, hour, date));
        events[date]!.add(CalendarEvent(username,id, title, location, hour, date));
      }
      return response.statusCode;
  }

  Future<int> delete(String id) async {
    final String apiUrl = '$magikarp/profile/personalEvent/delete/$id';

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        events[date]!.remove(CalendarEvent(authorUsername ,id, title, location, hour, date));
      }
      return response.statusCode;
  }

}