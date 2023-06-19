import 'dart:async';

import 'package:UniVerse/register_screen/register_screen.dart';
import 'package:UniVerse/utils/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../bars/app_bar.dart';
import '../consts/color_consts.dart';

class RegisterPageApp extends StatefulWidget {

  const RegisterPageApp({super.key});

  @override
  State<RegisterPageApp> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<RegisterPageApp> {
  //late StreamSubscription subscription;
  //var isDeviceConnected = false;
  //bool isAlertSet = false;
 Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;

  @override
  void initState() {
    //getConnectivity();
    /*yy
    if(_source.keys.toList()[0]==ConnectivityResult.none)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "SEM INTERNET"
          ),
        )
      );*/
      /*showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("INTERNET"),
            );
          }
      );*/
    super.initState();
  }

  /*getConnectivity() => subscription = Connectivity().onConnectivityChanged.listen(
  (ConnectivityResult result) async {
  isDeviceConnected = await InternetConnectionChecker().hasConnection;
  if(!isDeviceConnected && isAlertSet==false) {
  showDialog(
  context: context,
  builder: (context) {
  return const AlertDialog(
  content: Text("Bad request"),
  );
  }
  );
  setState(() {
  isAlertSet=true;
  });
  }
  }
  );*/

  @override
  void dispose() {
    //_connectivity.disposeStream();
    //subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Scaffold(
  resizeToAvoidBottomInset: false,
  backgroundColor: cDirtyWhiteColor,
  body: Container(
  height: size.height,
  width: size.width,
  decoration: BoxDecoration(
  color: cDirtyWhiteColor,
  ),
  child: Stack(
  children: <Widget>[
  RegisterScreen(),
  Container(
  alignment: Alignment.bottomCenter,
  child:CustomAppBar(i:3),
  )
  ],
  ),
  ),
  );
  }
  }