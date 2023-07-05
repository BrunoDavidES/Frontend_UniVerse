import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class MyPasswordField extends StatefulWidget {

  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool obscureText;
  final IconData? icon;

  const MyPasswordField({super.key, required this.controller, required this.hintText, required this.obscureText, required this.label, this.icon});

  @override
  State<MyPasswordField> createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool isVisible = false;

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: TextFormField(
        obscureText: !isVisible && widget.obscureText,
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: cDarkLightBlueColor),
          prefixIcon: Icon(widget.icon!, color: cDarkLightBlueColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: cDarkLightBlueColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: cDarkBlueColor,
            ),
          ),
          fillColor: Colors.white60,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility : Icons.visibility_off,
              color: cDarkLightBlueColor,
            ),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }
}