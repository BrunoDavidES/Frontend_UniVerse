import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

class mainNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
        decoration: BoxDecoration(
          color: cDirtyWhite,
          //boxShadow: [
            //BoxShadow(
             //offset: const Offset(0, 0),
             //blurRadius: 30,
             //color: Colors.black.withOpacity(0.2),
            //),
          //],
        ),
        child: Stack(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 30),
              child: Text(
                "Notícias",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 25, left: 1700),
              child: Text(
                "Ver mais",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              width: width*0.95,
              child: const Padding(
                padding: EdgeInsets.only(top: 80, left: 12),
                child: Divider(
                  thickness: 2,
                  color: cBlackOp,
                ),
              ),
            )
          ],
        ),
    );
  }
}
