import 'dart:convert';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:flutter/material.dart';
import 'package:hash_password/password_hasher.dart';
import 'package:http/http.dart' as http;

class Registration {
  static bool isCompliant(String password, String confirmation, String name, String email) {
    return password.isEmpty || confirmation.isEmpty || name.isEmpty || email.isEmpty ? false : true;
  }

  static Future<int> registUser(String password, String confirmation, String name, String email) async {
    final emailRestriction = RegExp("^[A-Za-z0-9._%+-]+@(fct\.unl\.pt|campus\.fct\.unl\.pt)");
    final passwordRestriction= RegExp("(?=.[0-9])(?=.[a-z])(?=.*[A-Z]).{6,64}");
    /*Password_Hasher(
      algorithm_number: '512',
      Hex: true,
      controller: password,
      restrict: false,
    )*/
    if(!emailRestriction.hasMatch(email))
      return 00;
   else if(!passwordRestriction.hasMatch(password))
     return 01;
    else
      return register(password, confirmation, name, email);
   // return true;
  }

  static Future<int> register(String password, String confirmation, String name, String email) async {
     final response = await http.post(
        Uri.parse(baseUrl + registUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'confirmation': confirmation,
          'name': name
        }),
      );
     print(response.statusCode);
      return response.statusCode;
  }
}
