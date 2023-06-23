import 'dart:convert';
import 'package:UniVerse/bars/dialog_test.dart';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/users_local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:requests/requests.dart';

import '../../utils/users/User.dart';

class Authentication {
  static bool isCompliant(String id, String password) {
    return id.isEmpty || password.isEmpty ? false : true;
  }

  static Future<int> loginUser(String id, String idToken) async {
    return authenticate(id, idToken);
    // return true;
  }

  static Future<int> authenticate(String id, String idToken) async {
    final response = await http.post(
      Uri.parse(baseUrl + loginUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'username': id,
        'token': idToken,
      }),
    );
    print(response.headers);
    return response.statusCode;
  }
/*if (response.statusCode == 200) {
        if(!kIsWeb) {
          User u = const User(
              id: 'testeDumy', name: 'Dumy', primaryRole: 'Aluno');
          var db = LocalDB('universe');
          db.initDB();
          db.addUser(u);
        }
      }

      return response.statusCode;
      print(response.body);
      print(response.headers);
    return response.statusCode;
  }*/

  static Future<int> revoge() async {
    final response = await http.post(
      Uri.parse(baseUrl + logoutUrl),
    );
    print(response.statusCode);
    return response.statusCode;
  }

}