import 'package:UniVerse/calendar_screen/calendar_app.dart';
import 'package:UniVerse/components/grid_item.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'dart:io';

import '../components/500_app_with_bar.dart';
import '../components/menu_card.dart';
import '../components/personal_app_card.dart';
import '../report_screen/report_app.dart';
import '../report_screen/report_screen_app.dart';

final pageBucket = PageStorageBucket();

class PersonalPageBodyApp extends StatelessWidget {

  const PersonalPageBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController(initialScrollOffset: 5);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/area.png", scale:6),
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
    body: Column(
          children: <Widget>[
            SizedBox(height:10),
            PersonalAppCard(size: size),
            Container(
              child: InkWell(
                onTap: () {
                  var response = Authentication.revoge();
                  if(response==500)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Error500WithBar(i:3, img: Image.asset("assets/app/area.png", scale: 6,))));
                  else Navigator.of(context).pop();
                },
                child: Row(
                  children: [
                    Spacer(),
                    Text(
                      "SAIR",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: cHeavyGrey
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:20),
                      child: Icon(Icons.logout_outlined, color: cHeavyGrey,),
                    )
                  ],
                )
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:30, left: 20),
                    child: Text("MENU DE OPÇÕES",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: cHeavyGrey,
                      fontWeight: FontWeight.bold
                    )
                    ),
                  ),
                  Container(
                    height: size.height-380,
                    child: PageStorage(
                      bucket: pageBucket,
                      child: ListView.separated(
                        controller: _controller,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left:10, top:5, right:10, bottom: 10),
                          itemCount:10,
                          separatorBuilder: (context, index) {
                            return const SizedBox(width: 10);
                          },
                          itemBuilder: (context, index) {
                            if(index == 0)
                            return MenuCard(text: 'QR Scan', description: 'Entra numa sala digitalizando o código QR na sua porta.', icon: Icons.qr_code_scanner_outlined, press: () { },);
                            else if(index==1)
                              return MenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined, press: () { });
                            else if(index==2)
                              return MenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined, press: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportPageApp()));
                              });
                            else if(index==3)
                              return MenuCard(text: 'Fóruns', description: 'Encontra os teus fóruns aqui. Nunca foi tão fácil encontrar',icon: Icons.message_outlined, press: () { });
                            else if(index==4)
                              return MenuCard(text: 'Calendário', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                            else if(index==5)
                              return MenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                            else if(index==6)
                              return MenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                            else if(index==7)
                              return MenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                            else if(index==8)
                              return MenuCard(text: 'Upload', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                            else if(index==9)
                              return MenuCard(text: 'Calendário', description: 'Vê tudo o que tens para fazer no teu calendário',icon: Icons.calendar_month_outlined, press: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarPageApp()));
                              });
                          }
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
      ),
    );
  }
}




