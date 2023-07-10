import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class Button extends StatelessWidget {
  final Widget screen;
  final String text;
  final bool shadow;

  const Button({
    super.key, required this.screen, required this.text, required this.shadow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom:10, right: 10),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          decoration: shadow
            ?BoxDecoration(
              color: cDarkBlueColorTransparent,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [ BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0,0),
              ),
              ]
          )
          :BoxDecoration(
              color: cDarkBlueColorTransparent,
              borderRadius: BorderRadius.circular(15),
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
                        child: screen
                    )
                );
              },
              child: Text(
                text,
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