
import 'package:UniVerse/components/text_field.dart';
import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/personal_page_screen/profile/profile_edit_page_web.dart';
import 'package:UniVerse/personal_page_screen/profile/profile_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/custom_shape.dart';
import '../../components/web_menu_card.dart';
import 'package:UniVerse/components/calendar_event_card.dart';
import 'package:UniVerse/consts/text_consts.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../utils/authentication/auth.dart';

class ProfileScreenWeb extends StatelessWidget {
  const ProfileScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WebMenu(width: size.width/9, height: size.height/1.5,)
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
                        child: Image.asset("assets/web/profile-title.png", scale: 4.5,)
                    ),
                  ),
                      SizedBox(
                        width: size.width/1.65,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Container(
                              height: 140,
                              width: 140,
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
                              padding: const EdgeInsets.only(top:30),
                              child: Column(
                                children: [
                                    Text("Nome Utilizador",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  SizedBox(height: 5,),
                                  Text("identificador",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: cHeavyGrey
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(width:50),

                             Padding(
                               padding: const EdgeInsets.only(top: 40),
                               child: Text("Role Principal",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                             ),
                                SizedBox(width:10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: Text("Função mais alta",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: cHeavyGrey
                                      ),
                                    ),
                              ),
                            Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "EDITAR",
                                  style: TextStyle(
                                    color: cHeavyGrey,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                IconButton(onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.0),
                                        ),
                                      ),
                                      content: ProfileEditPageWeb(),
                                    ),
                                  );
                                }, icon: Icon(Icons.edit_outlined, color: cHeavyGrey,)),
                              ],
                            )

                          ],
                        ),
                      ),
                ],
              ),
              Container(
                width: size.width-size.width/6.50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width:600,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:size.height/10),
                          MyReadOnlyField(icon: Icons.alternate_email, text: "Email: ", content: "identificador@campus.fct.unl.pt",),
                          MyReadOnlyField(icon: Icons.phone, text: "Telemóvel:", content: "+351 999999999",),
                          MyReadOnlyField(icon: Icons.insert_link, text: "LinkedIn:", content: "@",),
                          MyReadOnlyField(icon: Icons.work, text: "Gabinete:", content: "Gabinete 3.5/2",),
                          MyReadOnlyField(icon: Icons.directions_car_filled, text: "Matrícula:", content: "Sem registo",),
                        ],
                      ),
                    ),
                   Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text("Conta Ativa".toUpperCase(),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.green,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Text("Na UniVerse desde 11/07/2023",
                          style: TextStyle(
                            fontSize: 18,
                            color: cHeavyGrey.withOpacity(0.5)
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10),
                          child: Text("Conta Pública",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text("Departamento",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text("Núcleo (se tiver)",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    Spacer()
                  ],
                ),
              ),
              SizedBox(height:size.height/6)
            ],
          ),
      ],
    );
  }
}

class MyReadOnlyField extends StatelessWidget {
  final IconData icon;
  final String text;
  final String content;
  const MyReadOnlyField({
    super.key, required this.icon, required this.text, required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: cHeavyGrey),
          SizedBox(width: 5,),
          Text(
            text,
            style: TextStyle(
                fontSize: 15,
                color: cHeavyGrey
            ),
          ),
         Spacer(),
          Container(
            width: 450,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cDirtyWhiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: cHeavyGrey,
                width: 2
              )
            ),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 15,
                color: cHeavyGrey
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}