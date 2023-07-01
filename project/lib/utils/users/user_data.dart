

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
    return false;
  }

  static bool isActive() {
    /*var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return false;*/
    return true;
  }

  Future<int> getProfile(String token) async {
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

  Future<int> updateProfile(String name, String status, String licensePlate) async {
    String token = await Authentication.getTokenID();
    String url = '$magikarp/modify/attributes';

    if(token.isEmpty)
      return 403;

    final http.Response response = await http.post(
      Uri.parse(reportUrl),
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

  /*Future<void> deleteUser(String token, ModifyAttributesData data) async {
    const String apiUrl = '$modifyUrl/delete';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Delete user successful with ID: $id');
      } else {
        print('Delete user failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while deleting user: $e');
    }
  }*/

}
