import 'package:UniVerse/components/list_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import 'default_button_simple.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.text}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size.height),
    );
  }
  contentBox(context, height){
    return Container(
          padding: EdgeInsets.all(2),
          width: double.infinity,
          height: height/4
          /*padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),*/
          ,decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [ BoxShadow(
                color: cHeavyGrey,
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0,0),
              ),
              ]
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: Colors.white,
                  width: 2
              ),
            ),
            child: Column(
              children: <Widget>[
                Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(height: 15,),
                Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.justify,),
                Spacer(),
                DefaultButtonSimple(
                    text: "OK",
                    press: () {
                      Navigator.of(context).pop();
                      },
                    height: 10),
              ],
            ),
          ),
        /*Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: Constants.avatarRadius,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset("assets/model.jpeg")
            ),
          ),
        ),*/
    );
  }
}