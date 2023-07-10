import 'package:UniVerse/calendar_screen/calendar_app.dart';
import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/feedback_screen/feedback_app.dart';
import 'package:UniVerse/modify_password_screen/modify_password_app.dart';
import 'package:UniVerse/profile_screen/profile_app.dart';
import 'package:UniVerse/utils/authentication/auth.dart';
import 'package:UniVerse/main_screen/app/homepage_app.dart';
import 'package:UniVerse/proof_screen/proof_screen.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';
import '../../foruns_screen/forum_app.dart';
import '../../components/500.dart';
import '../../components/app/menu_card.dart';
import '../../components/confirm_dialog_box.dart';
import '../../components/simple_dialog_box.dart';
import '../../login_screen/login_app.dart';
import '../../publish_screen/publish_app.dart';
import '../components/info.dart';
import '../components/personal_card.dart';
import '../../report_screen/report_app.dart';
import '../../utils/user/user_data.dart';

class PersonalPageBodyApp extends StatelessWidget {

  const PersonalPageBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/titles/area.png", scale:5),
        automaticallyImplyLeading: false,
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              var response = Authentication.revoke();
              if(response==500)
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Error500()));
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
          !UniverseUser.isVerified() || !UniverseUser.isActive()
              ?Info()
              :Menu(size: size)
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
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:30, left: 20, bottom: 5),
            child: Text("MENU DE OPÇÕES",
                style: TextStyle(
                    color: cHeavyGrey,
                    fontWeight: FontWeight.bold
                )
            ),
          ),
          Container(
            height: size.height/1.75,
            width: size.width-30,
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
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount:13,
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemBuilder: (context, index) {
                  if(index == 0)
                    //if(UniverseUser.getRole()=="BO")
                    return MenuCard(text: 'Gestão de Backoffice', description: '',icon: Icons.manage_accounts_outlined, press: () {
                      showDialog(
                          context: context,
                          builder: (_) => Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(10.0)
                                )
                            ),
                            child: InfoPopUp(text: "disponível no nosso website.",),
                          )
                      );
                    });
                  if(index == 1)
                    return MenuCard(text: 'O meu perfil', description: 'Vê o teu perfil e edita as tuas informações',icon: Icons.person_outline, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileApp()));
                    });
                  else if(index==2)
                    return MenuCard(text: 'Comprovativo', description: 'Acede ao comprovativo da tua vinculação com a FCT NOVA',icon: Icons.card_membership_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProofScreen()));
                    });
                  else if(index==3)
                    return MenuCard(text: 'Calendário', description: 'Tem à mão a tua agenda para te organizares facilmente',icon: Icons.calendar_month_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => CalendarPageApp()));
                    });
                  else if(index==4)
                    return MenuCard(text: 'Fóruns', description: 'Acede a fóruns informativos e mantém-te informado',icon: Icons.message_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ForumScreenApp()));
                    });
                  else if(index==5)
                    return MenuCard(text: 'Reportar', description: 'Reporta um problema que encontraste no campus',icon: Icons.report_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReportPageApp()));
                    });
                  else if(index==6)
                    return MenuCard(text: 'Organizar evento', description: 'Organiza um evento na faculdade de forma fácil e rápida',icon: Icons.event_available_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => AppPublishPage()));
                    });
                  else if(index==7)
                    return MenuCard(text: 'Feedback', description: 'A tua opiião é importante para nós. Submete-a aqui',icon: Icons.bar_chart_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => FeedbackPageApp()));
                    });
                  else if(index==8)
                    return MenuCard(text: 'Mudar Palavra-passe',description: '', icon: Icons.password_outlined, press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ModifyPwdPageApp()));
                    });
                  else if(index==9)
                    return MenuCard(text: 'Apagar Conta', description: '',icon: Icons.delete, press: () {
                      showDialog(
                          context: context,
                          builder: (_) => ConfirmDialogBox(descriptions: "Tens a certeza que pretendes eliminar a tua conta?", press: () {
                            final response = UniverseUser.delete();
                            if(response == 200)
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AppHomePage()));
                            else if(response ==401)
                              showDialog(
                                  context: context,
                                  builder: (_) => CustomDialogBox(
                                      title: "Ups!",
                                      descriptions: "Parece que a tua sessão expirou. Inicia sessão novamente para conseguires aceder à UniVerse.",
                                      text: "OK",
                                      press: () {
                                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPageApp()));
                                      }
                                  )
                              );
                            else if(response == 400)
                              showDialog(context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogBox(
                                      title: "Ups!",
                                      descriptions: "Aconteceu um erro inesperado! Por favor, tenta novamente.",
                                      text: "OK",
                                    );
                                  }
                              );
                            else Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) => Error500()));
                          }));
                    }
                    );
                  else if(index==10)
                    return SizedBox(height: 70,);
                }),
          )],
      ),
    );
  }
}




