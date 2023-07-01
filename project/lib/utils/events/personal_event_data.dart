
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

import '../../login_screen/functions/auth.dart';
import 'package:http/http.dart' as http;

class CalendarEvent {

  static List<CalendarEvent> events = <CalendarEvent>[];
  final bool? isEditable;
  final String? id;
  final String? title;
  final String? planner;
  final String? location;
  final String? hour;
  final String? date;

  CalendarEvent(
      this.isEditable,
      this.id,
      this.title,
      this.planner,
      this.location,
      this.hour,
      this.date
      );

  Future<int> addPersonalEvent(String title, String planner, String location, String date, String hour) async {
    String apiUrl = '$magikarp/profile/personalEvent/add';
  String token = await Authentication.getTokenID();
  if(token.isEmpty)
    return 403;
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
  'Content-Type': 'application/json',
  'Authorization': token,
  },
        body: jsonEncode({
  'title': title,
  'planner': planner,
  'beginningDate': date,
  'hours': hour,
  'location': location
  }),
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Add personal event successful with ID: $id');
      }
      return response.statusCode;
  }

  /*Future<void> editPersonalEvent(String token, String id, String oldTitle, PersonalEventsData data) async {
    final String apiUrl = '$profileUrl/personalEvent/edit/$oldTitle';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Edit personal event successful with ID: $id');
      } else {
        print('Edit personal event failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while editing personal event : $e');
    }
  }

  Future<void> deletePersonalEvent(String token, String id, String oldTitle) async {
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