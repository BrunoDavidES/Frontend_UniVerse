import 'package:UniVerse/Components/default_button.dart';
import 'package:UniVerse/components/text_field.dart';
import 'package:UniVerse/main_screen/homepage_web.dart';
import 'package:flutter/material.dart';

import '../components/default_button_simple.dart';
import '../components/url_launchable_icon_item.dart';
import '../components/url_launchable_item.dart';
import '../consts.dart';
import 'functions/auth.dart';
import 'login_app.dart';
import 'login_screen.dart';

class LoginPageBodyApp extends StatefulWidget {

  const LoginPageBodyApp({super.key});

  @override
  State<LoginPageBodyApp> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPageBodyApp> {
  late TextEditingController idController;
  late TextEditingController passwordController;

  @override
  void initState() {
    idController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  void logInButtonPressed(String email, String password) {
    //TODO: Also check the email
    bool pwCompliant = Authentication.isPasswordCompliant(password);

    if (!pwCompliant) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: LoginPageApp(),
          );
        },
      );
    }
    // TODO: Check if the User can be logged in.
    //  API Call to your GoogleAppEngine or Dummy API
    else if (Authentication.loginUser(email, password)) {

      // TODO: Update the DB with the last active time of the user
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Logged In successfully"),
          );
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WebHomePage()),
      );
    } else {
      // Wrong credentials
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text("Wrong Password!"),
          );
        },
      );
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
                              text:"Esqueceste a senha?", url: 'https://clip.fct.unl.pt/recuperar_senha',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    DefaultButtonSimple(
                        text: "ENTRAR"
                        , press: () => logInButtonPressed(idController.text, passwordController.text)
                        , height: 20),
                  ],
                ),
              ),
            ),
        )
    );

  }
}