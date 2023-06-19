import 'dart:convert';

import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';
import 'functions/auth.dart';

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

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: id,
          password: password
      );
        print(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("User not found for that email "),
            );
          },
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Wrong password for that user"),
            );
          },
        );
      }
    }

    /*if(_source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("INTERNET"),
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = Authentication.isCompliant(id, password);

      if (!areControllersCompliant) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Existem campos vazios! Preenche-os."),
            );
          },
        );
        setState(() {
          isLoading = false;
        });
      }
      else {
        var response = await Authentication.loginUser(id, password);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(response),
            );
          },
        );
        if (response == 200) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UniverseInfoApp()));
        } else if (response.contains("User or password incorrect")) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    "O identificador fornecido não corresponde a nenhuma conta ou a password esta incorreta"),
              );
            },
          );
        } else if (response == 400) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Bad request"),
              );
            },
          );
        }
      }
    }
    setState(() {
      isLoading = false;
    });*/
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
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/icon_no_white.png', scale:3),
                  ),
                  const Text(
                    "Junta-te ao Universo!",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  const Text(
                      "Insere as tuas credenciais do clip.",
                      style:TextStyle(
                          fontSize: 15
                      )),
                  const SizedBox(height: 20),
                  MyTextField(controller: idController, hintText: "Identificador", obscureText: false,),
                  MyTextField(controller: passwordController, hintText: "Password", obscureText: true,),
                  const SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        UrlLaunchableItem(
                          text:"Esqueceste a senha?", url: 'https://clip.fct.unl.pt/recuperar_senha', color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
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
                          press: () {
                            logInButtonPressed(idController.text, passwordController.text);
                            setState(() {
                              isLoading = true;
                            });
                          },
                          height: 20),
                      DefaultButton(
                        text: "REGISTAR",
                        press: () {
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
                        },
                      ),
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