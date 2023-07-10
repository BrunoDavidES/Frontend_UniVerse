import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../components/500.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/password_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../personal_page_screen/app/personal_page_app.dart';
import '../utils/chat/chat_utils.dart';
import '../utils/connectivity.dart';

class CreateForumScreen extends StatefulWidget {
  CreateForumScreen({super.key});

  @override
  State<CreateForumScreen> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<CreateForumScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController nameController;
  late TextEditingController pwdController;
  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController();
    pwdController = TextEditingController();
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
    nameController.dispose();
    pwdController.dispose();
    super.dispose();
  }

  void createButtonPressed(name, pwd) async {
    if (_source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para criares um fórum, precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = Chat.areCompliant(name, pwd);
      if (!areControllersCompliant) {
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
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: "O fórum com o nome $name e código de acesso $pwd será criado.",
                    press: () async {
                      Navigator.pop(context);
                      setState(() {
                        isLoading = true;
                      });
                      var response = await Chat.create(name, pwd);
                      if (response == 200) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Sucesso!",
                                descriptions: "Um novo fórum do qual és administrador foi criado.\nID:${Chat.idCreated}\nCÓDIGO DE ACESSO: $pwd",
                                text: "OK",
                              );
                            }
                        ); setState(() {
                          isLoading = false;
                        });

                      } else if (response == 401) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                  title: "Ups!",
                                  descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente, por favor.",
                                  text: "OK",
                                  press: () {
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(
                                        builder: (
                                            context) => const LoginPageApp()));
                                  });
                            }
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } else if (response == 400) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                                text: "OK",
                                press: () {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (
                                              context) => const AppPersonalPage()));
                                },
                              );
                            }
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } else if (response == 403) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "Parece que não tens permissões para esta operação.",
                                text: "OK",
                              );
                            }
                        );
                        setState(() {
                          isLoading = false;
                        });
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                      }
                    }
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Criar um Fórum",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cHeavyGrey,
                  fontSize: 20
              ),
            ),
            MyTextField(controller: nameController, hintText: '', obscureText: false, label: 'Nome do Fórum', icon: Icons.title,),
            MyPasswordField(controller: pwdController, hintText: "", obscureText: true, label: 'Código de Acesso', icon: Icons.lock_outline),
            const SizedBox(height: 15),
            isLoading
                ? Container(
                width: 150,
                child: const LinearProgressIndicator(
                  color: cPrimaryColor,
                  backgroundColor: cPrimaryOverLightColor,
                )
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButtonSimple(
                    text: "CANCELAR",
                    color: cPrimaryColor,
                    press: () {
                      Navigator.pop(context);
                    },
                    height: 10),
                DefaultButtonSimple(
                    text: "CRIAR",
                    color: cPrimaryColor,
                    press: () {
                      createButtonPressed(nameController.text, pwdController.text);
                    },
                    height: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}