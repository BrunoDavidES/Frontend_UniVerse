import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/500.dart';
import '../consts/color_consts.dart';

import'package:UniVerse/utils/chat/chat_utils.dart';

class ChatPageApp extends StatefulWidget {
  final String forumID;

  ChatPageApp({super.key, required this.forumID,});

  @override
  State<ChatPageApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ChatPageApp> {
  final scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  late StreamSubscription _chatStream;
  late StreamSubscription _forumStream;
  late StreamSubscription _memberStream;
  final StreamController<dynamic> _chatStreamController = StreamController<dynamic>();
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
    _chatStream.cancel();
    _forumStream.cancel();
    _memberStream.cancel();
    _chatStreamController.add(null);
    _memberStreamController.add(null);
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
            "ADICIONAR NOME",
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
                            var message = value['message'];
                            var posted = value['posted'];

                            return SenderContainer(size: size, posted: posted, message: message, messageController: messageController, widget: widget, postID: postID);

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
      // Call the sendMessage function from chat_utils.dart
      Chat.sendMessage(widget.forumID, message);
      // Clear the message text field
      messageController.clear();
      setState(() {
        isSending = true;
      });
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
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
          ?IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send_sharp, color: cDarkBlueColor),
          )
              : CircularProgressIndicator(
            color: cDarkBlueColor,
          )
        ],
      ),
    );
  }
/*Column(
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
  }*/

}

class ReceiverContainer extends StatelessWidget {
  const ReceiverContainer({
    super.key,
    required this.size,
    required this.author,
    required this.posted,
    required this.message,
    required this.messageController,
    required this.widget,
    required this.postID,
  });

  final Size size;
  final author;
  final posted;
  final message;
  final TextEditingController messageController;
  final ChatPageApp widget;
  final postID;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          width: size.width/1.3,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color:Colors.white,
            border: Border.all(
              color: cPrimaryColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '$author\n'.toUpperCase(),
                  ),
                  Text(
                    '   $posted\n',
                    style: TextStyle(
                        color: cHeavyGrey.withOpacity(0.6)
                    ),)
                ],
              ),
              Text(
                '$message',
              ),
            ],
          ),
        ),
        Spacer()
      ],
    );
  }
}

class SenderContainer extends StatelessWidget {
  const SenderContainer({
    super.key,
    required this.size,
    required this.posted,
    required this.message,
    required this.messageController,
    required this.widget,
    required this.postID,
  });

  final Size size;
  final posted;
  final message;
  final TextEditingController messageController;
  final ChatPageApp widget;
  final postID;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        Container(
          margin: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          padding: const EdgeInsets.all(5),
          width: size.width/1.3,
          decoration: BoxDecoration(
            color:Colors.white,
            border: Border.all(
              color: cHeavyGrey,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$posted\n',
                textAlign: TextAlign.start,
                style: TextStyle(color: cHeavyGrey.withOpacity(0.6)),
              ),
              Text(
                  '$message'
              )
            ],
          ),
        ),
        InkWell(child: Icon(Icons.more_vert),
          onTap: () {},)
      ],
    );
  }
}

/*showDialog(
context: context,
builder: (BuildContext context) =>
AlertDialog(
title: Text('Confirmation'),
content: Text(
'Are you sure you want to delete this message?'),
actions: [
TextButton(
child: Text('Cancel'),
onPressed: () {
Navigator.pop(
context); // Close the confirmation dialog
},
),
TextButton(
child: Text('Delete'),
onPressed: () {
Navigator.pop(
context); // Close the confirmation dialog
ChatUtils.deletePost(
widget.forumID,
postID);
},
),
],
),
);*/
/* PopupMenuButton(
              itemBuilder: (BuildContext context) =>
              [
                PopupMenuItem(
                  child: Text('Edit'),
                  value: 'edit',
                ),
                PopupMenuItem(
                  child: Text('Delete'),
                  value: 'delete',
                ),
              ],
              onSelected: (value) async {
                if (value == 'edit') {
                  // Handle edit functionality
                  var editedMessage = await showDialog<
                      String>(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: Text('Edit Message'),
                          content: TextFormField(
                            initialValue: message,
                            maxLines: null,
                          ),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the dialog without saving changes
                              },
                            ),
                            TextButton(
                              child: Text('Save'),
                              onPressed: () {
                                Navigator.pop(context,
                                    messageController
                                        .text); // Pass the edited message back to the caller
                              },
                            ),
                          ],
                        ),
                  );

                  if (editedMessage != null) {
                    // Update the message in the database
                    //ChatUtils.updateMessage(forumID, postID, editedMessage);
                  }
                } else if (value == 'delete') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertDialog(
                          title: Text('Confirmation'),
                          content: Text(
                              'Are you sure you want to delete this message?'),
                          actions: [
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the confirmation dialog
                              },
                            ),
                            TextButton(
                              child: Text('Delete'),
                              onPressed: () {
                                Navigator.pop(
                                    context); // Close the confirmation dialog
                                ChatUtils.deletePost(
                                    widget.forumID,
                                    postID);
                              },
                            ),
                          ],
                        ),
                  );
                }
              },
            );*/