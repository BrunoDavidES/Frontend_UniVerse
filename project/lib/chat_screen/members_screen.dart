import 'dart:async';
import 'dart:math';
import 'package:UniVerse/chat_screen/create_forum_screen.dart';
import 'package:UniVerse/chat_screen/promote_depromote_screen.dart';
import 'package:UniVerse/chat_screen/receiver_container.dart';
import 'package:UniVerse/chat_screen/sender_container.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/500.dart';
import '../components/my_text_button.dart';
import '../consts/color_consts.dart';

import'package:UniVerse/utils/chat/chat_utils.dart';

import '../consts/list_consts.dart';

class MembersPageApp extends StatefulWidget {
  final String forumID;
  final String forumName;

  MembersPageApp({super.key, required this.forumID, required this.forumName,});

  @override
  State<MembersPageApp> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPageApp> {
  final scrollController = ScrollController();
  late StreamSubscription _forumStream;
  late StreamSubscription _memberStream;
  final StreamController<dynamic> _forumStreamController = StreamController<dynamic>();
  final StreamController<dynamic> _memberStreamController = StreamController<dynamic>();
  bool isSending = false;

  @override
  void initState() {
    activateListeners();
    super.initState();
  }

  @override
  void deactivate() {
    _forumStream.cancel();
    _memberStream.cancel();
    _forumStreamController.add(null);
    _memberStreamController.add(null);
    super.deactivate();
  }

  void activateListeners() async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    if (widget.forumID != null) {
      _memberStream = FirebaseDatabase.instance
          .ref()
          .child('forums/${widget.forumID}/members/')
          .onValue
          .listen((event) {
        var snapshot = event.snapshot;
        var children = snapshot.value as Map<dynamic, dynamic>;

        _memberStreamController.add(children);
      });
    }

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
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        appBar: AppBar(
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
          title: Text(
            "Membros do fórum ${widget.forumName}",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cHeavyGrey,
                fontSize: 25
            ),
          ),
          backgroundColor: cDirtyWhiteColor,
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
                Expanded(
                  child: StreamBuilder(
                    stream: _memberStreamController.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {

                      if (snapshot.hasError) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Error500()));
                      } else if(!snapshot.hasData || snapshot.data == null) {
                        return Center(
                          child: Text(
                            "AINDA NÃO EXISTEM MEMBROS NESTE FÓRUM",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: cPrimaryLightColor
                            ),
                          ),
                        );
                      }

                      var children = snapshot.data as Map<dynamic, dynamic>;

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });

                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: children.entries.map((entry) {
                            var memberID = entry.key;
                            var memberData = entry.value;

                            return MemberCard(id: widget.forumID, data: memberData, username: memberID);
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
        )
    );
  }

}

class MemberCard extends StatelessWidget {
  const MemberCard({
    super.key, required this.data, required this.username, required this.id,
  });

  final data;
  final String id;
  final String username;

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int cindex = random.nextInt(toRandom2.length);
    var memberName = data['name'];
    var memberRole = data['role'];
    String role="";
    bool toBold = false;
    Color color=cHeavyGrey;
    switch(memberRole){
      case "A": role = "ADMINISTRADOR";
      color = Colors.green;
      toBold=true;
      break;
      case "ASS": role = "ASSISTENTE";
      color = Colors.green.withOpacity(0.7);
      toBold=true;
      break;
      case "MEMBER": role = "MEMBRO";
    }
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
              color: toRandom2[cindex],
              width: 2
          )
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memberName,
                      style: TextStyle(
                          fontSize: 17,
                      ),
                    ),
                    SizedBox(height:5),
                    Text(
                      username.replaceAll("-", "."),
                      style: TextStyle(
                          fontSize: 15,
                          color: cHeavyGrey
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                role,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: toBold ?FontWeight.bold :FontWeight.normal,
                    color: color
                ),
              ),
            ],
          ),
          if(memberRole!='A' && username.replaceAll("-", ".")!=UniverseUser.getUsername())
          Row(
            children: [
              Spacer(),
              if(memberRole != 'A')
              Button(screen: PromoteDepromoteScreen(toPromote: true, forumID: id, username:  username.replaceAll("-", "."),), text: 'PROMOVER', shadow: false,),
              if(memberRole != "MEMBER")
              Button(screen: PromoteDepromoteScreen(toPromote: false, forumID: id, username:  username.replaceAll("-", "."),), text: 'DESPROMOVER', shadow: false,),
            ],
          )
        ],
      ),
    );
  }
}
