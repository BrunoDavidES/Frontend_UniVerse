import 'package:UniVerse/components/confirm_dialog_box.dart';
import 'package:UniVerse/utils/users/user_data.dart';
import 'package:flutter/material.dart';

import '../../consts/color_consts.dart';
import '../web_menu_card.dart';

class WebMenu extends StatelessWidget {
  const WebMenu({
    super.key, required this.width, required this.height,

  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          width: width,
          height: height,
          margin: EdgeInsets.only(left:20, right:20, bottom: 20),
          child: ListView(
            children:  [
              Column(
                children: <Widget>[
                  WebMenuCard(text: 'O Meu Perfil', description: 'Vê e altera as tuas informações pessoais.', icon: Icons.person_outline),
                  WebMenuCard(text: 'QR Scan', description: 'Entra numa sala digitalizando o código QR na sua porta.', icon: Icons.qr_code_scanner_outlined),
                  WebMenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA.',icon: Icons.card_membership_outlined),
                  WebMenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus.',icon: Icons.report_outlined),
                  WebMenuCard(text: 'Fóruns', description: 'Encontra os teus fóruns aqui. Nunca foi tão fácil encontrar',icon: Icons.message_outlined),
                  WebMenuCard(text: 'Calendário', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                  WebMenuCard(text: 'Feedback', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                  WebMenuCard(text: 'Inquéritos', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                  WebMenuCard(text: 'Estatísticas', description: 'Entra numa sala digitalizando o código QR na sua porta',icon: Icons.account_circle_outlined),
                  WebMenuCard(text: 'Apagar Conta', description: '',icon: Icons.delete, press: () {
                    showDialog(
                        context: context,
                        builder: (_) => ConfirmDialogBox(descriptions: "Tens a certeza que pretendes eliminar a tua conta?", press: () {}),
                    );
                  },),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}