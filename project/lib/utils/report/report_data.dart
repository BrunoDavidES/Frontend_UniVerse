import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Report {

  static String? imagePath;

  static bool areCompliant(title, location, description) {
    return title.isNotEmpty && location.isNotEmpty && description.isNotEmpty;
  }

  static Future<int> send(title, location, description, Uint8List image) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

      final http.Response response = await http.post(
        Uri.parse(reportUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
        body: json.encode({
          'title': title,
          'location': location,
        }),
      );
      if (response.statusCode == 200) {
        String id = response.body;
        var ref = FirebaseStorage.instance.ref().child("Reports/$id");
        ref.putData(image, SettableMetadata(contentType: 'image/jpeg'));
        ref = FirebaseStorage.instance.ref().child("Reports/$id.txt");
        ref.putString(description, metadata:SettableMetadata(contentType: 'text/plain;charset=UTF-8'));
        return 200;
      } else if (response.statusCode == 401) {
        Authentication.userIsLoggedIn = false;
        Authentication.revoke();
      }
      return response.statusCode;
  }

}
