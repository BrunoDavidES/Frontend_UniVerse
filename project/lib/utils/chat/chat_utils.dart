import 'package:UniVerse/tester/utils/FirebaseAuthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

class ChatUtils {

  Future<void> fetchInbox() async {
    /*String userId = FirebaseAuthentication.getCurrentUserUid();

    DatabaseReference inboxRef = FirebaseDatabase.instance.ref("Users/$userId/inbox");

    List<dynamic> inbox = [];

    inboxRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      updateStarCount(data);
    });

    return inbox;*/
  }

  static Future<void> sendMessage(String forumID, String message) async {
    try {
      final url = Uri.parse('$forumUrl/$forumID/post');

      String token = await FirebaseAuthentication.getIdToken();

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': token
      };

      final response = await http.post(
        url,
        body: json.encode({
          'title': 'title',
          'description': message
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
/*
      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error sending message: $error');
    }
  }
  */



}
