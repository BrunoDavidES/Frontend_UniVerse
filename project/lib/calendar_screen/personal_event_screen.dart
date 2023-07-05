import 'dart:convert';
import 'dart:ui';

import 'package:UniVerse/calendar_screen/personal_event_web.dart';

import '../components/confirm_dialog_box.dart';
import '../login_screen/login_app.dart';
import '../utils/events/personal_event_data.dart';
import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/reset_pwd_screen/reset_password_app.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../personal_page_screen/web/personal_page_web.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';
import 'package:intl/intl.dart';

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

  void submitButtonPressed(String title, String location, String date, String time) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para iniciares sessão precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      /*bool areControllersCompliant = Authentication.isCompliant(id, password);
      if (!areControllersCompliant) {
        showDialog(context: context,
            builder: (BuildContext context){
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
        var response = await Authentication.loginUser(id, password);
        if (response == 200) {
          if(kIsWeb) {
            Navigator.pushNamed(context, "/personal/main");
          }
          else Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppPersonalPage()));
        } else if (response==401) {
          showDialog(context: context,
              builder: (BuildContext context){
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "O email e/ou password estão incorretos. Tenta novamente.",
                  text: "OK",
                );
              }
          );
        } else {
          if(kIsWeb)
            Navigator.popAndPushNamed(context, "/error");
          else
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500WithBar(i:3, title: Image.asset("assets/app/login.png", scale: 6,))));
        }
      }*/
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
                      showDialog(
                          context: context,
                          builder: (_) => ConfirmDialogBox(descriptions: "Tens a certeza que pretendes eliminar este evento?", press: () {
                            final response = CalendarEvent.delete(widget.data.id!, widget.data.date!);
                            if(response == 200)
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AppHomePage()));
                            else showDialog(
                                context: context,
                                builder: (_) => CustomDialogBox(
                                    title: "Ups!",
                                    descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente para conseguires aceder à UniVerse.",
                                    text: "OK",
                                    press: () {
                                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                                    }
                                )
                            );
                          },));
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