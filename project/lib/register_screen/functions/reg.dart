import 'dart:convert';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:flutter/material.dart';
import 'package:hash_password/password_hasher.dart';
import 'package:http/http.dart' as http;

class Registration {
  static bool isCompliant(String id, String password, String confirmation, String name, String email) {
    return id.isEmpty || password.isEmpty || confirmation.isEmpty || name.isEmpty || email.isEmpty ? false : true;
  }

  static Future<int> registUser(String id, String password, String confirmation, String name, String email) async {
    /*Password_Hasher(
      algorithm_number: '512',
      Hex: true,
      controller: password,
      restrict: false,
    )*/
      return register(id, password, confirmation, name, email);
   // return true;
  }

  static Future<int> register(String id, String password, String confirmation, String name, String email) async {
      final response = await http.post(
        Uri.parse(baseUrl + regist),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': id,
          'password': password,
          'confirmation': confirmation,
          'name': name,
          'email': email,
          'role': 'User'
        }),
      );
      /*var statusCode = Authentication.loginUser(id, password);
      if (statusCode == 200) {*/
      // TODO: Update the DB with the last active time of the user
      return response.statusCode;
  }
}
