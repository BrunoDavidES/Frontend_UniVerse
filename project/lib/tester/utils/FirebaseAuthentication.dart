import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {

  static Future<String> getIdToken() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String idToken = await user.getIdToken();
        print(idToken);
        return idToken;
      } catch (e) {
        print('Error getting ID token: $e');
        return "";
      }
    } else {
      print('User is not signed in');
      return "";
    }
  }
}
