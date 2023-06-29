import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:UniVerse/tester/consts/api_consts.dart';

import 'package:UniVerse/tester/utils/FeedData.dart';

class Tester {
  Future<String> register(String email, String name, String password, String confirmation) async {
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
    }
    return "Error";
  }

  Future<String> logout() async {
    await FirebaseAuth.instance.signOut();
    return("User logged out.");
  }

  Future<String?> displayToken() async {
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();
    return token;
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

  Future<void> postFeed(String token, String kind, FeedData data) async {
    final String apiUrl = '$feedsUrl/post/$kind';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Post successful with ID: $id');
      } else {
        print('Post failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while posting feed: $e');
    }
  }

  Future<void> editFeed(String token, String kind, String id, FeedData data) async {
    final String apiUrl = '$feedsUrl/post/$kind/$id';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    final String requestBody = jsonEncode(data.toJson());

    try {
      final http.Response response = await http.patch(
        Uri.parse(apiUrl),
        headers: headers,
        body: requestBody,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('Update successful with ID: $id');
      } else {
        print('Update failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while updating feed: $e');
    }
  }

}
