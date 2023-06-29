import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  static bool userIsLoggedIn = false;
  static int statusCode = 0;

  static bool isVerified() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.emailVerified == true;
    }
    return false;
  }

  static String getName() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.displayName.toString();
    }
    return "";
  }

  static bool isCompliant(String id, String password) {
    return id.isEmpty || password.isEmpty ? false : true;
  }

  static Future<int> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      userIsLoggedIn = true;
      return 200;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 401;
      } else if (e.code == 'wrong-password') {
        return 401;
      }
    }
    return 404;
  }

  static Future<int> logout() async {
    await FirebaseAuth.instance.signOut();
    userIsLoggedIn = false;
    return 200;
  }

  static Future<bool> checkLogin() async {
    var user = FirebaseAuth.instance.currentUser;
    return user!=null;
  }

  static Future<int> validateLogin() async {
    final url = Uri.parse('https://majikarp-fct.oa.r.appspot.com/rest/login/validate');

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
    });

    return response.statusCode;
  }

}