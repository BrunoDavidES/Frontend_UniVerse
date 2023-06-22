// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCBTc9fONJ-u1rYcDBLP3P9WWDIom0oHg0',
    appId: '1:1069096740543:web:bedc2afef6f6c3ba9a880a',
    messagingSenderId: '1069096740543',
    projectId: 'magikarp-fct',
    authDomain: 'magikarp-fct.firebaseapp.com',
    databaseURL: 'https://magikarp-fct-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'magikarp-fct.appspot.com',
    measurementId: 'G-GQWLDZVBFF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrs7a6MMyohlBTaAU_oU80KdgDeihybD0',
    appId: '1:1069096740543:android:2c8e114e009d7ffe9a880a',
    messagingSenderId: '1069096740543',
    projectId: 'magikarp-fct',
    databaseURL: 'https://magikarp-fct-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'magikarp-fct.appspot.com',
  );
}