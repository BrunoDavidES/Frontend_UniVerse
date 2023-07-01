import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Registration {

  static bool isCompliant(String password, String confirmation, String name,
      String email) {
    return password.isEmpty || confirmation.isEmpty || name.isEmpty ||
        email.isEmpty ? false : true;
  }

  static bool areCompliant(String password, String confirmation) {
    return password == confirmation;
  }


  static Future<int> registUser(String password, String confirmation,
      String name, String email) async {
    final emailRestriction = RegExp(
        "^[A-Za-z0-9._%+-]+@(fct\.unl\.pt|campus\.fct\.unl\.pt)");
    final passwordRestriction = RegExp(
        "(?=.[0-9])(?=.[a-z])(?=.*[A-Z]).{6,64}");
    /*Password_Hasher(
      algorithm_number: '512',
      Hex: true,
      controller: password,
      restrict: false,
    )*/
    if (!emailRestriction.hasMatch(email))
      return 00;
    //else if(!passwordRestriction.hasMatch(password))
    //return 01;
    else
      return register(password, confirmation, name, email);
    // return true;
  }


  static Future<int> register(String password, String confirmation, String name,
      String email) async {
    //return 200;
    final url = Uri.parse(registUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'name': name,
        'password': password,
        'confirmation': confirmation,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Authentication.userIsLoggedIn = true;
      return 200;
    } else {
      print(response.statusCode);
      return response.statusCode;
    }
  }
/*final response = await http.post(
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
      return response.statusCode;*/

}