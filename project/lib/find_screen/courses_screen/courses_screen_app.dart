
import 'package:UniVerse/components/simple_dialog_box.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:UniVerse/find_screen/info_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';
import '../../utils/search/info.dart';

class CoursesScreenApp extends StatelessWidget {

  const CoursesScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: cDirtyWhiteColor,
              title: Image.asset("assets/app/services.png", scale: 6),
              leading: Builder(
                  builder: (context) {
                    return IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {Navigator.pop(context);},
                        color: cDarkBlueColorTransparent);
                  }
              ),
              leadingWidth: 20,
              elevation: 0,
              pinned: true,
              stretch: true,
              expandedHeight: 200,
              flexibleSpace: const FlexibleSpaceBar(
                stretchModes: [
                  StretchMode.zoomBackground,
                ],
                background: Image(
                    image: AssetImage("assets/web/FCT-NOVA.jpg"),
                    fit: BoxFit.fill
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 22,
                      (BuildContext context, int index) {
                    final item = courses[index];
                    return ListButtonSimple(tobeBold: true,
                        text: item.keys.first,
                        press: () {
                          launchUrl(Uri.parse(item.values.first));
                        });
                  }
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                      (BuildContext context, int index) {
                    return SizedBox(height: 70);
                  }
              ),
            ),
          ],
        )
    );
  }

}