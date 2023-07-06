import 'package:UniVerse/components/500.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../components/default_button_simple.dart';
import '../components/password_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../login_screen/login_web.dart';
import '../personal_page_screen/app/personal_page_app.dart';
import '../utils/connectivity.dart';
import '../utils/authentication/reg.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController passwordConfirmationController;
  late TextEditingController emailController;
  bool isLoading = false;

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
    super.dispose();
  }

  void registerButtonPressed(name, email, password, confirmation) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      setState(() {
        isLoading = false;
      });
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para te registares precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
    } else {
      bool areCompliant = Registration.areCompliant(email, name, password, confirmation);
      if (!areCompliant) {
        setState(() {
          isLoading = false;
        });
        showDialog(context: context,
            builder: (BuildContext context){
              return CustomDialogBox(
                title: "Ups!",
                descriptions: "Existem campos vazios. Preenche-os, por favor.",
                text: "OK",
              );
            }
        );
      }  else {
        areCompliant = Registration.match(password, confirmation);
        if (!areCompliant) {
          showDialog(context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "A confirmação da palavra-passe que introduziste está errada.",
                  text: "OK",
                );
              }
          );
        } else {
          var bytes = utf8.encode(password); // Convert text to bytes
          var digest = sha256.convert(bytes); // Perform SHA-256 hash
          var bytes2 = utf8.encode(confirmation); // Convert text to bytes
          var digest2 = sha256.convert(bytes2); // Perform SHA-256 hash
          //var response = await Registration.regist(digest.toString(), digest2.toString(), name, email, password);
          var response = await Registration.regist(password, confirmation, name, email, password);
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
                        context.go("/personal");
                      }else {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AppPersonalPage()));
                      }
                    },
                  );
                }
            );
            setState(() {
              isLoading = false;
            });
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
                    descriptions: "A palavra-passe não segue as restrições estabelecidas de, no mínimo, 6 caracteres, 1 número e 1 maiúscula.",
                    text: "OK",
                  );
                }
            );
          } else if (response == 400) {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "Ocorreu um erro inesperado. Tenta novamente, por favor.",
                    text: "OK",
                  );
                }
            );
          }
          else if (response == 401) {
            showDialog(context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "Parece que este e-mail já foi registado.",
                    text: "OK",
                  );
                }
            );
          }
          else {
            if(kIsWeb) {
              context.go("/error");
            } else {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
            }
          }
        }
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
          title: Image.asset("assets/titles/regist.png", scale:6),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          titleSpacing: 15,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top:10, left:20, right: 20, bottom:10),
                child: Image.asset('assets/images/icon_no_white.png', scale:3),
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
              Text(
                  "Todos os campos são obrigatórios.",
                  style:TextStyle(
                      fontSize: 13,
                    color: Colors.redAccent
                  )),
              const SizedBox(height: 20),
              MyTextField(controller: emailController, hintText: 'Introduz o teu email institucional', obscureText: false, label: 'E-mail', icon: Icons.email_outlined, ),
              MyTextField(controller: nameController, hintText: 'Introduz o teu nome', obscureText: false, label: 'Nome', icon: Icons.person_outline),
              MyPasswordField(controller: passwordController, hintText: '6 caracteres, 1 número, 1 maiúscula', obscureText: true, label: 'Palavra-passe', icon: Icons.lock_outline),
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
                        else {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                        }
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
                    setState(() {
                      isLoading = true;
                    });
                    if(nameController.text == "" || emailController == "" || passwordConfirmationController == "" || passwordController == "") {
                      setState(() {
                        isLoading = false;
                        showDialog(context: context,
                            builder: (BuildContext context){
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "Existem campos vazios. Preenche-os, por favor.",
                                text: "OK",
                              );
                            }
                        );
                      });
                    } else {
                        registerButtonPressed(nameController.text, emailController.text.trim(), passwordController.text, passwordConfirmationController.text);
                      }
                  },
                  height: 20),
              if(!kIsWeb)
                SizedBox(height:70)
            ],
          ),
        )
    );
  }
}
