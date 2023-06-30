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

  static Future<void> sendMessage(String senderId, String recipientId,
      String message) async {
    try {
      final url = Uri.parse('$messageUrl/send');
      final response = await http.post(
        url,
        body: json.encode({
          'senderId': senderId,
          'recipientId': "g.cerveira",
          'message': message,
        }),
        headers: {'Content-Type': 'application/json'},
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


}
