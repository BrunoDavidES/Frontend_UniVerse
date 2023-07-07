import 'package:flutter/material.dart';
import '../consts/color_consts.dart';

class ReceiverContainer extends StatelessWidget {
  const ReceiverContainer({
    super.key,
    required this.size,
    required this.author,
    required this.posted,
    required this.message,
    required this.postID,
  });

  final Size size;
  final String author;
  final String posted;
  final String message;
  final String postID;

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '$author\n',
                  ),
                  Text(
                    '   $posted\n',
                    style: TextStyle(
                        color: cHeavyGrey.withOpacity(0.6)
                    ),)
                ],
              ),
              SelectableText(
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