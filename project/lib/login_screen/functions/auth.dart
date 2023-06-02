import 'dart:convert';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/users_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:hash_password/hashing_functionalities.dart';
import 'package:hash_password/password_hasher.dart';
import 'package:http/http.dart' as http;

import '../../utils/users/User.dart';

class Authentication {
  static bool isCompliant(String id, String password) {
    return id.isEmpty || password.isEmpty ? false : true;
  }

  static Future<String> loginUser(String id, String password) async {
    //PASSWORD_HASHER
      return authenticate(id, password);
   // return true;
  }

  static Future<String> authenticate(String id, String password) async {
      final response = await http.post(
        Uri.parse(baseUrl + loginUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'username': id,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        User u = const User(id: 'testeDumy', name:'Dumy', primaryRole: 'Aluno');
        var db = LocalDB('universe');
        db.initDB();
        db.addUser(u);
      }

      return response.body;
  }
}
