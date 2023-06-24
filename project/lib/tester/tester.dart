import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:UniVerse/consts/api_consts.dart';

import '../login_screen/functions/auth.dart';

class Tester {
  Future<String> register(String email, String name, String password, String confirmation) async {
    try {
      final url = Uri.parse(registUrl);
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
        return('Registration successful');
      } else {
        return('Registration failed: ${response.body}');
      }
    } catch (error) {
      return('Error occurred during registration: $error');
    }
  }

  Future<String> login(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return('User not found');
      } else if (e.code == 'wrong-password') {
        return('Wrong password');
      }
      // Handle other FirebaseAuthException errors if needed
    }

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        IdTokenResult idTokenResult = await user.getIdTokenResult(true);
        String? idToken = idTokenResult.token;
        print(idToken);

        final response = await http.post(
          Uri.parse(loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'token': idToken!,
          }),
        );
        print(response.headers);
        return('Login: ${response.body}');
      } catch (e) {
        return('Error occurred during HTTP POST: $e');
      }
    }
    return "Error";
  }

  Future<String> logout() async {
    try {
      final url = Uri.parse(logoutUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return('Logout successful');
      } else {
        return('Logout failed: ${response.body}');
      }
    } catch (error) {
      return('Error occurred during logout: $error');
    }
  }

  Future<String> displayToken() async {
    try {
      final url = Uri.parse(displayTokenUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return('Empty Token');
      } else {
        return('Token: ${response.body}');
      }
    } catch (error) {
      return('Error occurred during validation: $error');
    }
  }

  Future<String> sendMessage(String sender, List<String> recipientIds, String message) async {
    try {
      final url = Uri.parse(sendMsgUrl);
      final response = await http.post(
        url,
        body: json.encode({
          'senderId': sender,
          'recipientIds': recipientIds.toList(),
          'message': message,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return ('Message sent successfully');
      } else {
        return ('Failed to send message: ${response.body}');
      }
    } catch (error) {
      return ('Error occurred while sending message: $error');
    }
  }
}
