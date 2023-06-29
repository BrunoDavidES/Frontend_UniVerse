import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class MyTextField extends StatefulWidget {

  final controller;
  final String hintText;
  final String label;
  final bool obscureText;
  final IconData? icon;

  const MyTextField({super.key, this.controller, required this.hintText, required this.obscureText, required this.label, this.icon});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    return Container(
        margin: const EdgeInsets.only(left: 20, right:20, top: 10),
        child: TextFormField(
          obscureText: widget.obscureText,
          controller: widget.controller,
          decoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(
                color: cDarkLightBlueColor
              ),
              prefixIcon: Icon(widget.icon!, color: cDarkLightBlueColor),
              /*suffixIcon: IconButton(onPressed: (){
                setState(() {
                  isVisible = !isVisible;
                });
              },
                  icon: Icon(
                    if(isVisible)
                    Icons.visibility_offIcons.visibility,
                  )),*/
              /*suffixIcon: IconButton(
            icon: Icon(obscureText
            ?Icons.visibility_off_outlined
                : Icons.visibility_outlined
            ), onPressed: () {
              obscureText = !obscureText;
              },
        ),*/
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: cDarkLightBlueColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: cDarkBlueColor,
                )
            ),
            fillColor: Colors.white60,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.grey
            )
          ),
        ),
      );
  }
}