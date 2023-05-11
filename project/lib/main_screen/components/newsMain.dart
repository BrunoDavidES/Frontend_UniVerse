import 'package:UniVerse/consts.dart';
import 'package:flutter/material.dart';

class mainNews extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
        margin: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
        decoration: const BoxDecoration(
          color: cDirtyWhite,
        ),
        child:  Column(
          children: <Widget> [
            Row(
              children: <Widget>[
                Padding(
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
                Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 25, right: 30),
                      child: Text(
                        "Ver mais",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                ),
              ],
            ),
            SizedBox(
              child: Divider(
                thickness: 2,
                color: cBlackOp,
              ),
            ),
          ],
        ),
    );
  }
}
