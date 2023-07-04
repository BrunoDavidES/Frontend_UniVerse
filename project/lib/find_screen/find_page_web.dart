import 'package:UniVerse/find_screen/find_test.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../components/web/find_list_item.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/about_bottom.dart';
import '../main_screen/components/about_bottom_body.dart';
import 'Item.dart';
import 'findTest/right_side.dart';

class FindWebPage extends StatefulWidget {
  FindWebPage({super.key});

  @override
  State<FindWebPage> createState() => _FindWebPageState();
}

class _FindWebPageState extends State<FindWebPage> {
  ScrollController yourScrollController = ScrollController();

  @override
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
                  padding: EdgeInsets.only(top: size.height/7),
                  child: Container(
                    height:size.height+270,
                    color: cDirtyWhite,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:50, top: 20),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Image.asset("assets/titles/find.png", scale: 4.5,)
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 50, top: 30),
                                child: SizedBox(
                                    height: size.height-size.height/7,
                                    width: size.width/4.5,
                                    child: ListView.builder(
                                        itemCount: 11,
                                        itemBuilder: (BuildContext context, int index) {
                                          final item = Item.findItems[index+1];
                                          return Padding(
                                            padding: EdgeInsets.only(bottom: 5),
                                            child: FindListItem(
                                                icon: Icon(item.icon!), name: item.text!, i: index),);
                                        }
                                    )
                                )
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 50, left: 50, right: 50),
                              child: RightSide(),
                            ),
                          ],
                        ),
                        BottomAbout(size: size,),
                  ],
                ),
            ),
        ),
      CustomWebBar(),
      ],
    ),
    ),
    ),
    ),
    );
  }
}