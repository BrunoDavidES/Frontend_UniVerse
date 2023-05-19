import 'dart:convert';

import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_web.dart';
import 'functions/auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  late TextEditingController idController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  late TextEditingController emailController;

  @override
  void initState() {
    idController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();

    super.initState();
  }

  void registerButtonPressed(String id, String email, String password, String confirmation) async {
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
    }
    else {
      var response = await Authentication.loginUser(id, password);
      if (response == 200) {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const UniverseInfoApp()));
      }else if(response == 404) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("O identificador fornecido não corresponde a nenhuma conta"),
            );
          },
        );
      } else if(response == 403) {
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
                  MyTextField(controller: emailController, hintText: "Email", obscureText: true,),
                  MyTextField(controller: passwordController, hintText: "Password", obscureText: true,),
                  MyTextField(controller: passwordConfirmationController, hintText: "Confirmação", obscureText: true,),
                  const SizedBox(height: 20),
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
                        registerButtonPressed(idController.text, emailController.text, passwordController.text, passwordConfirmationController.text);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      height: 20),
                  DefaultButton(
                    text: "LOGIN",
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
                            content: LoginPageWeb(),
                          )
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
