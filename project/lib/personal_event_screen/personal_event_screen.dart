
import 'dart:ui';
import 'package:UniVerse/personal_event_screen/personal_event_web.dart';
import 'package:go_router/go_router.dart';

import '../components/500.dart';
import '../components/confirm_dialog_box.dart';
import '../login_screen/login_app.dart';
import '../utils/events/personal_event_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../consts/color_consts.dart';
import '../utils/connectivity.dart';
import '../utils/user/user_data.dart';

class PersonalEventScreen extends StatefulWidget {
  final CalendarEvent data;
  const PersonalEventScreen({super.key, required this.data});

  @override
  State<PersonalEventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<PersonalEventScreen> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;


  @override
  void initState() {
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void buttonPressed(id, date) async {
    if (!kIsWeb && _source.keys.toList()[0] == ConnectivityResult.none) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: "Sem internet",
            descriptions:
            "Parece que não estás ligado à internet! Para excluires este evento da tua agenda, precisamos que te ligues a uma rede.",
            text: "OK",
          );
        },
      );
      setState(() {
        isLoading = false;
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ConfirmDialogBox(
            descriptions: "Tens a certeza que pretendes eliminar este evento?",
            press: () {
            Navigator.pop(context);
            final response = CalendarEvent.delete(
                widget.data.id!, widget.data.date!);
            if (response == 200) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Sucesso!",
                    descriptions: "O evento foi eliminado",
                    text: "OK",
                  );
                },
              );
            } else if (response == 401) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente, por favor.",
                    text: "OK",
                    press: () {
                      if (kIsWeb) {
                        context.go("/home");
                      } else {
                        Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => const LoginPageApp(),
                        ));
                      }
                    },
                  );
                },
              );
            } else if (response == 400) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: "Ups!",
                    descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                    text: "OK",
                  );
                },
              );
            } else {
              if (kIsWeb) {
                context.go("/error");
              } else {
                Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => Error500()));
              }
            }
            },
          );
        },
      );
    }
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Text(
              widget.data.title!,
              style: TextStyle(
                color: cHeavyGrey,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic
              ),
            ),
            SizedBox(height:5),
            Text(
              widget.data.location!,
              style: TextStyle(
                  color: cHeavyGrey,
                  fontSize: 15,
              ),
            ),
            SizedBox(height:5),
                Text(
                  "${widget.data.date!} · ${widget.data.hour!}",
                  style: TextStyle(
                      color: cHeavyGrey,
                      fontSize: 15,
                  ),
                ),
            SizedBox(height:5),
            widget.data.authorUsername==UniverseUser.getUsername()
            ?Text(
              "Evento Pessoal",
              style: TextStyle(
                color: cHeavyGrey,
                fontSize: 12,
              ),
            )
            :Text(
              "Organizado por ${widget.data.department!}",
              style: TextStyle(
                color: cHeavyGrey,
                fontSize: 12,
              ),
            ),
            SizedBox(height:20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DefaultButtonSimple(
                    text: "CANCELAR",
                    color: cDarkLightBlueColor,
                    press: () {
                      Navigator.pop(context);
                    },
                    height: 20),
                if(widget.data.authorUsername==UniverseUser.getUsername())
                DefaultButtonSimple(
                    text: "EDITAR",
                    color: cDarkLightBlueColor,
                    press: () {
                      showDialog(
                          context: context,
                          builder: (_) => Dialog(
                          backgroundColor: cDirtyWhiteColor,
                          shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(
                          Radius.circular(10.0)
                      )
                      ),
                      child: PersonalEventWeb(toCreate: true, toEdit: true, data: widget.data/*focusDay: focusedDay*/)
                      ));
                    },
                    height: 20),
                DefaultButtonSimple(
                    text: "EXCLUIR",
                    color: cDarkLightBlueColor,
                    press: () {
                      buttonPressed(widget.data.id, widget.data.date);
                    },
                    height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}