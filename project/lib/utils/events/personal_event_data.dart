
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
    hour = properties['hours']['value'];
    date = properties['beginningDate']['value'];
  }

  static Future<int> fetchEvents(month, year) async {
     String query = "$month-$year";
    String eventsUrl = '$magikarp/profile/personalEvent/monthly/$query';
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
        events[event.date]?.add({event.id.toString():event});
      }
    }
    print(response.statusCode);
    return response.statusCode;
  }

  static bool areCompliant(title, department, location, date, hour) {
    return title.isNotEmpty && (department==null || department.isNotEmpty) && location.isNotEmpty && date.isNotEmpty && hour.isNotEmpty;
  }

  static Future<int> add(username, title, department, location, date, hour) async {
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
        "department": department,
        'beginningDate': date,
        'hours': hour,
        'location': location
        }),
      );

     // if (response.statusCode == 200) {
        /*if(events[date]!=null) {
          events[date]!.add({response.body.toString():CalendarEvent(username,response.body, title, department, location, hour, date)});
        } else {
          var toAdd = {date.toString():[{response.body.toString():CalendarEvent(username, response.body, title, department, location, hour, date)}]};
          events.addAll(toAdd);
        }*/
    if(events[date]!=null) {
      events[date]!.add({"2":CalendarEvent(username,"2", title, department, location, hour, date)});
    } else {
      var toAdd = {date.toString():[{"2":CalendarEvent(username, response.body, title, department, location, hour, date)}]};
    events.addAll(toAdd);
    }
      //}
      //return response.statusCode;
    return 200;
  }

  static Future<int> edit(id, title, location, date, hour) async {
    final String apiUrl = '$magikarp/profile/personalEvent/edit/$id';

    String username = UniverseUser.getUsername();

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
        'username': UniverseUser.getUsername(),
        'beginningDate': date,
        'hours': hour,
        'location': location
      }),
    );

      //if (response.statusCode == 200) {
        events[date]!.removeWhere((element) => element.keys.first==id.toString());
        events[date]!.add({id.toString(): CalendarEvent(username,response.body, title, "", location, hour, date)});
      //}
      //return response.statusCode;
    return 200;
  }

  static Future<int> delete(String id, String date) async {
    /*final String apiUrl = '$magikarp/profile/personalEvent/delete/$id';

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
      );*/

      //if (response.statusCode == 200) {
        events[date]?.removeWhere((element) => element.keys.first==id.toString());
     // }
      //return response.statusCode;
    return 200;
  }


}