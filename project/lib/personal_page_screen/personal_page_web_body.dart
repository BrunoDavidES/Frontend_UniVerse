import 'package:UniVerse/components/personal_web_card.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:UniVerse/personal_page_screen//left_side.dart';
import 'package:UniVerse/find_screen/findTest/right_side.dart';
import 'package:UniVerse/main_screen/components/about_bottom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:UniVerse/consts/api_consts.dart';

import '../components/web_menu_card.dart';
import '../main_screen/components/about_bottom_body.dart';
import '../report_screen/report_screen_app.dart';
import '../report_screen/report_screen_web.dart';

class PersonalWebBody extends StatefulWidget {
  const PersonalWebBody({super.key});

  @override
  State<PersonalWebBody> createState() => PersonalWebBodyState();
}

class PersonalWebBodyState extends State<PersonalWebBody> {
  late int op;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height:size.height+size.height/7,
        color: cDirtyWhite,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/web/area.png", scale: 8,)
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20, bottom: 20),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Image.asset("assets/app/report.png", scale: 4,)
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height,
                  width: size.width/7.5,
                  child: ListView(
                    children:  [
                      Column(
                        children: <Widget>[
                          WebMenuCard(
                            text: 'Logout',
                            description: 'Vê e altera as tuas informações pessoais.',
                            icon: Icons.logout_outlined,
                            press: () async {
                              final response = await http.post(
                                Uri.parse(baseUrl + logoutUrl),
                              );
                              print(response.statusCode);
                              return response.statusCode;
                            },
                          ),
                          WebMenuCard(text: 'O Meu Perfil', description: 'Vê e altera as tuas informações pessoais.', icon: Icons.person_outline, press: () {
                            Authentication.validateLogin();
                          },),
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
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: cHeavyGrey),
                      boxShadow: [ BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0,0),
                      ),
                      ],
                      color: cDirtyWhiteColor
                  ),
                  height: size.height,
                  width: size.width-size.width/7.5-40,
                  child: ReportScreenWeb(),
                )
              ],
            ),
          ],
        ),




        /*Column(
          children: [
            Row(
              children: [
               SizedBox(
                    height: size.height+115,
                    width: size.width/7.5,
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
                Padding(
                  padding: const EdgeInsets.only(left:20, right: 20),
                  child: Container(
                    height: size.height+115,
                    width: size.width-size.width/7.5-40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, bottom: 30),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset("assets/web/area.png", scale: 8,)
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 30),
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Image.asset("assets/app/report.png", scale: 4,)
                              ),
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.cyan,
                          height: size.height,
                          width: size.width-size.width/7.5-40
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),*/
      ),
    );
  }
}