import 'dart:convert';

import 'package:UniVerse/components/500.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_body_app.dart';
import 'package:UniVerse/utils/camera/camera_screen.dart';
import 'package:UniVerse/utils/report/problem_report.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';

class ReportScreenApp extends StatefulWidget {
  const ReportScreenApp({super.key});

  @override
  State<ReportScreenApp> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreenApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    super.initState();
  }

  void submitButtonPressed(String title, String location, String description) async {
    if(!kIsWeb && _source.keys.toList()[0]==ConnectivityResult.none) {
      showDialog(context: context,
          builder: (BuildContext context){
            return CustomDialogBox(
              title: "Sem internet",
              descriptions: "Parece que não estás ligado à internet! Para reportares um problema precisamos que te ligues a uma rede.",
              text: "OK",
            );
          }
      );
      setState(() {
        isLoading = false;
      });
    } else {
      bool areControllersCompliant = Report.isCompliant(title, location, description);
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
      //else if(File.isEmpty)
      else{
        var response = await Report.send(
            title, location, description);
        if (response == 200) {
          showDialog(context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Obrigado!",
                  descriptions: "Já recebemos a tua submissão.",
                  text: "OK",
                );
              }
          );
        } else if (response == 403) {
          showDialog(context: context,
              builder: (BuildContext context) {
                return CustomDialogBox(
                  title: "Ups!",
                  descriptions: "Parece que não iniciaste sessão na tua conta. Precisamos que o faças",
                  text: "OK",
                  press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                  }
                );
              }
          );
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) =>
                  Error500WithBar(i: 3,
                      title: Image.asset(
                        "assets/app/login.png", scale: 6,))));
        }
        }
      }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          title: Image.asset("assets/app/report.png", scale:6),
          automaticallyImplyLeading: false,
          backgroundColor: cDirtyWhiteColor,
          titleSpacing: 15,
          elevation: 0,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {Navigator.pop(context);},
                    color: cDarkBlueColorTransparent);
              }
          ),
          leadingWidth: 20,
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10, top:15, bottom: 15),
                    child: const Text(
                      "Encontraste um problema no campus? Preenche os campos abaixo para que possamos conhecer a situação e agir o mais rapidamente possível.",
                      textAlign: TextAlign.justify,
                    ),
                  ),
            Container(
              padding: const EdgeInsets.only(left: 20, right:20, top: 10),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      maxLength: 25,
                      controller: titleController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.title_outlined),
                        hintText: 'Introduz um título',
                      ),
                    ),
                    TextFormField(
                      maxLength: 50,
                      controller: locationController,
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.location_on_outlined),
                        hintText: 'Indica onde encontraste o problema',
                      ),
                    ),
              ]
                ),
              ),
            ),
                Container(
                  margin: EdgeInsets.only(left: 20, right:20, top: 10),
                  padding: const EdgeInsets.only(left: 10, right:10),
                  child: TextField(
                    maxLength: 100,
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    decoration: InputDecoration(
                        hintText: "Introduz a descrição do problema",
                    ),
                  ),
                ),
                  InkWell(
                    onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CameraScreen()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(left: 20, right:20, top: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:5),
                            child: Icon(Icons.camera_alt_outlined, color: cHeavyGrey.withOpacity(0.6),),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:12),
                            child: Text(
                              "Adiciona uma imagem aqui",
                              style: TextStyle(
                                  color: cHeavyGrey.withOpacity(0.9)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    //MyTextField(controller: locationController, hintText: '', obscureText: true, label: 'Palavra-passe', icon: Icon(Icons.lock_outline),),
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
                              submitButtonPressed(titleController.text, locationController.text, descriptionController.text);
                            },
                            height: 20),
                      ],
                    ),
  ]
          ),
        )
    );
  }
}