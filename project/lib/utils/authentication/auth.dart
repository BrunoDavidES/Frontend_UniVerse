import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {

  static bool userIsLoggedIn = false;

  static bool areCompliantToLogin(email, password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  static bool areCompliantToModify(oldPwd, newPwd, confirmation) {
    return oldPwd.isNotEmpty && newPwd.isNotEmpty && confirmation.isNotEmpty;
  }

  static bool match(password, confirmation) {
    return password == confirmation;
  }

  static Future<int> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(!kIsWeb) {
        FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      }
      userIsLoggedIn = true;
      return 200;
    } on FirebaseAuthException catch (e) {
      if(e=='internal-error') {
        return 500;
      } else {
        return 401;
      }
      }
    }

  static Future<int> revoke() async {
    try {
      await FirebaseAuth.instance.signOut();
      userIsLoggedIn = false;
      return 200;
    } on FirebaseAuthException catch (e) {
      return 500;
    }
  }

  static Future<String> getTokenID() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String idToken = await user.getIdToken();
        return idToken;
      } catch (e) {
        return "ERROR";
      }
    } else {
      return "ERROR";
    }
  }

  /*static bool match (newPwd) {
    var validator = RegExp("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,64}");
    return newPwd.matches(validator);
  }*/

  static Future<int> updatePwd(oldPwd, newPwd, confirmation) async {
   /* String token = await Authentication.getTokenID();
    const String url = '$baseUrl/modify/pwd';

    if(token.isEmpty) {
      Authentication.userIsLoggedIn = false;
      return 401;
    }

    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
      body: json.encode({
        'password': oldPwd,
        'newPwd': newPwd,
        'confimation': confirmation
      }),
    );

    if (response.statusCode == 200) {
      Authentication.userIsLoggedIn = false;
    }*/
    return 200;
  }

}