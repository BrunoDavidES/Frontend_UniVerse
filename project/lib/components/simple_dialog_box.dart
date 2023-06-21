import 'package:UniVerse/components/list_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'default_button_simple.dart';

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions, text;
  final Function? press;

  const CustomDialogBox({Key? key, required this.title, required this.descriptions, required this.text, this.press}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width;
    if(kIsWeb)
    width=size.width/3.5;
    else width = double.infinity;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      backgroundColor: Colors.transparent,
      child: contentBox(context, size.height, width),
    );
  }
  contentBox(context, height, width){
    return Container(
          padding: EdgeInsets.all(2),
          width: width,
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
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color: cPrimaryLightColor,
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
                    text: widget.text,
                    color: cPrimaryColor,
                    press: () {
                      if(widget.press == null)
                      Navigator.of(context).pop();
                      else
                        widget.press!();
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