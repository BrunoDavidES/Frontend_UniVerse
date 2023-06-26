import 'dart:convert';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/login_screen/reset_password_app.dart';
import 'package:UniVerse/login_screen/reset_password_screen.dart';
import 'package:UniVerse/login_screen/reset_password_web.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_body_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../personal_page_screen/personal_page_web.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';
import 'functions/auth.dart';
import 'login_app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void initState() {
    idController = TextEditingController();
    passwordController = TextEditingController();
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void logInButtonPressed(String id, String password) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para iniciares sessão precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = Authentication.isCompliant(id, password);
      if (!areControllersCompliant) {
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "Ups!",
                descriptions: "Existem campos vazios. Preenche-os, por favor.",
                text: "OK",
              );
            }
        );
        setState(() {
          isLoading = false;
        });
      }
      else {
        var response = await Authentication.loginUser(id, password);
        if (response == 200) {
          if(kIsWeb) {
            Navigator.pushNamed(context, "/personal/main");
          }
          else Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppPersonalPage()));
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "O email e/ou password estão incorretos. Tenta novamente.",
                  text: "OK",
                );
              }
          );
        } else {
          if(kIsWeb)
            Navigator.popAndPushNamed(context, "/error");
          else
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500WithBar(i:3, title: Image.asset("assets/app/login.png", scale: 6,))));
              }
        }
      }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          title: Image.asset("assets/app/login.png", scale:6),
          automaticallyImplyLeading: false,
          backgroundColor: cDirtyWhiteColor,
          titleSpacing: 15,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:20, left: 20, right: 20, bottom:10),
                    child: Image.asset('assets/icon_no_white.png', scale:3),
                  ),
                  const Text(
                    "Junta-te ao Universo!",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyTextField(controller: idController, hintText: 'Introduz o teu e-mail institucional', obscureText: false, label: 'E-mail', icon: Icons.person_outline,),
                  MyTextField(controller: passwordController, hintText: '', obscureText: true, label: 'Palavra-passe', icon: Icons.lock_outline,),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if(kIsWeb) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(10.0)
                                        )
                                    ),
                                    content: ResetPageWeb(),
                                  )
                              );
                            }
                            else
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ResetPageApp()));
                          },
                          child: Text(
                            "Esquesceste a palavra-passe?",
                            style: TextStyle(
                                color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  isLoading
                      ? Container(
                      width: 150,
                      child: const LinearProgressIndicator(
                        color: cPrimaryColor,
                        backgroundColor: cPrimaryOverLightColor,
                      )
                  )
                      : Column(
                    children: [
                      DefaultButtonSimple(
                          text: "ENTRAR",
                          color: cPrimaryColor,
                          press: () {
                            logInButtonPressed(idController.text, passwordController.text);
                            setState(() {
                              isLoading = true;
                            });
                          },
                          height: 20),
                      DefaultButtonSimple(
                          text: "CRIAR CONTA",
                          color: cHeavyGrey,
                          press: () {
                            if(kIsWeb) {
                              Navigator.of(context).pop();
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(10.0)
                                        )
                                    ),
                                    content: RegisterPageWeb(),
                                  )
                              );
                            }
                            else Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPageApp()));
                          },
                          height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}