
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../components/custom_shape.dart';
import '../../components/web_menu_card.dart';
import 'package:UniVerse/components/calendar_event_card.dart';
import 'package:UniVerse/consts/text_consts.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../login_screen/functions/auth.dart';

class ProfileScreenWeb extends StatefulWidget {
  const ProfileScreenWeb({super.key});

  @override
  State<ProfileScreenWeb> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreenWeb> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.height);
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
              height: size.height/1.75,
              margin: EdgeInsets.only(left:15, right:20, bottom: 20),
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
                      WebMenuCard(text: 'Calendário', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () {
    if(!Authentication.userIsLoggedIn)
    Navigator.pushNamed(context, "/home");
    else Navigator.pushNamed(context, "/personal/calendar");
                      }),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
                    child: Container(
                        alignment: Alignment.centerLeft,
                        child: Image.asset("assets/web/perfil-web.png", scale: 4.5,)
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 140,
                        width: 140,
                        margin: EdgeInsets.only(left:80, top: 10),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: cDirtyWhite, width: 5),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/man.png")
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80),
                        child: Text("Bruno David",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left:80),
                        child: Text("bm.david",
                          style: TextStyle(
                              fontSize: 15,
                              color: cHeavyGrey
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              ),
              SizedBox(height:size.height/2)
            ],
          ),
      ],
    );
  }
}