
import 'package:UniVerse/login_screen/login_web.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../utils/connectivity.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ResetScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController emailController;
  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void resetButtonPressed(email) async {
    if (!kIsWeb && _source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para repores a tua palavra-passe precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      if (email.isEmpty) {
        showDialog(context: context,
            builder: (BuildContext context) {
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
        var response = Authentication.reset(email);
        if(response==404)
          showDialog(context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que o e-mail que indicaste não está associado a nenhum utilizador registado na UniVerse.",
                  text: "OK",
                );
              }
          );
        else showDialog(context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Sucesso",
                descriptions: "Enviámos um e-mail para poderes redefinir a tua palavra-passe.",
                text: "OK",
              );
            }
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
                padding: EdgeInsets.only(top:20, left: 20, right: 20, bottom:10),
                child: Image.asset('assets/images/icon_no_white.png', scale:3),
              ),
              const Text(
                "Redefine a tua palavra-passe!",
                style: TextStyle(
                    fontSize: 25
                ),
              ),
              const Text(
                  "Indica-nos o e-mail com o qual te registaste.",
                  style:TextStyle(
                      fontSize: 15
                  )),
              const SizedBox(height: 20),
              MyTextField(controller: emailController, hintText: '', obscureText: false, label: 'E-mail', icon: Icons.person_outline,),
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
                                content: LoginPageWeb(),
                              )
                          );
                        }
                        else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                      },
                      child: Text(
                        "Iniciar sessão",
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
                      text: "REDEFINIR",
                      color: cPrimaryColor,
                      press: () {
                        resetButtonPressed(emailController.text);
                        setState(() {
                          isLoading = true;
                        });
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