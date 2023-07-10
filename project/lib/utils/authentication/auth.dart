import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class Authentication {

  static bool userIsLoggedIn = false;

  static String role = '';

  static bool areCompliantToLogin(email, password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  static bool areCompliantToModify(oldPwd, newPwd, confirmation) {
    return oldPwd.isNotEmpty && newPwd.isNotEmpty && confirmation.isNotEmpty;
  }

  static bool areEqual(password, confirmation) {
    return password == confirmation;
  }

  static bool match (newPwd) {
    var validator = RegExp("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,64}");
    return validator.hasMatch(newPwd);
  }

  static Future<int> login(email, password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(!kIsWeb) {
        FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
      } else FirebaseAuth.instance.setPersistence(Persistence.SESSION);
      userIsLoggedIn = true;
      getTokenID();
      assignUserFriendlyText();
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
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        String idToken = await user.getIdToken();
        role = JwtDecoder.decode(idToken)['role'];
        return idToken;
      } catch (e) {
        return "ERROR";
      }
    } else {
      return "ERROR";
    }
  }

  static Future<int> updatePwd(oldPwd, newPwd) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final email = currentUser?.email;
    if (currentUser != null && email != null) {
      final credential = EmailAuthProvider.credential(email: email, password: oldPwd);
      final authResult = await currentUser.reauthenticateWithCredential(credential);
      if (authResult.user != null) {
        await currentUser.updatePassword(newPwd);
        Authentication.userIsLoggedIn = false;
        Authentication.revoke();
        return 200;
      } else return 400;
    } else {
      Authentication.userIsLoggedIn = false;
      Authentication.revoke();
      return 401;
    }
  }

  static Future<int> reset(email) async {
    final response = FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    if(response == 'user-not-found')
      return 404;
    else return 200;
  }

  static void assignUserFriendlyText() {
    switch(role) {
      case 'A': UniverseUser.friendlyRole = 'Administrador';
      break;
      case 'BO': UniverseUser.friendlyRole = 'Gestor de Backoffice';
      break;
      case 'S': UniverseUser.friendlyRole = 'Aluno';
      break;
      case 'W': UniverseUser.friendlyRole = 'Funcionário';
      break;
      case 'T': UniverseUser.friendlyRole = 'Docente / Investigador(a)';
      break;
    }
  }

}