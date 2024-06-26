import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import 'package:intl/intl.dart';


class MyTimeField extends StatefulWidget {
  final  controller;
  final String label;

  const MyTimeField({super.key, required this.controller, required this.label});

  @override
  State<MyTimeField> createState() => _MyTimeFieldState();
}

class _MyTimeFieldState extends State<MyTimeField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right:20, top: 10),
      child: TextField(
        controller: widget.controller, //editing controller of this TextField
        decoration: InputDecoration(
            labelText: "Hora de início",
            labelStyle: TextStyle(
                color: cDarkLightBlueColor
            ),
            prefixIcon: Icon(Icons.timer, color: cDarkLightBlueColor),
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
            hintText: "HH:mm",
            hintStyle: TextStyle(
                color: Colors.grey
            )
        ),
        readOnly: true,  //set it true, so that user will not able to edit text
        onTap: () async {
          TimeOfDay? pickedTime =  await showTimePicker(
            initialTime: TimeOfDay.now(),
            context: context,
          );
          if(pickedTime != null ){
            if(kIsWeb) {
              DateTime parsedTime = DateFormat("h:mm a").parse(
                  pickedTime.format(context));
              //converting to DateTime so that we can further format on different pattern.
              String formattedTime = DateFormat('HH:mm').format(parsedTime);
              //DateFormat() is from intl package, you can format the time on any pattern you need.
            }
            setState(() {
              widget.controller.text = pickedTime.format(context); //set the value of text field.
            });
          }
        },
      ),
    );
  }
}