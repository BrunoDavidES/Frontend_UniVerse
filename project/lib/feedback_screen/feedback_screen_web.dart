import 'dart:io';
import 'package:UniVerse/utils/report/report_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/description_field.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/web/web_menu.dart';
import '../consts/color_consts.dart';
import '../login_screen/login_app.dart';
import '../utils/feedback/feedback_data.dart';

class FeedbackScreenWeb extends StatefulWidget {
  const FeedbackScreenWeb({Key? key}) : super(key: key);

  @override
  State<FeedbackScreenWeb> createState() => _FeedbackScreenWebState();
}

class _FeedbackScreenWebState extends State<FeedbackScreenWeb> {
  bool isLoading = false;
  late TextEditingController textController;
  double rating = 0;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void submitButtonPressed(text) async {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialogBox(
        descriptions:
        "A submissão é validada. Qualquer submissão inválida ou que desrespeite as nossas regras, resultará na suspensão da conta e no subsequente aviso aos serviços da faculdade.",
        press: () async {
          Navigator.pop(context);
          var response = await UniverseFeedback.post(text);
          if (response == 200) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Sucesso",
                  descriptions: "Já recebemos a tua submissão.",
                  text: "OK",
                  press: () {
                    if (kIsWeb) {
                      Navigator.pop(context);
                      context.go("/personal");
                    }
                  },
                );
              },
            );
          } else if (response == 401) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions:
                  "Parece que a tua sessão expirou. Precisamos que inicies sessão novamente.",
                  text: "OK",
                  press: () {
                    Navigator.pop(context);
                    if (kIsWeb)
                      context.go("/home");
                    else
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const LoginPageApp()));
                  },
                );
              },
            );
          } else {
            context.go("/error");
          }
        },
      ),
    );
  }

  Widget buildStarIcon(int index) {
    if (index < rating) {
      return Stack(
        children: [
          Icon(
            Icons.star,
            color: Colors.blue,
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
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        WebMenu(
          width: size.width / 9,
          height: size.height / 1.5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  "assets/titles/feedback.png",
                  scale: 4.5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                top: 15,
                bottom: 15,
              ),
              child: const Text(
                "Acreditamos que o Universo é para todos. Por isso, estamos abertos a sugestões e opiniões. Deixa-nos a tua!",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30,
                right: 10,
                bottom: 15,
              ),
              child: const Text(
                "(A tua submissão pode incluir feedback para a faculdade ou para a UniVerse)",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: cHeavyGrey,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: size.width / 2,
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 10,
              ),
              margin: EdgeInsets.only(
                left: 250,
                right: 100,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildStarRating(),
                  DescriptionField(
                    controller: textController,
                    label: '',
                    hint: "Diz-nos",
                    maxLength: 500,
                    maxLines: 10,
                  ),
                  isLoading
                      ? Container(
                    padding: EdgeInsets.all(10),
                    width: 150,
                    child: const LinearProgressIndicator(
                      color: cPrimaryColor,
                      backgroundColor: cPrimaryOverLightColor,
                    ),
                  )
                      : Column(
                    children: [
                      DefaultButtonSimple(
                        text: "SUBMETER",
                        color: cPrimaryColor,
                        press: () {
                          submitButtonPressed(textController.text);
                        },
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}