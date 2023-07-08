import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/reset_pwd_screen/reset_password_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/default_button_simple.dart';
import '../components/password_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../reset_pwd_screen/reset_password_web.dart';
import '../utils/connectivity.dart';
import '../utils/authentication/auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController idController;
  late TextEditingController passwordController;
  bool isLoading = false;

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

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void logInButtonPressed(email, password) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return const CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para iniciares sessão precisas de te ligar a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else if (!Authentication.areCompliantToLogin(email, password)) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return const CustomDialogBox(
              title: "Ups!",
              descriptions: "Existem campos vazios. Preenche-os, por favor.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    }else {
        var bytes = utf8.encode(password); // Convert text to bytes
        var digest = sha256.convert(bytes); // Perform SHA-256 hash
        var response = await Authentication.login(email, digest.toString());
        if (response == 200) {
          if(kIsWeb) {
            Navigator.pop(context);
            context.go("/personal");
          }
          else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AppPersonalPage()));
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return const CustomDialogBox(
                  title: "Ups!",
                  descriptions: "O email e/ou password estão incorretos. Tenta novamente.",
                  text: "OK",
                );
              }
          );
          setState(() {
            isLoading = false;
          });
        } else {
          if(kIsWeb)
            context.go("/error");
          else
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Error500()));
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          title: Image.asset("assets/titles/login.png", scale:6),
          automaticallyImplyLeading: false,
          backgroundColor: cDirtyWhiteColor,
          titleSpacing: 15,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:20, left: 20, right: 20, bottom:10),
                child: Image.asset('assets/images/icon_no_white.png', scale:3),
              ),
              const Text(
                "Entra no Universo!",
                style: TextStyle(
                    fontSize: 25
                ),
              ),
              const SizedBox(height: 20),
              MyTextField(controller: idController, hintText: '', obscureText: false, label: 'E-mail', icon: Icons.person_outline,),
              MyPasswordField(controller: passwordController, hintText: '', obscureText: true, label: 'Palavra-passe', icon: Icons.lock_outline,),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      child: const Text(
                        "Esqueceste a palavra-passe?",
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
                        setState(() {
                          isLoading = true;
                        });
                        logInButtonPressed(idController.text.trim(), passwordController.text);
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
                              builder: (_) => AlertDialog(
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
        )
    );
  }
}