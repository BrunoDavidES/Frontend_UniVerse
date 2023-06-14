import 'dart:convert';

import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../login_screen/login_web.dart';
import '../utils/connectivity.dart';
import 'functions/reg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  bool _isPasswordVisible = false;
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  late TextEditingController emailController;

  @override
  void initState() {
    idController = TextEditingController();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void registerButtonPressed(String id, String name, String email, String password, String confirmation) async {
    if(_source.keys.toList()[0]==ConnectivityResult.none) {
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
      bool areControllersCompliant = Registration.isCompliant(
          id, name, password, confirmation, email);

      if (!areControllersCompliant) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Existem campos vazios! Preenche-os."),
            );
          },
        );
      }
      else {
        var response = await Registration.registUser(
            id, password, confirmation, name, email);
        if (response == 200) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UniverseInfoApp()));
        } else if (response == 404) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text(
                    "O identificador fornecido não corresponde a nenhuma conta"),
              );
            },
          );
        } else if (response == 403) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text("Palavra-passe errada"),
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
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          title: Image.asset("assets/app/registo.png", scale:6),
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
                    padding: EdgeInsets.only(top:20, left:20, right: 20, bottom:10),
                    child: Image.asset('assets/icon_no_white.png', scale:3),
                  ),
                  const Text(
                    "Junta-te ao Universo!",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  const Text(
                      "Preenche os campos com as tuas informações!",
                      style:TextStyle(
                          fontSize: 15
                      )),
                  const SizedBox(height: 20),
                  MyTextField(controller: emailController, hintText: 'Introduz o teu email da faculdade', obscureText: false, label: 'Email', icon: Icon(Icons.email_outlined),),
                  MyTextField(controller: nameController, hintText: 'Introduz o teu nome', obscureText: false, label: 'Nome', icon: Icon(Icons.person_outline),),
                  MyTextField(controller: passwordController, hintText: '', obscureText: true, label: 'Palavra-passe', icon: Icon(Icons.lock_outline),),
                  MyTextField(controller: passwordConfirmationController, hintText: 'Introduz novamente a palavra-passe', obscureText: true, label: 'Confirmação',icon: Icon(Icons.lock_outline),),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                  Navigator.of(context).pop();
                            if(kIsWeb) {
                              showDialog(
                                  context: context,
                                  builder: (_) => const AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.all(
                                            Radius.circular(10.0)
                                        )
                                    ),
                                    content: LoginPageWeb(),
                                  )
                              );
                            }
                            else Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                          },
                          child: Text(
                            "Já tenho conta",
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  isLoading
                      ? const SizedBox(
                      width: 150,
                      child: LinearProgressIndicator(
                        color: cPrimaryColor,
                        backgroundColor: cPrimaryOverLightColor,
                      )
                  )
                      :DefaultButtonSimple(
                      text: "REGISTAR",
                      press: () {
                        registerButtonPressed(idController.text, nameController.text, emailController.text, passwordController.text, passwordConfirmationController.text);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      height: 20),
                  if(!kIsWeb)
                    SizedBox(height:70)
                ],
              ),
            ),
          ),
        )
    );
  }
}
