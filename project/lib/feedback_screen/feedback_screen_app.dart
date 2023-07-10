import 'dart:io';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/components/description_field.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../utils/connectivity.dart';
import '../utils/feedback/feedback_data.dart';


class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => FeedbackScreenState();
}

class FeedbackScreenState extends State<FeedbackScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late TextEditingController textController;
  bool isLoading=false;
  double rating = 0;

  @override
  void initState() {
    textController=TextEditingController();
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

  void submitButtonPressed(text) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para submeteres feedback precisamos que te ligues a uma rede.",
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
          builder: (_) => ConfirmDialogBox(
              descriptions: "A submissão é validada. Qualquer submissão inválida ou que desrespeite as nossas regras, resultará na suspensão da conta e no subsequente aviso aos serviços da faculdade.",
              press: () async {
                Navigator.pop(context);
                var response = await UniverseFeedback.post(text);
                if (response == 200) {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            title: "Sucesso",
                            descriptions: "Já recebemos a tua submissão.",
                            text: "OK",
                            press: () {
                              if(kIsWeb) {
                                Navigator.pop(context);
                                context.go("/personal");
                              } else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const PersonalPageBodyApp()));
                            }
                        );
                      }
                  );
                } else if (response==401) {
                  showDialog(context: context,
                      builder: (BuildContext context) {
                        return CustomDialogBox(
                            title: "Ups!",
                            descriptions: "Parece que a tua sessão expirou. Precisamos que inicies sessão novamente.",
                            text: "OK",
                            press: () {
                              Navigator.pop(context);
                              if(kIsWeb)
                                context.go("/home");
                              else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                            }
                        );
                      }
                  );
                }  else {
                  if(kIsWeb)
                    context.go("/error");
                  else
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
                }
              }
          )
      );
    }
  }

  Widget buildStarIcon(int index) {
    if (index < rating) {
      return Stack(
        children: [
          Icon(
            Icons.star,
            color: cPrimaryLightColor,
          ),
          Positioned.fill(
            child: Icon(
              Icons.star_border,
              color: Colors.black,
            ),
          ),
        ],
      );
    } else {
      return Icon(
        Icons.star_border,
        color: Colors.black,
      );
    }
  }

  Widget buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              rating = index + 1.toDouble();
            });
          },
          child: buildStarIcon(index),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: kIsWeb
            ?AppBar(
          title: Image.asset("assets/titles/edit.png", scale:6),
          backgroundColor: cDirtyWhiteColor,
          automaticallyImplyLeading: false,
          titleSpacing: 15,
          elevation: 0,
        )
            :AppBar(
          title: Image.asset("assets/titles/feedback.png", scale:6),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
                    child: const Text(
                      "Acreditamos que o Universo é para todos. Por isso, estamos abertos a sugestões e opiniões. Deixa-nos a tua!",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
                    child: const Text(
                      "(A tua submissão pode incluir feedback para a faculdade ou para a UniVerse)",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          color: cHeavyGrey
                      ),
                    ),
                  ),
                  buildStarRating(),
                  DescriptionField(controller: textController, label: '', hint:"Diz-nos",maxLength: 500, maxLines: 10,),
                  const SizedBox(height: 20),
                  isLoading
                      ? Container(
                      padding: EdgeInsets.all(10),
                      width: 150,
                      child: const LinearProgressIndicator(
                        color: cPrimaryColor,
                        backgroundColor: cPrimaryOverLightColor,
                      )
                  )
                      : Column(
                    children: [
                      DefaultButtonSimple(
                          text: "SUBMETER",
                          color: cPrimaryColor,
                          press: () {
                            submitButtonPressed(textController.text);
                          },
                          height: 20),
                    ],
                  ),
                ]
            )
        )
    );
  }
}