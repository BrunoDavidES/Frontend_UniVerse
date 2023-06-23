import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/calendar_screen/calendar_screen_app.dart';
import 'package:UniVerse/components/text_field.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class ChatPageApp extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;

  ChatPageApp({super.key, required this.receiverUserEmail, required this.receiverUserID});

  @override
  State<ChatPageApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ChatPageApp> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
          scrolledUnderElevation: 1,
          elevation: 0.0,
          leadingWidth: 20,
          leading: Builder(
              builder: (context) {
                return IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: cDarkBlueColorTransparent);
              }
          ),
          title: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/man.png"),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  "Bruno",
                  style: TextStyle(
                      color: cHeavyGrey
                  ),
                )
              ]
          ),
          backgroundColor: cDirtyWhiteColorNoOps,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           /* Expanded(
              child: buildMessageList(),
            ),*/
            buildList(size.width, size.height),
            buildInput(),
          ],
        )

    );
  }

  Widget buildList(double width, double height) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(7.5),
              padding: EdgeInsets.all(5),
              width: width/2+50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: cPrimaryOverLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Esta é a mensagem que recebes e aparece assim. Fixe não achas?"
              ),
            ),
            Container(
              margin: EdgeInsets.all(7.5),
              padding: EdgeInsets.all(5),
              width: width/2+50,
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: cPrimaryLightColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                  "Olá! Por acaso acho! Esta a resposta que podes mandar"
              ),
            )
          ]
        ),
    );
  }

  Widget buildInput() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:10, bottom: 10, top: 10),
            child: TextFormField(
              obscureText: false,
              controller: messageController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: cDarkLightBlueColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: cDarkLightBlueColor,
                      )
                  ),
                  fillColor: Colors.white60,
                  filled: true,
                hintText: "mensagem",
              ),
            ),
          ),
        ),
        IconButton(onPressed: () {}, icon: Icon(Icons.send_sharp, color: cDarkBlueColor,))
      ],
    );
  }
}