
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

class Chat {

  static String idCreated = "";

  static bool areCompliant(name, pwd) {
    return name.isNotEmpty && pwd.isNotEmpty;
  }

  static Future<int> create(String name, String password) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    final url = Uri.parse('$forumUrl/create');
    final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
        body: json.encode({
          'name': name,
          'password': password
        }),
      );
    if(response.statusCode == 200)
      idCreated = response.body;

    print(response.statusCode);

    return response.statusCode;
  }

  static Future<int> delete(id) async {
      final url = Uri.parse('$forumUrl/$id/delete');

      String token = await Authentication.getTokenID();
      if(token.isEmpty) {
        Authentication.userIsLoggedIn = false;
        return 401;
      }

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
      );

      return response.statusCode;
  }

  static Future<int> join(id, password) async {
   String token = await Authentication.getTokenID();
      if(token.isEmpty) {
        Authentication.userIsLoggedIn = false;
        return 401;
      }

      final url = Uri.parse('$forumUrl/$id/join');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
        body: json.encode({
          'password': password
        }),

      );

      print(response.statusCode);

      return response.statusCode;
  }

  static Future<int> leave(forumID) async {
    String token = await Authentication.getTokenID();
      if(token.isEmpty) {
        Authentication.userIsLoggedIn = false;
        return 401;
      }

      final url = Uri.parse('$forumUrl/$forumID/leave');
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
      );
      return response.statusCode;
  }

  static Future<void> sendMessage(String forumID, String message) async {
    try {
      final url = Uri.parse('$forumUrl/$forumID/post');

      String token = await Authentication.getTokenID();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final response = await http.post(
        url,
        body: json.encode({
          'message': message
        }),
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }

  static Future<int> editPost(forumID, postID, message) async {
    String token = await Authentication.getTokenID();
      if(token.isEmpty) {
        Authentication.userIsLoggedIn = false;
        return 401;
      }
      final url = Uri.parse('$forumUrl/$forumID/$postID/edit');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token
        },
        body: json.encode({
          'message': message
        }),
      );
      return response.statusCode;
  }

  static Future<int> deletePost(forumID, postID) async {
      String token = await Authentication.getTokenID();
      if(token.isEmpty) {
        Authentication.userIsLoggedIn = false;
        return 401;
      }
      final url = Uri.parse('$forumUrl/$forumID/$postID/delete');
      final response = await http.delete(
        url,
        headers:  {
          'Content-Type': 'application/json',
          'Authorization': token
        },
      );
      return response.statusCode;
  }

  static Future<int> promote(forumID, memberUsername) async {

    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      return 401;
    }

    final String url = '$forumUrl/$forumID/$memberUsername/promote';
      final http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      return response.statusCode;
  }

  static Future<int> demote(forumID, String memberID) async {
    final String apiUrl = '$forumUrl/$forumID/$memberID/demote';
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      return 401;
    }

      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      return response.statusCode;
  }


}