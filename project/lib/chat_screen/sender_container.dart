import 'package:UniVerse/consts/api_consts.dart';
import 'package:flutter/material.dart';
import '../consts/color_consts.dart';
import 'chat_screen_app.dart';
import 'message_pop_up.dart';

class SenderContainer extends StatelessWidget {
  const SenderContainer({
    super.key,
    required this.size,
    required this.posted,
    required this.message,
    required this.postID,
    required this.forumID,
  });

  final Size size;
  final String posted;
  final String message;
  final String postID;
  final String forumID;

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
              SelectableText(
                  '$message'
              )
            ],
          ),
        ),
        InkWell(child: Icon(Icons.more_vert),
          onTap: () {
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
                    child: MessagePopUp(text: message, forumID: forumID, postID: postID,)
                )
            );
          },)
      ],
    );
  }
}
