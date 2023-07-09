
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:UniVerse/consts/api_consts.dart';

class Faq {

  static Future<void> sendEmail() async {
    final HttpsCallable sendEmailCallable = FirebaseFunctions.instance.httpsCallable('sendEmail');

    try {
      final result = await sendEmailCallable.call(<String, dynamic>{
      });

      final data = result.data as Map<String, dynamic>;
      if (data['success'] == true) {
        print('Email sent successfully');
      } else {
        print('Error sending email: ${data['error']}');
      }
    } catch (e) {
      print('Error calling Cloud Function: $e');
    }
  }

}