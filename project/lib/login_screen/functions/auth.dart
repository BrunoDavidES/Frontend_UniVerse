import 'dart:convert';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:flutter/material.dart';
import 'package:hash_password/password_hasher.dart';
import 'package:http/http.dart' as http;

class Authentication {
  static bool isCompliant(String id, String password) {
    return id.isEmpty || password.isEmpty ? false : true;
  }

  static bool loginUser(String id, String password) {
    /*Password_Hasher(
      algorithm_number: '512',
      Hex: true,
      controller: password,
      restrict: false,
    )*/
    authenticate(id, password);
    return true;
  }

  static Future<bool> authenticate(String id, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl+login),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': id,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      return true;
    } else if(response.statusCode == 403) {
      DialogTestPage();
      return false;
    }
    return true;
  }
}
