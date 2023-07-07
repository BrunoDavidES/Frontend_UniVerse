import 'dart:convert';
import 'package:UniVerse/consts/api_consts.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class Registration {

  static bool areCompliant(password, confirmation, name, email) {
    return password.isNotEmpty && confirmation.isNotEmpty && name.isNotEmpty && email.isNotEmpty;
  }

  static bool match(String password, String confirmation) {
    return password == confirmation;
  }

  static Future<int> regist(String password, String confirmation,
      String name, String email, passwordUnHashed) async {
    final emailValidator = RegExp("^[A-Za-z0-9._%+-]+@(fct\.unl\.pt|campus\.fct\.unl\.pt)");
    final passwordValidator = RegExp("(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{6,64}");
    /*Password_Hasher(
      algorithm_number: '512',
      Hex: true,
      controller: password,
      restrict: false,
    )*/
   if (!emailValidator.hasMatch(email))
      return 00;
    if(!passwordValidator.hasMatch(passwordUnHashed))
    return 01;
    else return register(password, confirmation, name, email);
  }


  static Future<int> register(password, confirmation, name, email) async {
    final url = Uri.parse(registUrl);
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'name': name,
        'password': password,
        'confirmation': confirmation,
      }),
    );
    if (response.statusCode == 200) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      await FirebaseAuth.instance.currentUser?.sendEmailVerification();
      Authentication.userIsLoggedIn = true;
      return 200;
    }
      return response.statusCode;
  }

}