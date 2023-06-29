import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/tester/utils/FirebaseAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../tester/utils/ReportData.dart';

class Report {
  static bool isCompliant(String title, String location, String description) {
    return title.isEmpty || location.isEmpty || description.isEmpty ? false : true;
  }

  static Future<int> postReport(ReportData data) async {
    const String apiUrl = '$reportUrl/post';

    String token = await FirebaseAuthentication.getIdToken();
    if(token.isEmpty) {
      return 403;
    }

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      return 405;
    }
  }

}
