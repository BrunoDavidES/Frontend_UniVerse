import 'package:UniVerse/components/confirm_dialog_box.dart';
import 'package:UniVerse/modify_password_screen/modify_password_page_web.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../personal_event_screen/personal_event_web.dart';
import '../../consts/color_consts.dart';
import '../simple_dialog_box.dart';
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
                  WebMenuCard(text: 'Gestão de Backoffice', icon: Icons.manage_accounts_outlined, press: () {
                    launchUrl(Uri.parse("https://universe-fct.oa.r.appspot.com/backoffice/index.html"));
                  },),
                  WebMenuCard(text: 'O Meu Perfil', icon: Icons.person_outline, press: () {
                    context.go('/personal/profile');
                  }),
                  WebMenuCard(text: 'Comprovativo', icon: Icons.card_membership_outlined, press: () {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          child: QRPopUp(text: "Acede ao teu comprovativo na nossa aplicação!",),
                        )
                    );
                  },),
                  WebMenuCard(text: 'Calendário',icon: Icons.calendar_month_outlined, press: () {
                    context.go("/personal/calendar");
                  },),
                  WebMenuCard(text: 'Fóruns',icon: Icons.message_outlined, press: () {
                    showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          child: QRPopUp(text: "Acede aos fórus na nossa aplicação!",),
                        )
                    );
                  },),
                  WebMenuCard(text: 'Reportar',icon: Icons.report_outlined, press: () {
                    context.go("/report");
                  },),
                  WebMenuCard(text: 'Organizar Evento',icon: Icons.event_available_outlined, press: () {
                    context.go("/events/submit");
                  },),
                  WebMenuCard(text: 'Feedback',icon: Icons.bar_chart_outlined),
                  WebMenuCard(text: 'Mudar Palavra-passe',icon: Icons.password_outlined, press: () {
                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(
                                  Radius.circular(10.0)
                              )
                          ),
                          content: ModifyPasswordPageWeb(),
                        ));
                  }),
                  WebMenuCard(text: 'Apagar Conta',icon: Icons.delete, press: () {
                    showDialog(
                        context: context,
                        builder: (_) => ConfirmDialogBox(descriptions: "Tens a certeza que pretendes eliminar a tua conta?", press: () {
                          final response = UniverseUser.delete();
                          if(response == 200)
                            context.go('/home');
                          else showDialog(
                              context: context,
                              builder: (_) => CustomDialogBox(
                                  title: "Ups!",
                                  descriptions: "Parece que não iniciaste sessão na tua conta. Precisamos que o faças",
                                  text: "OK",
                                  press: () {
                                    context.go('/home');
                                  }
                              )
                          );
                        },));
                  }
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class QRPopUp extends StatelessWidget {
  final String text;
  const QRPopUp({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            cDirtyWhiteColor,
            cDirtyWhite,
            cPrimaryOverLightColor.withOpacity(0.4),
            cPrimaryLightColor.withOpacity(0.5)
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text.toUpperCase(),
            style: TextStyle(
                color: cPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Image.asset("assets/web/Example.png", scale: 10,),
          Text("Digitaliza o código QR para instalares a aplicação.",
            style: TextStyle(
                color: cHeavyGrey
            ),),
          Spacer(),
        ],
      ),
    );
  }
}

class SoonPopUp extends StatelessWidget {
  const SoonPopUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 300,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            cDirtyWhiteColor,
            cDirtyWhite,
            cPrimaryOverLightColor.withOpacity(0.4),
            cPrimaryLightColor.withOpacity(0.5)
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Brevemente Disponível na UniVerse".toUpperCase(),
            style: TextStyle(
                color: cPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}