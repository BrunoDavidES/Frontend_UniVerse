import 'package:UniVerse/bars/app_bar.dart';
import 'package:UniVerse/calendar_screen/calendar_screen_app.dart';
import 'package:UniVerse/components/text_field.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

import '../utils/chat/chat_utils.dart';
import 'chat_screen_app.dart';

class ContactsScreenApp extends StatefulWidget {
  ContactsScreenApp({super.key});

  @override
  State<ContactsScreenApp> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreenApp> {
  String joinForumID = "";
  String joinForumPassword = "";
  String createForumName = "";
  String createForumPassword = "";

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
              color: cDarkBlueColorTransparent,
            );
          },
        ),
        leadingWidth: 20,
        backgroundColor: cDirtyWhiteColor,
        titleSpacing: 15,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    'Join Forum',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        joinForumID = value;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Forum ID',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        joinForumPassword = value;
                      });
                    },
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ChatUtils.joinForum(joinForumID, joinForumPassword);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPageApp(
                            forumID: joinForumID, forumName: 'TEST',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text(
                      'Join',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    'Create Forum',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        createForumName = value;
                      });
                    },
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Forum Name',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        createForumPassword = value;
                      });
                    },
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      String createForumID = await ChatUtils.createForum(createForumName, createForumPassword);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPageApp(
                            forumID: createForumID, forumName: 'TEST',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    child: Text(
                      'Create',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
