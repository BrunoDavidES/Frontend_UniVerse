
import 'package:flutter/material.dart';
import '../../consts/color_consts.dart';

class MenuCard extends StatelessWidget {
  final String text;
  final String description;
  final IconData icon;
  final Function press;
  const MenuCard({
    super.key, required this.text, required this.icon, required this.description, required this.press,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        press();
      },
      child: Container(
        margin: EdgeInsets.all(5),
          width: size.width,
          height: size.height/5.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: cPrimaryLightColor,
                width:2,
              ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                cDirtyWhiteColor,
                cDirtyWhite,
                cPrimaryOverLightColor.withOpacity(0.4),
                cPrimaryLightColor.withOpacity(0.5)
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size:40, color: cPrimaryColor),
              Padding(
                padding: const EdgeInsets.only(top:5),
                child: Text(
                  text,
                  style: const TextStyle(
                      fontSize: 20,
                      color: cHeavyGrey,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              if(description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15,
                      color: cHeavyGrey,
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
}