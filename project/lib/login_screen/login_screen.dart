import 'dart:async';
import 'dart:convert';

import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/utils/network_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../personal_page_screen/personal_page_app.dart';
import '../utils/connectivity.dart';
import 'functions/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void initState() {
    idController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  void logInButtonPressed(String id, String password) async {
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
            MaterialPageRoute(builder: (context) => PersonalPageApp()));
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
                  Text(
                    "Junta-te ao Universo!",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  ),
                  Text(
                      "Insere as tuas credenciais do clip.",
                      style:TextStyle(
                          fontSize: 15
                      )),
                  SizedBox(height: 20),
                  MyTextField(controller: idController, hintText: "identificador", obscureText: false,),
                  MyTextField(controller: passwordController, hintText: "senha", obscureText: true,),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        UrlLaunchableItem(
                          text:"Esqueceste a senha?", url: 'https://clip.fct.unl.pt/recuperar_senha', color: Colors.black
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  isLoading
                      ? Container(
                      width: 150,
                      child: LinearProgressIndicator(
                        color: cPrimaryColor,
                        backgroundColor: cPrimaryOverLightColor,
                      )
                  )
                      : DefaultButtonSimple(
                      text: "ENTRAR",
                      press: () {
                        logInButtonPressed(idController.text, passwordController.text);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      height: 20),
                ],
              ),
            ),
          ),
        )
    );
  }
}
