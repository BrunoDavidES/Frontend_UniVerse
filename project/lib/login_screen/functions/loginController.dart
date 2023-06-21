
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {

  FirebaseAuth auth = FirebaseAuth.instance;

  void login(BuildContext context, String email, String password) async{
    try{
      auth.signInWithEmailAndPassword(
          email: email,
          password: password
      ).then((value) => Navigator.pushNamed(context, '/personal/main'
      ).onError((error, stackTrace) => error.toString()));

    }catch(e){

    }
  }
}