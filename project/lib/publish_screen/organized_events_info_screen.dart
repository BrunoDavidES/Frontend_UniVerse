import 'dart:convert';
import 'dart:ui';

import '../../components/default_button_simple.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/events/event_data.dart';
import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/reset_pwd_screen/reset_password_app.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';

class OrganizedEventInfo extends StatefulWidget {
  final Event data;
  const OrganizedEventInfo({super.key, required this.data});

  @override
  State<OrganizedEventInfo> createState() => _EventScreenState();
}

class _EventScreenState extends State<OrganizedEventInfo> {
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
    Size size = MediaQuery.of(context).size;
    double width;
    if(kIsWeb)
      width = size.width/3;
    else
      width = size.width;
    return SizedBox(
      height: size.height/4,
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            "Capacidade de ${widget.data.capacity!} pessoas",
            style: TextStyle(
              color: cHeavyGrey,
              fontSize: 15,
            ),
          ),
          SizedBox(height:5),
          Text(
            "${widget.data.startDate!} · ${widget.data.endDate!}",
            style: TextStyle(
              color: cHeavyGrey,
              fontSize: 15,
            ),
          ),
          Spacer(),
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
                DefaultButtonSimple(
                    text: "EDITAR",
                    color: cDarkLightBlueColor,
                    press: () {

                    },
                    height: 20),
              DefaultButtonSimple(
                  text: "EXCLUIR",
                  color: cDarkLightBlueColor,
                  press: () {
                    //Função de eliminar
                  },
                  height: 20),
            ],
          ),
        ],
      ),
    );
  }
}