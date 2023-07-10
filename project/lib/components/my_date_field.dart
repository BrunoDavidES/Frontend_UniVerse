import 'package:flutter/material.dart';

import '../consts/color_consts.dart';
import 'package:intl/intl.dart';


class MyDateField extends StatefulWidget {
  final  controller;
  final String label;

  const MyDateField({super.key, required this.controller, required this.label});

  @override
    State<MyDateField> createState() => _MyDateFieldState();
}

class _MyDateFieldState extends State<MyDateField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: TextField(
        controller: widget.controller,
        //editing controller of this TextField
        decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: TextStyle(
                color: cDarkLightBlueColor
            ),
            prefixIcon: Icon(Icons.calendar_today, color: cDarkLightBlueColor),
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
            hintText: "dd-MM-yyyy",
            hintStyle: TextStyle(
                color: Colors.grey
            )
        ),
        readOnly: true, //set it true, so that user will not able to edit text
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            initialDatePickerMode: DatePickerMode.day,
            //locale: Locale('pt', 'PT'),
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023, 7, DateTime.now().day),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2030));
          if (pickedDate != null) {
            print(
                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            String formattedDate =
            DateFormat('dd-MM-yyyy').format(pickedDate);
            print(
                formattedDate); //formatted date output using intl package =>  2021-03-16
            setState(() {
              widget.controller.text =
                  formattedDate; //set output date to TextField value.
            });
          } else {}
        },
      ),
    );
  }
}