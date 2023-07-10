
import 'package:UniVerse/components/simple_dialog_box.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:UniVerse/find_screen/info_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';
import '../../utils/search/info.dart';

class AgenciesBodyApp extends StatelessWidget {

  const AgenciesBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: cDirtyWhiteColor,
              title: Image.asset("assets/titles/agencies.png", scale: 6),
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
                  childCount: 3,
                      (BuildContext context, int index) {
                    final item = fctAgencies[index];
                    return ListButtonSimple(tobeBold: true,
                        text: item.values.first[0],
                        press: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDetailScreen(text: item.values.first[0], id: item.keys.first,link: item.values.first[1],)));
                        });
                  }
              ),
            ),
          ],
        )
    );
  }

}