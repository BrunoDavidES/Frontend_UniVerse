import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../components/500.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/description_field.dart';
import '../components/simple_dialog_box.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../personal_page_screen/app/personal_page_app.dart';
import '../utils/chat/chat_utils.dart';
import '../utils/connectivity.dart';

class MessagePopUp extends StatefulWidget {
  final String text;
  final String forumID;
  final String postID;

  const MessagePopUp({
    super.key, required this.text, required this.forumID, required this.postID,
  });

  @override
  State<MessagePopUp> createState() => _MyMessagePopUpState();
}

class _MyMessagePopUpState extends State<MessagePopUp> {
  bool isLoading = false;
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    messageController.text = widget.text;
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
    messageController.dispose();
    super.dispose();
  }

  void deleteButtonPressed(forumID, postID) async {
    if (_source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para excluires esta mensagem, precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    }  else {
        showDialog(
            context: context,
            builder: (_) =>
                ConfirmDialogBox(
                    descriptions: "Tens a certeza que pretendes excluir esta mensagem?",
                    press: () async {
                      var response = await Chat.deletePost(forumID, postID);
                      if (response == 200) {
                        showDialog(context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                title: "Sucesso!",
                                descriptions: "A mensagem foi excluída.",
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
                      } else if (response == 404) {
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
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                      }
                    }
                ));
      }
    }

  void editButtonPressed(forumID, postID, message) async {
    if (_source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para editares esta mensagem, precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    }  else {
      showDialog(
          context: context,
          builder: (_) =>
              ConfirmDialogBox(
                  descriptions: "Tens a certeza que pretendes editar esta mensagem?",
                  press: () async {
                    var response = await Chat.editPost(forumID, postID, message);
                    if (response == 200) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Sucesso!",
                              descriptions: "A mensagem foi editada.",
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
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                    }
                  }
              ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            DescriptionField(label: "", max: 500, controller: messageController),
            const SizedBox(height: 15),
            isLoading
                ? Container(
                width: 150,
                child: const LinearProgressIndicator(
                  color: cPrimaryColor,
                  backgroundColor: cPrimaryOverLightColor,
                ))
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
                    text: "EDITAR",
                    color: cPrimaryColor,
                    press: () {
                      editButtonPressed(widget.forumID, widget.postID, messageController.text);
                    },
                    height: 10),
                DefaultButtonSimple(
                    text: "EXCLUIR",
                    color: cPrimaryColor,
                    press: () {
                      deleteButtonPressed(widget.forumID, widget.postID);
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
