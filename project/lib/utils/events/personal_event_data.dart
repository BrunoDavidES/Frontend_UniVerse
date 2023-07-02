
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/user_data.dart';

import '../../login_screen/functions/auth.dart';
import 'package:http/http.dart' as http;

class CalendarEvent {

  static Map<String, List<CalendarEvent>> events = {};
  //verificado com o username
  final bool? isEditable;
  final String? id;
  final String? title;
  //final String? planner;
  final String? location;
  final String? hour;
  final String? date;

  CalendarEvent(
      this.isEditable,
      this.id,
      this.title,
      this.location,
      this.hour,
      this.date
      );

  static bool areCompliant(String title, String location, String date, String hour) {
    return title.isNotEmpty && location.isNotEmpty && date.isNotEmpty && hour.isNotEmpty;
  }

  static Future<int> addEvent(String username, String title, String location, String date, String hour) async {
    String apiUrl = '$magikarp/profile/personalEvent/add';

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 403;
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
          events[date]!.add(CalendarEvent(username==User.getUsername(),response.body, title, location, hour, date));
        } else {
          events[date]=[CalendarEvent(username==User.getUsername(), response.body, title, location, hour, date)];
        }
      }
      return response.statusCode;
  }

  static Future<int> editPersonalEvent(String id, String title, String location, String date, String hour) async {
    final String apiUrl = '$magikarp/profile/personalEvent/edit/$id';

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 403;
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
        //events[date]!.remove(CalendarEvent(true,id, title, location, hour, date));
       // events[date]!.add(CalendarEvent(true),response.body, title, location, hour, date))
      }
      return response.statusCode;
  }

  /*Future<void> deletePersonalEvent(String token, String id, String oldTitle) async {
    final String apiUrl = '$profileUrl/personalEvent/edit/$oldTitle';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete personal event successful with ID: $id');
      } else {
        print('Delete personal event failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting personal event : $e');
    }
  }*/


  /*CalendarEvent.fromJson(Map<String, dynamic> json ) {
    var properties = json['properties'];
    isEditable = properties['id']['value'];
    title = properties['title']['value'];
    planner = properties['authorName']['value'];
    location = 'Teste Data';//json['properties']['time_creation']['value'].toString();
    hour = images[Random().nextInt(images.length)];
    date =
  }*/

}