import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/news_card_web.dart';
import '../../news_screen/news_app_detail_screen.dart';
import '../../utils/news/article_data.dart';

class mainNews extends StatelessWidget {
  final width;
  final height;

  const mainNews({super.key, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 20),
        color: cDirtyWhite,
        child:  Column(
          children: <Widget> [
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20),
                  child: 
                    Image.asset("assets/web/noticias.png", scale: 4,)
                ),
                const Spacer(),
                const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 25, right: 30),
                      child: Text(
                        "+",
                        style: TextStyle(
                          color: cHeavyGrey,
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                ),
              ],
            ),
            const SizedBox(
              child: Divider(
                thickness: 2,
                color: cDarkLightBlueColor,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(50),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:
                    [Spacer(),
                      NewsCardWeb(height: height, width: width, Article.news[0]),
                    Spacer(),
                      NewsCardWeb(height: height, width: width, Article.news[1]),
                    Spacer(),
                      NewsCardWeb(height: height, width: width, Article.news[1]),
                    Spacer(),
                    ],
              )
                //SizedBox(height: 10,)
              ),
          ],
        ),
    );
  }
}
