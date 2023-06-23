import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/calendar_screen/calendar_screen_app.dart';
import 'package:UniVerse/components/text_field.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

import 'chat_screen_app.dart';

class ContactsScreenApp extends StatefulWidget {

  ContactsScreenApp({super.key});

  @override
  State<ContactsScreenApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ContactsScreenApp> {
  var contactName = "Nome do Contacto";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/app/area.png", scale: 6),
        leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: cDarkBlueColorTransparent);
            }
        ),
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: cDarkLightBlueColor
                )
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPageApp(receiverID: contactName,)));
                },
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black
                        ),
                      ),
                      Text(
                          contactName,
                        style: TextStyle(
                          fontSize: 17
                        ),
                      ),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}