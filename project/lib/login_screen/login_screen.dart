import 'dart:convert';

import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/default_button_simple.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/api_consts.dart';
import '../consts/color_consts.dart';
import '../info/universe_info_app.dart';
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

  void logInButtonPressed(String id, String password) {
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
    else
      loginUser(id, password);
      /*var statusCode = Authentication.loginUser(id, password);
      if (statusCode == 200) {
        // TODO: Update the DB with the last active time of the user

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AppHomePage()),
        );
      } else if (statusCode == 403) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Wrong Password!"),
            );
          },
        );
      }*/
    }

    void loginUser(String id, String password) async {
        try {
          final response = await http.post(
            Uri.parse(baseUrl+login),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'username': id,
              'password': password,
            }),
          );
          if (response.statusCode == 200) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Testing 200"),
                    content: Text("Testing content for dialog"),
                  );
                }
            );
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UniverseInfoApp()));
            //print(jsonDecode(response.body));
          } else if(response.statusCode == 403) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Testing 200"),
                    content: Text("Testing content for dialog"),
                  );
                }
            );
          }
        } catch(e) {
          print(e.toString());
        }
        setState(() {
          isLoading = false;
        });
    }

    @override
    Widget build(BuildContext context) {
    bool isDone = true;
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
                            text:"Esqueceste a senha?", url: 'https://clip.fct.unl.pt/recuperar_senha',
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
