
import 'dart:async';
//import 'dart:js_interop';

import 'package:UniVerse/login_screen/functions/sessionManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class SplashServices{

  void isLogin(BuildContext context){

    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if(user != null) {
      SessionController().userID = user.uid.toString();
    }
    else{
      Timer(const Duration(seconds: 3), ()=> Navigator.pushNamed(context, '/home'));
    }

  }

}