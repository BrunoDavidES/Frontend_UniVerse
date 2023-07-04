import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:image_picker/image_picker.dart';

import '../Components/default_button.dart';
import '../components/app/500_app_with_bar.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../components/url_launchable_item.dart';
import '../components/web_menu_card.dart';
import '../consts/color_consts.dart';
import '../consts/list_consts.dart';
import '../info_screen/universe_info_app.dart';
import '../login_screen/login_app.dart';
import '../register_screen/register_app.dart';
import '../register_screen/register_web.dart';
import '../utils/chat/chat_utils.dart';
import '../utils/connectivity.dart';
import 'chat_screen_app.dart';

class ChatScreenWeb extends StatefulWidget {
  const ChatScreenWeb({super.key});

  @override
  State<ChatScreenWeb> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreenWeb> {
  var contactName = "Nome do Contacto";
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  /*void submitButtonPressed(String title, String location, String description) async {
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
    setState(() {
      isLoading = false;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Random random = Random();
    int cindex = random.nextInt(toRandom.length);
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
                      child: Image.asset("assets/titles/messages.png", scale: 4.5,)
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      height: size.height-100,
                      width: size.width/3,
                      child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Conversas".toUpperCase(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: cHeavyGrey
                                    )
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                          color: toRandom[cindex],
                                      )
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPageApp(forumID: contactName, forumName: '',)));
                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(5),
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black
                                          ),
                                        ),
                                        Text(
                                          contactName,
                                          style: TextStyle(
                                              fontSize: 17
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                      ),
                    SizedBox(width:20),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: cHeavyGrey
                        ),
                        gradient: RadialGradient(
    focal: Alignment.bottomCenter,
    focalRadius: 0.1,
    center: Alignment.bottomCenter,
    radius: 0.55,
    colors: [
    cPrimaryOverLightColor,
    cDirtyWhiteColor
    ],
    ),
    ),
                      height: size.height-100,
                      width: size.width - size.width/9 - size.width/3 -120,
                      child: Column(
                        children: [
                          Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: AssetImage("assets/man.png"),
                                          fit: BoxFit.cover
                                      )
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Nome do contacto",
                                  style: TextStyle(
                                      color: Colors.black,
                                    fontSize: 15
                                  ),
                                )
                              ]
                          ),
                          SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(7.5),
                                    padding: EdgeInsets.all(5),
                                    width: size.width - size.width/9 - size.width/3 -120,
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                      color: cHeavyGrey.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "Esta é a mensagem que recebes e aparece assim. Fixe não achas?",
                                      style: TextStyle(
                                          color: cDirtyWhiteColor
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Spacer(),
                                      Container(
                                        margin: EdgeInsets.all(7.5),
                                        padding: EdgeInsets.all(5),
                                        width: size.width - size.width/9 - size.width/3 -120 + 75,
                                        alignment: Alignment.centerRight,
                                        decoration: BoxDecoration(
                                          color: cPrimaryOverLightColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Expanded(
                                          child: Text(
                                              "Olá! Por acaso acho! Esta a resposta que podes mandar"
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ]
                            ),
                          ),
                          Spacer(),
                          buildInput(),
                        ],
                      ),
                    )
                  ],
                )
              ]
          ),

        ]
    );


  }
  Widget buildInput() {
    void sendMessage() {
      String message = messageController.text;
      String senderId = "halo";
      String recipientId = "jota";

      // Call the sendMessage function from chat_utils.dart
      ChatUtils.sendMessage(recipientId, message);

      // Clear the message text field
      messageController.clear();
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: TextFormField(
              obscureText: false,
              controller: messageController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: cDarkLightBlueColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: cDarkLightBlueColor,
                    )
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: "mensagem",
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: Icon(Icons.send_sharp, color: cDarkBlueColor),
        )
      ],
    );
  }
}


