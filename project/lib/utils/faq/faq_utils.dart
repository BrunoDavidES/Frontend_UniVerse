
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

class Faq {

  static bool areCompliant(email, title, message) {
    return email.isNotEmpty && title.isNotEmpty && message.isNotEmpty;
  }

  static Future<int> request(title, email, message) async {
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
    return response.statusCode;
  }

}