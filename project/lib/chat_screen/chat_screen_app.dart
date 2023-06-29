import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/calendar_screen/calendar_screen_app.dart';
import 'package:UniVerse/components/text_field.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

import'package:UniVerse/utils/chat/chat_utils.dart';

class ChatPageApp extends StatefulWidget {
  final String receiverID;

  ChatPageApp({super.key, required this.receiverID,});

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
                SizedBox(width: 5),
                Text(
                  widget.receiverID,
                  style: TextStyle(
                      color: Colors.black
                  ),
                )
              ]
          ),
          backgroundColor: cDirtyWhiteColorNoOps,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              focal: Alignment.bottomCenter,
              focalRadius: 0.1,
              center: Alignment.bottomCenter,
              radius: 0.65,
              colors: [
                cPrimaryOverLightColor,
                cDirtyWhiteColor,
              ],
            ),
          ),
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.all(7.5),
                        padding: EdgeInsets.all(5),
                        width: size.width/ 2 + 75,
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: cHeavyGrey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Esta é a mensagem que se recebe e aparece assim.",
                          style: TextStyle(
                              color: cDirtyWhiteColor
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Spacer(),
                          Container(
                            margin: EdgeInsets.all(7.5),
                            padding: EdgeInsets.all(5),
                            width: size.width / 2 + 75,
                            alignment: Alignment.centerRight,
                            decoration: BoxDecoration(
                              color: cPrimaryOverLightColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                                "Enviando uma mensagem, o utilizador sabe que o fez desta forma!"
                            ),
                          ),
                        ],
                      )
                    ]
                ),
              ),
              Spacer(),
              buildInput(),
            ],
          ),
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
              width: width / 2 + 50,
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: cHeavyGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Esta é a mensagem que recebes e aparece assim. Fixe não achas?",
                style: TextStyle(
                    color: cDirtyWhiteColor
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(7.5),
              padding: EdgeInsets.all(5),
              width: width / 2 + 50,
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
    void sendMessage() {
      String message = messageController.text;
      String senderId = "halo";
      String recipientId = "jota";

      // Call the sendMessage function from chat_utils.dart
      ChatUtils.sendMessage(senderId, recipientId, message);

      // Clear the message text field
      messageController.clear();
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
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
                fillColor: Colors.white,
                filled: true,
                hintText: "mensagem",
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: Icon(Icons.send_sharp, color: cDarkBlueColor),
        )
      ],
    );
  }
}