import 'dart:convert';
import 'dart:io';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/components/password_field.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../components/confirm_dialog_box.dart';
import '../../components/default_button_simple.dart';
import '../../components/simple_dialog_box.dart';
import '../../components/text_field.dart';
import '../../consts/color_consts.dart';
import '../../login_screen/login_app.dart';
import '../../register_screen/register_app.dart';
import '../../register_screen/register_web.dart';
import '../../utils/authentication/auth.dart';
import '../../utils/connectivity.dart';


class ModifyPasswordScreen extends StatefulWidget {
  const ModifyPasswordScreen({super.key});

  @override
  State<ModifyPasswordScreen> createState() => _ModifyPasswordState();
}

class _ModifyPasswordState extends State<ModifyPasswordScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController oldPwdController;
  late TextEditingController newPwdController;
  late TextEditingController confirmationController;
  bool isLoading = false;

  @override
  void initState() {
    oldPwdController = TextEditingController();
    newPwdController = TextEditingController();
    confirmationController = TextEditingController();
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

  void submitButtonPressed(oldPwd, newPwd, confirmation) async {
    if (!kIsWeb && _source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para alterares a tua palavra-passe precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else if(!Authentication.areCompliantToModify(oldPwd, newPwd, confirmation)) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ups!",
              descriptions: "Existem campos vazios. Preenche-os, por favor.",
              text: "OK",
            );
          }
      );
    } else if(!Authentication.match(newPwd)) {
      showDialog(context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: "Ups!",
              descriptions: "A nova palavra-passe não segue as restrições estabelecidas de, no mínimo, 6 caracteres, 1 número e 1 maiúscula.",
              text: "OK",
            );
          }
      );
    } else if(!Authentication.areEqual(newPwd, confirmation)) {
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
      showDialog(
          context: context,
          builder: (_) =>
              ConfirmDialogBox(
                  descriptions: "Tens a certeza que queres atualizar a tua palavra-passe na UniVerse?",
                  press: () async {
                    var bytes = utf8.encode(oldPwd); // Convert text to bytes
                    var digest = sha256.convert(bytes); // Perform SHA-256 hash
                    var bytes2 = utf8.encode(newPwd); // Convert text to bytes
                    var digest2 = sha256.convert(bytes2);
                    var response = await Authentication.updatePwd(digest.toString(), digest2.toString());
                    if (response == 200) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Sucesso",
                              descriptions: "Já atualizámos a tua palavra-passe",
                              text: "OK",
                            );
                          }
                      );
                    } else if (response == 401) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Ups!",
                              descriptions: "Parece que a tua sessão expirou. Precisamos que inicies sessão novamente, por favor.",
                              text: "OK",
                            );
                          }
                      );
                    } else if (response == 400) {
                      showDialog(context: context,
                          builder: (BuildContext context) {
                            return CustomDialogBox(
                              title: "Ups!",
                              descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                              text: "OK",
                            );
                          }
                      );
                    } else {
                      if (kIsWeb)
                        context.go("/error");
                      else
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => Error500()));
                    }
                  }
              )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: kIsWeb
            ?AppBar(
          title: Image.asset("assets/titles/modify_pwd.png", scale:5),
          backgroundColor: cDirtyWhiteColor,
          automaticallyImplyLeading: false,
          titleSpacing: 15,
          elevation: 0,
        )
            :AppBar(
          title: Image.asset("assets/titles/modify_pwd.png", scale:4),
          backgroundColor: cDirtyWhiteColor,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {Navigator.pop(context);},
                    color: cDarkLightBlueColor);
              }
          ),
          leadingWidth: 20,
          titleSpacing: 15,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Todos os campos são obrigatórios.",
                style:TextStyle(
                  fontSize: 13,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              MyPasswordField(controller: oldPwdController, hintText: '', obscureText: true, label: 'Palavra-passe atual', icon: Icons.lock_outline),
              MyPasswordField(controller: newPwdController, hintText: '6 caracteres, 1 número, 1 maiúscula', obscureText: true, label: 'Nova Palavra-passe', icon: Icons.lock_outline),
              MyPasswordField(controller: confirmationController, hintText: 'Introduz novamente a palavra-passe nova', obscureText: true, label: 'Confirmação', icon: Icons.lock_outline),
              const SizedBox(height: 20),
              isLoading
                  ? Row(
                children: [
                  Spacer(),
                  Container(
                      width: 150,
                      child: const LinearProgressIndicator(
                        color: cPrimaryColor,
                        backgroundColor: cPrimaryOverLightColor,
                      )
                  ),
                ],
              )
                  : Row(
                children: [
                  Spacer(),
                  if(kIsWeb)
                    DefaultButtonSimple(
                        text: "CANCELAR",
                        color: cPrimaryColor,
                        press: () {
                          Navigator.pop(context);
                        },
                        height: 20),
                  DefaultButtonSimple(
                      text: "CONFIRMAR",
                      color: cPrimaryColor,
                      press: () {
                        submitButtonPressed(oldPwdController.text, newPwdController.text, confirmationController.text);
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