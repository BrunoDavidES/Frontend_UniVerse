
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'default_button_simple.dart';

class ConfirmDialogBox extends StatefulWidget {
  final String descriptions;
  final Function press;

  const ConfirmDialogBox({Key? key, required this.descriptions, required this.press}) : super(key: key);

  @override
  _ConfirmDialogBoxState createState() => _ConfirmDialogBoxState();
}

class _ConfirmDialogBoxState extends State<ConfirmDialogBox> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width;
    if(kIsWeb)
      width=size.width/3.5;
    else width = double.infinity;
    return Expanded(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        backgroundColor: Colors.transparent,
        child: contentBox(context, size.height, width),
      ),
    );
  }
  contentBox(context, height, width){
    return Expanded(
      child: Container(
        child:Container(
        padding: EdgeInsets.all(2),
    width: width,
    /*padding: EdgeInsets.only(left: Constants.padding,top: Constants.avatarRadius
              + Constants.padding, right: Constants.padding,bottom: Constants.padding
          ),
          margin: EdgeInsets.only(top: Constants.avatarRadius),*/
    decoration: BoxDecoration(
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
              Text("Aviso",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
              SizedBox(height: 15,),
              Text(widget.descriptions,style: TextStyle(fontSize: 14),textAlign: TextAlign.justify,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButtonSimple(
                      text: "Cancelar",
                      color: cPrimaryColor,
                      press: () {
                        Navigator.of(context).pop();
                        widget.press;
                      },
                      height: 10),
                  DefaultButtonSimple(
                      text: "Confirmar",
                      color: cPrimaryColor,
                      press: () {
                        Navigator.of(context).pop();
                        widget.press;
                      },
                      height: 10),
                ],
              ),
        ],
          ),
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
    )
    );
  }
}