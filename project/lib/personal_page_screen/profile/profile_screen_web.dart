
import 'package:UniVerse/components/text_field.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';
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
                                Text(
                                  "EDITAR",
                                  style: TextStyle(
                                    color: cHeavyGrey,
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                IconButton(onPressed: () {}, icon: Icon(Icons.edit_outlined, color: cHeavyGrey,)),
                              ],
                            )
                          ],
                        ),
                      ),

                ],
              ),
              MyReadOnlyField(icon: Icons.alternate_email, text: "Email do utilizador",),
              MyReadOnlyField(icon: Icons.phone, text: "+351 999999999",),
              SizedBox(height:size.height/2)
            ],
          ),
      ],
    );
  }
}

class MyReadOnlyField extends StatelessWidget {
  final IconData icon;
  final String text;
  const MyReadOnlyField({
    super.key, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: cHeavyGrey),
          SizedBox(width: 5,),
          Container(
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
              text,
              style: TextStyle(
                fontSize: 15,
                color: cHeavyGrey
              ),
            ),
          )
        ],
      ),
    );
  }
}