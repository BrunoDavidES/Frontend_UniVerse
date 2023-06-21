import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class MyTextField extends StatelessWidget {

  final controller;
  final String hintText;
  final String label;
  final bool obscureText;
  final IconData? icon;

  const MyTextField({super.key, this.controller, required this.hintText, required this.obscureText, required this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right:20, top: 10),
      child: Container(
        child: TextFormField(
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: cDarkLightBlueColor
              ),
              prefixIcon: Icon(icon!, color: cDarkLightBlueColor),
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
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey
            )
          ),
        ),
      ),
    );
  }
  
}