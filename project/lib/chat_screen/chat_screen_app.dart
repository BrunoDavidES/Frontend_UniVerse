import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../consts/color_consts.dart';

import 'package:UniVerse/utils/chat/chat_utils.dart';

class ChatPageApp extends StatefulWidget {
  final String receiverID;

  ChatPageApp({
    Key? key,
    required this.receiverID,
  }) : super(key: key);

  @override
  State<ChatPageApp> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<ChatPageApp> {
  final TextEditingController messageController = TextEditingController();
  late StreamSubscription _chatStream;
  final StreamController<dynamic> _streamController = StreamController<
      dynamic>();
  String currentPage = 'Homepage';
  String forumID = '-NZGuFwlRhrbHrrMpOMA';

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  @override
  void deactivate() {
    _chatStream.cancel();
    super.deactivate();
  }

  void _activateListeners() async {
    String? senderID = FirebaseAuth.instance.currentUser?.uid;
    print(senderID);
    _chatStream = FirebaseDatabase.instance
        .ref()
        .child('forums/$forumID/feed/')
        .onValue
        .listen((event) {
      print('Firebase Request: forums/$forumID/feed/');
      var snapshot = event.snapshot;
      var children = snapshot.value as Map<dynamic, dynamic>;

      children.forEach((key, value) {
        var description = value['description'];
        var time = value['time'];
        var author = value['author'];

        print('Description: $description, Time: $time, Author: $author');
      });

      print('Firebase Response: $children');

      _streamController.add(children);
    });
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
          currentPage, // Display the current page name
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
    return Align(
      alignment: Alignment.centerLeft, // Align buttons to the left
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // Align text within buttons to the left
        children: [
          TextButton.icon(
            onPressed: () {
              setState(() {
                currentPage =
                'Homepage'; // Update the current page to 'Homepage'
              });
              // Action to perform when Homepage button is pressed
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.blue.withOpacity(0.2)),
              // Slightly darker background on hover
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            icon: const Icon(Icons.home), // Icon on the left side
            label: const Text('Homepage'),
          ),

          const SizedBox(height: 8), // Adding spacing between buttons

          TextButton.icon(
            onPressed: () {
              setState(() {
                currentPage = 'Grades'; // Update the current page to 'Grades'
              });
              // Action to perform when Grades button is pressed
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.blue.withOpacity(0.2)),
              // Slightly darker background on hover
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            icon: const Icon(Icons.grade), // Icon on the left side
            label: const Text('Grades'),
          ),

          const SizedBox(height: 8), // Adding spacing between buttons

          TextButton.icon(
            onPressed: () {
              setState(() {
                currentPage =
                'Evaluations'; // Update the current page to 'Evaluations'
              });
              // Action to perform when Evaluations button is pressed
            },
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.all<Color>(
                  Colors.blue.withOpacity(0.2)),
              // Slightly darker background on hover
              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              textStyle: MaterialStateProperty.all<TextStyle>(
                const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            icon: const Icon(Icons.rate_review), // Icon on the left side
            label: const Text('Evaluations'),
          ),

          const SizedBox(height: 8), // Adding spacing between buttons
        ],
      ),
    );
  }

  Widget buildMiddleColumn() {
    final scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder(
            stream: _streamController.stream,
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
                    var key = entry.key;
                    var value = entry.value;
                    var description = value['description'];
                    var time = value['time'];
                    var author = value['author'];

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
                      child: Text(
                        '$author - $time \n\n$description',
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
    // Replace with your Firebase alerts widgets
    return Container(
      // Add your Firebase alerts here
    );
  }

  Widget buildInput() {
    void sendMessage() {
      String message = messageController.text;

      // Call the sendMessage function from chat_utils.dart
      ChatUtils.sendMessage(forumID, message);

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
