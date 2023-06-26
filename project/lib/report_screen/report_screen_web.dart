import 'dart:convert';
import 'dart:io';

import 'package:UniVerse/components/500_app.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/personal_page_body_app.dart';
import 'package:UniVerse/utils/camera/camera_screen.dart';
import 'package:UniVerse/utils/report/problem_report.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../Components/default_button.dart';
import '../components/500_app_with_bar.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../components/web_menu_card.dart';
import '../consts/color_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/connectivity.dart';

class ReportScreenWeb extends StatefulWidget {
  const ReportScreenWeb({super.key});

  @override
  State<ReportScreenWeb> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreenWeb> {
  bool isLoading = false;
  late TextEditingController titleController;
  late TextEditingController locationController;
  late TextEditingController descriptionController;
  Uint8List imageUint8 = Uint8List(8);
  File? pickedImage;

  @override
  void initState() {
    titleController = TextEditingController();
    locationController = TextEditingController();
    descriptionController = TextEditingController();
    super.initState();
  }

  void submitButtonPressed(String title, String location, String description) async {
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
                  descriptions: "Parece que não iniciaste sessão na tua conta.",
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
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:20, top:20, bottom: 5),
                child: Text(
                  "MENU DE OPÇÕES",
                  style:TextStyle(
                      color: cHeavyGrey,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              Container(
                decoration: BoxDecoration(
                    color: cDirtyWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow:[ BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0,0),
                    ),
                    ]
                ),
                alignment: Alignment.bottomCenter,
                width: size.width/9,
                height: size.height/1.25,
                margin: EdgeInsets.only(left:20, right:20, bottom: 20),
                child: ListView(
                  children:  [
                    Column(
                      children: <Widget>[
                        WebMenuCard(text: 'Logout', description: 'Vê e altera as tuas informações pessoais.', icon: Icons.logout_outlined),
                        WebMenuCard(text: 'O Meu Perfil', description: 'Vê e altera as tuas informações pessoais.', icon: Icons.person_outline),
                        WebMenuCard(text: 'QR Scan', description: 'Entra numa sala digitalizando o código QR na sua porta.', icon: Icons.qr_code_scanner_outlined),
                        WebMenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined),
                        WebMenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined),
                        WebMenuCard(text: 'Fóruns', description: 'Encontra os teus fóruns aqui. Nunca foi tão fácil encontrar',icon: Icons.message_outlined),
                        WebMenuCard(text: 'Calendário', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                        WebMenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                        WebMenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                        WebMenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                        WebMenuCard(text: 'Upload', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/app/report.png", scale: 4.5,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 10, top:15, bottom: 15),
                  child: const Text(
                    "Encontraste um problema no campus? Preenche os campos abaixo para que possamos conhecer a situação e agir o mais rapidamente possível.",
                    textAlign: TextAlign.justify,
                  ),
                ),
               Container(
                 alignment: Alignment.center,
                      height: size.height/1.25,
                      width: size.width/2,
                      padding: const EdgeInsets.only(left: 20, right:20, top: 10),
                      margin: EdgeInsets.only(left: 100, right: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                          Container(
                            margin: EdgeInsets.only(left: 40),
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
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if(image!=null) {
                                var f = await image.readAsBytes();
                                imageUint8= f;
                                setState(() {
                                  pickedImage = File("a");
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 25, top: 10),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left:5),
                                    child: Icon(Icons.camera_alt_outlined, color: cHeavyGrey.withOpacity(0.6),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left:12),
                                    child: pickedImage!=null
                                        ?Container(
                                      height: size.width/8,
                                      width: size.width/4,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Image.memory(imageUint8, fit: BoxFit.scaleDown, scale: 5),
                                    )
                                        : Text(
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
                        ],
                      )
                  ),
                //MyTextField(controller: locationController, hintText: '', obscureText: true, label: 'Palavra-passe', icon: Icon(Icons.lock_outline),),
              ]
          ),

        ]
    );


  }
}