import 'package:UniVerse/components/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/menu_card.dart';

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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      cPrimaryLightColor,
                      Colors.green,
                    ],
                  ),
                //color: cPrimaryLightColor,
                  boxShadow: [ BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0,0),
            ),
          ]
              ),
              height: 175,
              width: size.width-30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:10, left: 13, bottom:5),
                    child: Text(
                      "Olá, Francisco",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, bottom:5),
                    child: Text(
                      "Aluno",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: cDirtyWhiteColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, bottom:5),
                    child: Text(
                      "Departamento de Informática",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: cDirtyWhite.withOpacity(0.75),
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(

                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2, top: 5),
                        child: Text(
                            "O MEU PERFIL",
                          style: TextStyle(
                            color: cHeavyGrey.withOpacity(0.75),
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset("assets/app/dot.png", scale: 2, alignment: Alignment.bottomRight),
                      ),
                    ],
                  )
                ],
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



