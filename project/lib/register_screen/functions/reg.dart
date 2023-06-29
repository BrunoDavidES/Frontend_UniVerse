import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Registration {

  static bool isCompliant(String password, String confirmation, String name, String email) {
    return password.isEmpty || confirmation.isEmpty || name.isEmpty || email.isEmpty ? false : true;
  }

  static bool areCompliant(String password, String confirmation) {
    return password==confirmation;
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
    //else if(!passwordRestriction.hasMatch(password))
    //return 01;
    else
      return register(password, confirmation, name, email);
    // return true;
  }


  static Future<int> register(String password, String confirmation, String name, String email) async {
    /*FirebaseAuth auth = FirebaseAuth.instance;
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) {
        auth.currentUser?.sendEmailVerification();
        Container(

        );
        return 200;
      }).onError((error, stackTrace) {
        return 400;
      });
    } catch(e) {
      return 500;
    }
    return 1; */
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
