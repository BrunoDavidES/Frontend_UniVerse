import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;

class Registration {

  static bool isCompliant(String password, String confirmation, String name, String email) {
    return password.isEmpty || confirmation.isEmpty || name.isEmpty || email.isEmpty ? false : true;
  }

  static bool areCompliant(String password, String confirmation) {
    return password==confirmation;
  }

  static Future<int> validateAndRegister(String email, String name, String password, String confirmation) async {
    final emailRestriction = RegExp("^[A-Za-z0-9._%+-]+@(fct\.unl\.pt|campus\.fct\.unl\.pt)");
    final passwordRestriction= RegExp("(?=.[0-9])(?=.[a-z])(?=.*[A-Z]).{6,64}");

    if(!emailRestriction.hasMatch(email)) {
      return 00;
    }
    /*if(!passwordRestriction.hasMatch(password)) {
      return 01;
    }*/

    return register(email, name, password, confirmation);
  }

  static Future<int> register(String email, String name, String password, String confirmation) async {
    try {
      final url = Uri.parse(registerUrl);
      final response = await http.post(
        url,
        body: json.encode({
          'email': email,
          'name': name,
          'password': password,
          'confirmation': confirmation,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        await FirebaseAuth.instance.currentUser?.sendEmailVerification();
        return 200;
      } else {
        return 400;
      }
    } catch (error) {
      return 400;
    }
  }
}
