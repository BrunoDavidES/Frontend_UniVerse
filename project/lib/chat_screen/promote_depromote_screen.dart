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

class PromoteDepromoteScreen extends StatefulWidget {
  final bool toPromote;
  final String forumID;
  final String username;
  PromoteDepromoteScreen({super.key, required this.toPromote, required this.forumID, required this.username});

  @override
  State<PromoteDepromoteScreen> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<PromoteDepromoteScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController usernameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    usernameController.text = widget.username;
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
    usernameController.dispose();
    super.dispose();
  }

  void actionButtonPressed(username) async {
    if (_source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para efetuares ações sobre este fórum precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      if (username.isEmpty) {
        showDialog(context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: "Ups!",
                descriptions: "Existem campos vazios. Preenche-os, por favor.",
                text: "OK",
              );
            }
        );
      } else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: widget.toPromote ?"O utilizador com o identificador $username, terá permissões de edição sobre este fórum. Confirmas?" :"O utilizador com o identificador $username deixará de ter permissões sobre este fórum. Confirmas?",
                    press: () async {
                      var response =await Chat.promote(widget.forumID, username); //:await Chat.
                      if (response == 200) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Sucesso!",
                                descriptions: "As permissões deste fórum foram atualizadas.",
                                text: "OK",
                              );
                            }
                        );
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
                      }else if (response == 404) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "Não encontrámos nenhum utilizador associado ao identificador que indicaste. Assegura-te que esse utilizador está registado na UniVerse.",
                                text: "OK",
                              );
                            }
                        );
                      }
                      else {
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
              widget.toPromote
              ? "Promover utilizador" :"Despromover utilizador",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cHeavyGrey,
                  fontSize: 20
              ),
            ),
            MyTextField(controller: usernameController, hintText: '', obscureText: false, label: 'ID Utilizador', icon: Icons.person_outlined,),
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
                    text: "PROMOVER",
                    color: cPrimaryColor,
                    press: () {
                      actionButtonPressed(usernameController.text);
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