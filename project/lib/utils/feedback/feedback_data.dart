import 'dart:convert';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import '../../consts/api_consts.dart';
import '../authentication/auth.dart';

class UniverseFeedback{

  static Future<int> post(rating, message) async {
    String token = await Authentication.getTokenID();
    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }
    final http.Response response = await http.post(
      Uri.parse(feedbackUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: jsonEncode({
        'rating': rating,
      }),
    );
    if (response.statusCode == 200) {
      var id = response.body;
      var ref = FirebaseStorage.instance.ref().child("Feedback/$id.txt");
      ref.putString(message, metadata:SettableMetadata(contentType: 'text/plain;charset=UTF-8'));
    } else if (response.statusCode == 401) {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
    }
    return response.statusCode;
  }

}