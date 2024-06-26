
import 'package:UniVerse/components/simple_dialog_box.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:UniVerse/consts/list_consts.dart';
import 'package:UniVerse/find_screen/info_detail_screen.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:UniVerse/utils/search/info.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';

class RestaurantsScreen extends StatelessWidget {

  const RestaurantsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: cDirtyWhiteColor,
              title: Image.asset("assets/titles/restaurants.png", scale: 6),
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
                  opacity: AlwaysStoppedAnimation(0.5),
                    image: AssetImage("assets/images/photo_6.jpg",),
                    fit: BoxFit.fill
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: 8,
                      (BuildContext context, int index) {
                    final item = restaurants[index];
                    return ListButtonSimple(tobeBold: true,
                        text: item.values.first,
                        press: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDetailScreen(text: item.values.first,id: item.keys.first, image: AssetImage("assets/images/photo_6.jpg"),)));
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