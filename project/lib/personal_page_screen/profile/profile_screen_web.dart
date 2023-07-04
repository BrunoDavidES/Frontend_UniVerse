
import 'package:UniVerse/components/text_field.dart';
import 'package:UniVerse/components/web/web_menu.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/custom_shape.dart';
import '../../components/web_menu_card.dart';
import 'package:UniVerse/components/calendar_event_card.dart';
import 'package:UniVerse/consts/text_consts.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../utils/authentication/auth.dart';

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
            WebMenu(width: size.width/9, height: size.height/1.75,)
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
                        width: size.width/1.75,
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
                               child: Text("Funcionário",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                             ),
                                SizedBox(width:10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 45),
                                child: Text("Divisão Académica",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: cHeavyGrey
                                      ),
                                    ),
                              ),
                            Spacer(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 45),
                                  child: Text(
                                    "EDITAR",
                                    style: TextStyle(
                                      color: cHeavyGrey,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 45.0),
                                  child: IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined, color: cHeavyGrey,)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(left: size.width/5),
                child: Column(
                  children: [
                    SizedBox(height:size.height/10),
                    MyReadOnlyField(icon: Icons.alternate_email, text: "Email: ", content: "identificador@campus.fct.unl.pt",),
                    MyReadOnlyField(icon: Icons.phone, text: "Telemóvel:", content: "+351 999999999",),
                    MyReadOnlyField(icon: Icons.work, text: "Trabalho:", content: "Estudante",),
                    MyReadOnlyField(icon: Icons.car_repair, text: "Matricula:", content: "Sem registo",),
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
          SizedBox(width: 5,),
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