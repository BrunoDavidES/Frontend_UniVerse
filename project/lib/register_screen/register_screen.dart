import 'dart:convert';

import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/default_button_simple.dart';
import '../components/password_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../login_screen/login_web.dart';
import '../personal_page_screen/app/personal_page_app.dart';
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmationController.dispose();
    _connectivity.disposeStream();
    super.dispose();
  }

  void registerButtonPressed(String id, String name, String email, String password, String confirmation) async {
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
    } else {
      bool areControllersCompliant = Registration.isCompliant(email, name, password, confirmation);
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
        areControllersCompliant =
            Registration.areCompliant(password, confirmation);
        if (!areControllersCompliant) {
          showDialog(context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "A confirmação da palavra-passe está errada",
                  text: "OK",
                );
              }
          );
          setState(() {
            isLoading = false;
          });
        } else {
          var response = await Registration.registUser(
              password, confirmation, name, email);
          print(response);
          if (response == 200) {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Registo com sucesso",
                    descriptions: "Damos-te as boas-vindas ao Universo!\nEnviámos um e-mail para que possas confirmar a tua conta.",
                    text: "OK",
                    press: () {
                      if(kIsWeb) {
                        Navigator.pop(context);
                        context.go("/personal/main");
                      }else
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppPersonalPage()));
                    },
                  );
                }
            );
          } else if (response == 400) {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "O email indicado já foi registado.",
                    text: "OK",
                  );
                }
            );
          } else if (response == 00) {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "O email indicado não é válido.",
                    text: "OK",
                  );
                }
            );
          } else if (response == 01) {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "A palavra-passe não está de acordo com as restrições estabelecidas.",
                    text: "OK",
                  );
                }
            );
          }
          else {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) =>
                    Error500WithBar(i: 3,
                        title: Image.asset(
                          "assets/app/registo.png", scale: 6,))));
          }
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
                  MyTextField(controller: emailController, hintText: 'Introduz o teu email institucional', obscureText: false, label: 'Email', icon: Icons.email_outlined, ),
                  MyTextField(controller: nameController, hintText: 'Introduz o teu nome', obscureText: false, label: 'Nome', icon: Icons.person_outline),
                  MyPasswordField(controller: passwordController, hintText: 'No mínimo: 6 caracteres, 1 número, 1 maíuscula', obscureText: true, label: 'Palavra-passe', icon: Icons.lock_outline),
                  MyPasswordField(controller: passwordConfirmationController, hintText: 'Introduz novamente a palavra-passe', obscureText: true, label: 'Confirmação',icon: Icons.lock_outline),
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
                            "Já tenho uma conta",
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
                      color: cPrimaryColor,
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
