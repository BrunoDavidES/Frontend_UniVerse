import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/users/users_local_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:requests/requests.dart';

import '../../utils/users/user_data.dart';

class Authentication {

  static bool userIsLoggedIn = false;

  static bool isCompliant(String id, String password) {
    return id.isEmpty || password.isEmpty ? false : true;
  }

  static Future<int> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userIsLoggedIn = true;
      return 200;
    } on FirebaseAuthException catch (e) {
      if(e=='internal-error')
        return 500;
      else return 401;
      }
    }


  static Future<int> revoge() async {
    try{
      await FirebaseAuth.instance.signOut();
      userIsLoggedIn = false;
      return 200;
    } on FirebaseAuthException catch (e) {
      return 500;
    }
      /*FirebaseAuth.instance.signOut();
      final response = await http.post(
        Uri.parse(baseUrl + logoutUrl),
      );
      print(response.statusCode);
      if(response.statusCode == 200)
        userIsLoggedIn = false;
      return response.statusCode;*/
    }

  static Future<String> getTokenID() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String idToken = await user.getIdToken();
        return idToken;
      } catch (e) {
        return "";
      }
    } else
      return "";
  }


  /*static Future<int> validateLogin() async {
    final url = Uri.parse('https://majikarp-fct.oa.r.appspot.com/rest/login/validate');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    return response.statusCode;
  }*/

}