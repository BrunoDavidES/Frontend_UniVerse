import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/users_local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:requests/requests.dart';

import '../../utils/users/User.dart';

class Authentication {

  static bool userIsLoggedIn = false;
  static int statusCode = 0;

  static bool isVerified() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return false;
  }

  static String getName() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName.toString();
    }
    return "";
  }

  static bool isCompliant(String id, String password) {
    return id.isEmpty || password.isEmpty ? false : true;
  }

  static Future<int> loginUser(String id, String password) async {
    return authenticate(id, password);
    // return true;
  }

  static Future<int> authenticate(String id, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: id,
          password: password
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        statusCode = 401;
      } else if (e.code == 'wrong-password') {
        statusCode = 401;
      }
    }
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        IdTokenResult idTokenResult = await user.getIdTokenResult(true);
        String? idToken = idTokenResult.token;
        print(idToken);
        final response = await http.post(
          Uri.parse(baseUrl + loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'username': id,
            'token': idToken!,
          }),
        );
        print(response.headers);
        print(response.headers['set-cookie']);
        if (response.statusCode == 200) {
          userIsLoggedIn = true;
          statusCode = 200;
        }
      } catch (e) {
      }
    }
    return statusCode;
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
      FirebaseAuth.instance.signOut();
      final response = await http.post(
        Uri.parse(baseUrl + logoutUrl),
      );
      print(response.statusCode);
      if(response.statusCode == 200)
        userIsLoggedIn = false;
      return response.statusCode;
    }

  static Future<bool> checkLogin() async {
    var user = FirebaseAuth.instance.currentUser;
    return user!=null;
  }


  static Future<int> validateLogin() async {
    final url = Uri.parse('https://majikarp-fct.oa.r.appspot.com/rest/login/validate');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    return response.statusCode;
  }

}