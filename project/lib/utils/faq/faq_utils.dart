
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

class Faq {

  static Future<int> requestHelp(String title, String email, String message) async {
    final url = Uri.parse('$helpUrl/request');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'title': title,
        'email': email,
        'message': message
      }),
    );
    if(response.statusCode == 200)

    print(response.statusCode);

    return response.statusCode;
  }

}