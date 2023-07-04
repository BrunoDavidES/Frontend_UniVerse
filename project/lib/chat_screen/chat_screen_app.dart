import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../consts/api_consts.dart';
import '../consts/color_consts.dart';

import 'package:UniVerse/utils/chat/chat_utils.dart';

class ChatPageApp extends StatefulWidget {
  String forumID;
  String forumName;

  ChatPageApp({
    Key? key,
    required this.forumID,
    required this.forumName,
  }) : super(key: key);

  @override
  State<ChatPageApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ChatPageApp> {
  final TextEditingController messageController = TextEditingController();
  late StreamSubscription _chatStream;
  late StreamSubscription _forumStream;
  late StreamSubscription _memberStream;
  final StreamController<dynamic> _chatStreamController = StreamController<dynamic>();
  final StreamController<dynamic> _forumStreamController = StreamController<dynamic>();
  final StreamController<dynamic> _memberStreamController = StreamController<dynamic>();

  @override
  void initState() {
    super.initState();
    _activateListeners();
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

  void _activateListeners() async {
    String? userID = FirebaseAuth.instance.currentUser?.uid;
    print(widget.forumID);
    print(userID);

    if (widget.forumID != null) {
      _chatStream = FirebaseDatabase.instance
          .ref()
          .child('forums/${widget.forumID}/feed/')
          .onValue
          .listen((event) {
        var snapshot = event.snapshot;
        var children = snapshot.value as Map<dynamic, dynamic>;

        _chatStreamController.add(children);
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
          .child('users/${userID.replaceAll(".", "-")}/')
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
              color: cDarkBlueColorTransparent,
            );
          },
        ),
        title: Text(
          widget.forumName, // Display the current page name
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: cDirtyWhiteColorNoOps,
      ),
      body: Container(
        decoration: const BoxDecoration(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: buildLeftColumn(),
            ),
            Expanded(
              flex: 2,
              child: buildMiddleColumn(),
            ),
            Expanded(
              flex: 1,
              child: buildRightColumn(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLeftColumn() {
    return StreamBuilder(
      stream: _forumStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var forums = snapshot.data as Map<dynamic, dynamic>;

        return SingleChildScrollView(
          child: Column(
            children: forums.entries.map((entry) {
              var forumID = entry.key;
              var forumData = entry.value;
              var forumName = forumData['name'];

              return ListTile(
                title: Text(forumName),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {
                        // Perform the desired action when the IconButton is pressed
                        // (e.g., leave the forum)
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Are you sure you want to leave this forum?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context); // Close the confirmation dialog
                                },
                              ),
                              TextButton(
                                child: Text('Leave'),
                                onPressed: () {
                                  Navigator.pop(context); // Close the confirmation dialog
                                  ChatUtils.leaveForum(forumID);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        // Perform the desired action when the delete button is pressed
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Are you sure you want to delete this forum?'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context); // Close the confirmation dialog
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  Navigator.pop(context); // Close the confirmation dialog
                                  ChatUtils.deleteForum(forumID);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    widget.forumName = forumName;
                    widget.forumID = forumID;
                    deactivate();
                    _activateListeners();
                  });
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }



  Widget buildMiddleColumn() {
    final scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _chatStreamController.stream,
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              var children = snapshot.data as Map<dynamic, dynamic>;

              WidgetsBinding.instance?.addPostFrameCallback((_) {
                // Add this callback to scroll to the bottom after the frame is rendered
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

                    return Container(
                      margin: const EdgeInsets.all(7.5),
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '$author - $posted \n\n$message',
                            ),
                          ),
                          PopupMenuButton(
                            itemBuilder: (BuildContext context) => [
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
                                var editedMessage = await showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text('Edit Message'),
                                    content: TextFormField(
                                      initialValue: message,
                                      maxLines: null,
                                    ),
                                    actions: [
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context); // Close the dialog without saving changes
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Save'),
                                        onPressed: () {
                                          Navigator.pop(context, messageController.text); // Pass the edited message back to the caller
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
                                  builder: (BuildContext context) => AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text('Are you sure you want to delete this message?'),
                                    actions: [
                                      TextButton(
                                        child: Text('Cancel'),
                                        onPressed: () {
                                          Navigator.pop(context); // Close the confirmation dialog
                                        },
                                      ),
                                      TextButton(
                                        child: Text('Delete'),
                                        onPressed: () {
                                          Navigator.pop(context); // Close the confirmation dialog
                                          ChatUtils.deletePost(widget.forumID, postID);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        buildInput(),
      ],
    );
  }

  Widget buildRightColumn() {
    return StreamBuilder(
      stream: _memberStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var members = snapshot.data as Map<dynamic, dynamic>;

        return SingleChildScrollView(
          child: Column(
            children: members.entries.map((entry) {
              var memberID = entry.key;
              var memberData = entry.value;
              var memberName = memberData['name'];
              var memberRole = memberData['role'];

              return ListTile(
                title: Text(memberName),
                subtitle: Text('Role: $memberRole'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ChatUtils.promoteMember(widget.forumID, memberID);
                      },
                      child: Text('Promote'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        ChatUtils.demoteMember(widget.forumID, memberID);
                      },
                      child: Text('Demote'),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget buildInput() {
    void sendMessage() {
      String message = messageController.text;

      // Call the sendMessage function from chat_utils.dart
      ChatUtils.sendMessage(widget.forumID, message);

      // Clear the message text field
      messageController.clear();
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
                  hintText: "Message",
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send_sharp, color: cDarkBlueColor),
          ),
        ],
      ),
    );
  }


}
