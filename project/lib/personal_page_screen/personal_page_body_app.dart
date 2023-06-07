import 'package:UniVerse/components/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/menu_card.dart';
import '../components/personal_app_card.dart';

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
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
    body: Column(
          children: <Widget>[
            SizedBox(height:10),
            PersonalAppCard(size: size),
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
                    height: size.height-375,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(left:10, top:5, right:10, bottom: 10),
                        itemCount:10,
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 10);
                        },
                        itemBuilder: (context, index) {
                          if(index == 0)
                          return MenuCard(text: 'QR Scan', description: 'Entra numa sala digitalizando o código QR na sua porta.', icon: Icons.qr_code_scanner_outlined);
                          else if(index==1)
                            return MenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined);
                          else if(index==2)
                            return MenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined);
                          else if(index==3)
                            return MenuCard(text: 'Fóruns', description: 'Encontra os teus fóruns aqui. Nunca foi tão fácil encontrar',icon: Icons.message_outlined);
                          else if(index==4)
                            return MenuCard(text: 'Calendário', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined);
                          else if(index==5)
                            return MenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined);
                          else if(index==6)
                            return MenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined);
                          else if(index==7)
                            return MenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined);
                          else if(index==8)
                            return MenuCard(text: 'Upload', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined);
                        }
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




