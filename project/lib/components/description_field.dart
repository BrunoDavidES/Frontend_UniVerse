import 'package:flutter/material.dart';

import '../consts/color_consts.dart';

class DescriptionField extends StatelessWidget {
  final String label;
  final int max;
  const DescriptionField({
    super.key,
    required this.controller, required this.label, required this.max,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right:20, top: 10),
      child: TextFormField(
        maxLength: max,
        maxLines: 5,
        controller: controller,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
                color: cDarkLightBlueColor
            ),
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
            hintText: "Descreve o problema",
            hintStyle: TextStyle(
                color: Colors.grey
            )
        ),
      ),
    );
  }
}