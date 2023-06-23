import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

class ChatUtils {
  static Future<void> sendMessage(String senderId, String recipientId, String message) async {
    Map<String, dynamic> requestBody = {
      'senderId': senderId,
      'recipientId': recipientId,
      'message': message,
    };

    String requestBodyJson = json.encode(requestBody);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    // Make the POST request
    Uri url = Uri.parse(baseUrl + sendMsgUrl);
    try {
      http.Response response = await http.post(url, headers: headers, body: requestBodyJson);

      // Handle the response
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