import 'dart:async';
import 'package:UniVerse/chat_screen/receiver_container.dart';
import 'package:UniVerse/chat_screen/sender_container.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/500.dart';
import '../consts/color_consts.dart';

import'package:UniVerse/utils/chat/chat_utils.dart';

class ChatPageApp extends StatefulWidget {
  final String forumID;
  final String forumName;

  ChatPageApp({super.key, required this.forumID, required this.forumName,});

  @override
  State<ChatPageApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ChatPageApp> {
  final scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  late StreamSubscription _chatStream;
  late StreamSubscription _forumStream;
  final StreamController<dynamic> _chatStreamController = StreamController<dynamic>();
  final StreamController<dynamic> _forumStreamController = StreamController<dynamic>();
  bool isSending = false;

  @override
  void initState() {
    activateListeners();
    super.initState();
  }

  @override
  void deactivate() {
    _chatStream.cancel();
    _forumStream.cancel();
    _chatStreamController.add(null);
    super.deactivate();
  }

  void activateListeners() async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    if (widget.forumID != null) {
      _chatStream = FirebaseDatabase.instance
          .ref()
          .child('forums/${widget.forumID}/feed/')
          .onValue
          .listen((event) {
        var snapshot = event.snapshot;
        var children = snapshot.value as Map<dynamic, dynamic>;

        _chatStreamController.add(children);
        setState(() {
          isSending = false;
        });
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
            widget.forumName,
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
                    stream: _chatStreamController.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {

                      if (snapshot.hasError) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Error500()));
                      } else if(!snapshot.hasData || snapshot.data == null) {
                        return Center(
                          child: Text(
                            "AINDA NÃO EXISTEM MENSAGENS NESTE FÓRUM",
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
                            var postID = entry.key;
                            var value = entry.value;
                            var author = value['author'];
                            var name = author['name'];
                            var username = author['username'];
                            var message = value['message'];
                            var posted = value['posted'];

                            if(username==UniverseUser.getUsername())
                            return SenderContainer(size: size, posted: posted, message: message, postID: postID, forumID: widget.forumID);
                            else return ReceiverContainer(size: size, author: name, posted: posted, message: message, postID: postID);

                            //return ReceiverContainer(size: size, author: author, posted: posted, message: message, messageController: messageController, widget: widget, postID: postID);
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
                buildInput(),
              ],
            )
        )
    );
  }

  Widget buildInput() {
    void sendMessage() {
      String message = messageController.text;
      Chat.sendMessage(widget.forumID, message);
      messageController.clear();
      setState(() {
        isSending = true;
      });
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: RawKeyboardListener(
              focusNode: FocusNode(),
              onKey: (RawKeyEvent event) {
                if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                  if (!event.isShiftPressed) {
                    sendMessage();
                  }
                }
              },
              child: TextFormField(
                maxLength: 500,
                obscureText: false,
                controller: messageController,
                maxLines: null,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: cDarkLightBlueColor,
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: cDarkLightBlueColor,
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: "mensagem",
                ),
              ),
            ),
          ),
          !isSending
          ?Padding(
            padding: const EdgeInsets.only(top:5),
            child: IconButton(
              onPressed: () {
                if(messageController.text.isNotEmpty)
                  sendMessage();
              },
              icon: const Icon(Icons.send_sharp, color: cDarkBlueColor),
            ),
          )
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircularProgressIndicator(
            color: cDarkBlueColor,
                  backgroundColor: cDarkLightBlueColor.withOpacity(0.5),
          ),
              )
        ],
      ),
    );
  }

}

