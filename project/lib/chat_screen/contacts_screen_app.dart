import 'dart:async';

import 'package:UniVerse/chat_screen/enter_forum_screen.dart';
import 'package:UniVerse/components/password_field.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_app.dart';
import 'package:UniVerse/personal_page_screen/app/personal_page_body_app.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../components/500.dart';
import '../components/confirm_dialog_box.dart';
import '../components/default_button_simple.dart';
import '../components/simple_dialog_box.dart';
import '../components/text_field.dart';
import '../consts/color_consts.dart';

import '../info_fct_screen/info_app.dart';
import '../login_screen/login_app.dart';
import '../personal_event_screen/personal_event_app.dart';
import '../utils/chat/chat_utils.dart';
import '../utils/connectivity.dart';
import 'chat_screen_app.dart';
import 'create_forum_screen.dart';

class ContactsScreenApp extends StatefulWidget {

  ContactsScreenApp({super.key});

  @override
  State<ContactsScreenApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ContactsScreenApp> {
  Map _source = {ConnectivityResult.none: false};
  final ConnectivityChecker _connectivity = ConnectivityChecker.instance;
  late StreamSubscription _forumStream;
  final StreamController<dynamic> _forumStreamController = StreamController<dynamic>();
  bool isLoading = false;

  @override
  void initState() {
    _connectivity.initialize();
    _connectivity.myStream.listen((source) {
      setState(() {
        _source = source;
      });
    });
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID != null) {
      _forumStream = FirebaseDatabase.instance
          .ref()
          .child('users/${userID.replaceAll(".", "-")}/forums/')
          .onValue
          .listen((event) {
        var snapshot = event.snapshot;
        var children = snapshot.value as Map<dynamic, dynamic>;

        _forumStreamController.add(children);
      });
    }
    super.initState();
  }

  @override
  void deactivate() {
    _forumStream.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cDirtyWhiteColor,
      appBar: AppBar(
        title: Image.asset("assets/titles/messages.png", scale: 6),
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
      body: Stack(
        children: [
          if (_source.keys.toList()[0] == ConnectivityResult.none)
            Text("SEM INTERNET")

          else StreamBuilder(
          stream: _forumStreamController.stream,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Error500()));
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return Info();
            }

            var forums = snapshot.data as Map<dynamic, dynamic>;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: forums.entries.map((entry) {
                      var forumID = entry.key;
                      var forumData = entry.value;
                      var forumName = forumData['name'];
                      return ForumCard(data: entry);
                        },).toList(),
                  ),
                  SizedBox(height: 200,)
                ],
              ),
            );
          },
        ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Button1(),
              Button2(),
              SizedBox(
                height:70
              )
            ],
          ),
      ]
      ),

    );
  }
}

class Button2 extends StatelessWidget {
  const Button2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:10, right: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
              color: cDarkBlueColorTransparent,
              borderRadius: BorderRadius.circular(15)
          ),
          child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                      backgroundColor: cDirtyWhiteColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(
                              Radius.circular(10.0)
                          )
                      ),
                      child: EnterForumScreen()
                  )
              );},
              child: Text(
                "ACEDER A UM FÓRUM",
                style: TextStyle(
                    color: cDirtyWhiteColor
                ),
              )
          ),
        ),
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  const Button1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:10, right: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: BoxDecoration(
              color: cDarkBlueColorTransparent,
              borderRadius: BorderRadius.circular(15)
          ),
          child: TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    backgroundColor: cDirtyWhiteColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(
                            Radius.circular(10.0)
                        )
                    ),
                    child: CreateForumScreen()
                  )
              );
            },
            child: Text(
             "CRIAR UM FÓRUM",
              style: TextStyle(
                color: cDirtyWhiteColor
              ),
            )
          ),
        ),
      ),
    );
  }
}

class ForumCard extends StatelessWidget {
  const ForumCard({
    super.key, this.data,
  });

  final data;

  @override
  Widget build(BuildContext context) {
    var forumID = data.key;
    var forumData = data.value;
    var forumName = forumData['name'];
    var role = forumData['role'];
    return Container(
      height: 50,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
              color: cDarkLightBlueColor,
            width: 2
          )
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPageApp(forumID: forumID!)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                forumName,
                style: TextStyle(
                    fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: cHeavyGrey
                ),
                maxLines: 1,
                softWrap: true,
              ),
            ),
            Spacer(),
            if(role != "MEMBER")
            InkWell(
              child: Icon(
                Icons.info_outline,
                color:
                cHeavyGrey.withOpacity(0.6),
              ),
              onTap: () {},
            ),
            SizedBox(width: 3,),
            if(role != "MEMBER")
            InkWell(
              child: Icon(
                Icons.person_outlined,
                color:
                cHeavyGrey.withOpacity(0.6),
              ),
              onTap: () {},
            ),
            SizedBox(width: 3,),
            if(role == "A")
            InkWell(
              child: Icon(
                Icons.switch_access_shortcut,
                color:
                cHeavyGrey.withOpacity(0.6),
              ),
              onTap: () {},
            ),
            SizedBox(width: 3,),
      if(role == "MEMBER")
      InkWell(
        child: Icon(
                  Icons.logout_outlined,
                  color:
                  cHeavyGrey.withOpacity(0.6),
                ),
        onTap: () {},
      ),
           SizedBox(width: 3,),
            if(role == "A")
           InkWell(
             child: Icon(
                  Icons.delete_outline,
                  color:
                  cHeavyGrey.withOpacity(0.6),
              ),
             onTap: () {

             },
           ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "SEM FÓRUNS",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: cPrimaryLightColor,
            fontSize: 25
        ),
      ),
    );
  }
}