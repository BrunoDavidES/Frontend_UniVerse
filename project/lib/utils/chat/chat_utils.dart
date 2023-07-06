
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

  static Future<String> delete(id) async {
    try {
      final url = Uri.parse('$forumUrl/$id/delete');

      String token = await Authentication.getTokenID();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return('Failed to delete forum. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return('Error deleting forum: $error');
    }
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

  static Future<void> leaveForum(String forumID) async {
    try {
      final url = Uri.parse('$forumUrl/$forumID/leave');

      String token = await Authentication.getTokenID();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Forum left successfully');
      } else {
        print('Failed to leave forum. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error leaving forum: $error');
    }
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

  static Future<void> deletePost(String forumID, String postID) async {
    try {
      final url = Uri.parse('$forumUrl/$forumID/$postID/delete');

      String token = await Authentication.getTokenID();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final response = await http.delete(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        print('Message deleted successfully');
      } else {
        print('Failed to delete message. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting message: $error');
    }
  }

  static Future<void> promoteMember(String forumID, String memberID) async {
    final String apiUrl = '$forumUrl/$forumID/$memberID/promote';

    String token = await Authentication.getTokenID();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('User promoted: $id');
      } else {
        print('User promotion failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while promoting user: $e');
    }
  }

  static Future<void> demoteMember(String forumID, String memberID) async {
    final String apiUrl = '$forumUrl/$forumID/$memberID/demote';

    String token = await Authentication.getTokenID();

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': token,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final String id = response.body;
        print('User demoted: $id');
      } else {
        print('User demotion failed: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while demoting user: $e');
    }
  }


}