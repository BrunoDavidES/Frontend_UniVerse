import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/about_bottom_body.dart';

class NewsWebPage extends StatelessWidget {
  NewsWebPage({super.key});
  @override
  ScrollController yourScrollController = ScrollController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Container(
            color: cDirtyWhite,
            child: Stack(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top: size.height/3),
                  child: Container(                //Zona do Find
                    height: size.height,
                    width: size.width/2,
                    color: cDirtyWhite,
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                      0: IntrinsicColumnWidth(),
                      1: FlexColumnWidth(),
                      2: FixedColumnWidth(64),
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            height: size.height/4,
                            color: Colors.green,
                          ),
                          TableCell(
                            verticalAlignment: TableCellVerticalAlignment.top,
                            child: Container(
                              height: 32,
                              width: 32,
                              color: Colors.red,
                            ),
                          ),
                          Container(
                            height: 64,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                        ),
                        children: <Widget>[
                          Container(
                            height: 64,
                            width: 128,
                            color: Colors.purple,
                          ),
                          Container(
                            height: 32,
                            color: Colors.yellow,
                          ),
                          Center(
                            child: Container(
                              height: 32,
                              width: 32,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ],
                    ),
                  ),
                ),
                Container(
                  color: cDirtyWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWebBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}