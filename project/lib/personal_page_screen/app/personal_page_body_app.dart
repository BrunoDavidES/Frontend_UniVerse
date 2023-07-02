import 'package:UniVerse/calendar_screen/calendar_app.dart';
import 'package:UniVerse/components/app/grid_item.dart';
import 'package:UniVerse/login_screen/functions/auth.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/personal_page_screen/profile/profile_page_app.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'dart:io';

import '../../chat_screen/chat_app.dart';
import '../../components/app/500_app_with_bar.dart';
import '../../components/app/menu_card.dart';
import '../../publish_screen/publish_app.dart';
import '../components/info.dart';
import '../components/personal_card.dart';
import '../../report_screen/report_app.dart';
import '../../report_screen/report_screen_app.dart';
import '../../utils/users/user_data.dart';

final pageBucket = PageStorageBucket();

class PersonalPageBodyApp extends StatelessWidget {

  const PersonalPageBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/area.png", scale:6),
        automaticallyImplyLeading: false,
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
        actions: [
         InkWell(
                onTap: () {
                  var response = Authentication.revoge();
                  if(response==500)
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Error500WithBar(i:3, title: Image.asset("assets/app/area.png", scale: 6,))));
                  else Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AppHomePage()));
                },
                child:Center(
                  child: Padding(
                          padding: const EdgeInsets.only(right:10),
                          child: Text(
                            "SAIR",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: cHeavyGrey
                            ),
                          ),
                        ),
                ),
                    ),
        ],
      ),
    body: Column(
          children: <Widget>[
            PersonalCard(size: size),
            //!User.isVerified() || !User.isActive()
          //  ?Info()
                Menu(size: size)
          ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:30, left: 20),
          child: Text("MENU DE OPÇÕES",
              style: TextStyle(
                color: cHeavyGrey,
            fontWeight: FontWeight.bold
          )
          ),
        ),
        Container(
          height: size.height/2.75,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount:12,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: (context, index) {
                if(index == 0)
                return MenuCard(text: 'APAGAR', description: '', icon: Icons.delete, press: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Error500WithBar(i: 1, title: Image.asset("assets/app/report.png", scale: 6,),)));
                },);
                else if(index==1)
                  return MenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined, press: () { });
                else if(index==2)
                  return MenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportPageApp()));
                  });
                else if(index==3)
                  return MenuCard(text: 'Fóruns', description: 'Acede a fóruns informativos do que se passa na FCT',icon: Icons.message_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatScreenApp()));
                  });
                else if(index==4)
                  return MenuCard(text: 'APAGAR', description: '',icon: Icons.delete, press: () { });
                else if(index==5)
                  return MenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                else if(index==6)
                  return MenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                else if(index==7)
                  return MenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined, press: () { });
                else if(index==8)
                  return MenuCard(text: 'APAGAR', description: '',icon: Icons.delete, press: () { });
                else if(index==9)
                  return MenuCard(text: 'Calendário', description: 'Vê tudo o que tens para fazer no teu calendário',icon: Icons.calendar_month_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarPageApp()));
                  });
                else if(index==10)
                  return MenuCard(text: 'O meu perfil', description: 'Vê o teu perfil',icon: Icons.person_outline, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfilePageApp()));
                  });
                else if(index==11)
                  return MenuCard(text: 'Organizar evento', description: 'Organiza um evento na faculdade de forma fácil e rápida',icon: Icons.event_available_outlined, press: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppPublishPage()));
                  });
              }
          ),
        ),
      ],
    );
  }
}




