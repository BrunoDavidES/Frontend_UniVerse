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
import 'chat_screen_app.dart';

class EnterForumScreen extends StatefulWidget {
  final String forumName;
  EnterForumScreen({super.key, required this.forumName});

  @override
  State<EnterForumScreen> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<EnterForumScreen> {
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

  void joinButtonPressed(id, pwd) async {
    if (_source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para acederes a um fórum, precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = Chat.areCompliant(id, pwd);
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
      }
      else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: "Tens a certeza que prentendes aceder a este fórum?",
                    press: () async {
                      var response = await Chat.join(id, pwd);
                      if (response == 200) {
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ChatPageApp(
                                forumID: id, forumName: widget.forumName,),
                            ));
                      }
                      if (response == 401) {
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
                      } else if (response == 404) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Ups!",
                                descriptions: "O ID que introduziste não pertence a nenhum fórum. Contacta o admnistrador do fórum que procuras, de modo a certificares-te que tens as credencias corretas.",
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
                                descriptions: "O código de acesso para este fórum está errado.",
                                text: "OK",
                              );
                            }
                        );
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Error500()));
                      }
                    }
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Aceder a um Fórum",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cHeavyGrey,
                  fontSize: 20
              ),
            ),
            MyTextField(controller: nameController, hintText: '', obscureText: false, label: 'ID do Fórum', icon: Icons.numbers,),
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
                    text: "ACEDER",
                    color: cPrimaryColor,
                    press: () {
                      joinButtonPressed(nameController.text, pwdController.text);
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