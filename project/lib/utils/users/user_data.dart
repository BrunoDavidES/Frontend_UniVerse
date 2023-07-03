

import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../login_screen/functions/auth.dart';

class User {


  static String getUsername() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.uid;
    }
    return "UNKNOWN ERROR";
  }

  static String getName() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName!;
    }
    return "UNKNOWN ERROR";
  }

  static String getRole() {
    /*String token = Authentication.getTokenID() as String;
    if (token.isNotEmpty) {
      return token.;
    }
    return "UNKNOWN ERROR";*/
    return "Aluno";
  }

  static String getJob() {
    /*String token = Authentication.getTokenID() as String;
    if (token.isNotEmpty) {
      return token.;
    }
    return "UNKNOWN ERROR";*/
    return "Presidente de Núcleo";
  }

  static bool isVerified() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return true;
  }

  static bool isActive() {
    /*var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return false;*/
    return true;
  }

  Future<int> get(String token) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty)
      return 403;

    String username = getUsername();
    String url = '$magikarp/profile/$username';

    final http.Response response = await http.post(
      Uri.parse(reportUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (response.statusCode == 200) {
      //fazer decode
      return 200;
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoge();
    }
    return response.statusCode;
  }

  Future<int> update(String name, String status, String licensePlate) async {
    String token = await Authentication.getTokenID();
    String url = '$magikarp/modify/attributes';

    if(token.isEmpty)
      return 403;

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'name': name,
        'status': status,
        'licensePlate': licensePlate,
      }),
    );
    if (response.statusCode == 200) {
      //final String id = response.body;
      return 200;
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoge();
    }
    return response.statusCode;
  }

  static Future<int> delete() async {
    String token = await Authentication.getTokenID();
    const String url = '$magikarp/modify/delete';

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 403;
    }

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'target': User.getUsername(),
      }),
    );

      if (response.statusCode == 200) {
        Authentication.userIsLoggedIn = false;
      }
      return response.statusCode;
  }

}
