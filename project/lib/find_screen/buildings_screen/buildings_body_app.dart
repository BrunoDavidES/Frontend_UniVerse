
import 'package:UniVerse/components/url_launchable_item.dart';
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';
import '../../utils/search/info.dart';
import '../info__listdetail_screen.dart';
import '../info_detail_screen.dart';

class BuildingsBodyApp extends StatelessWidget {

  const BuildingsBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: cDirtyWhiteColor,
          title: Image.asset("assets/app/departments.png", scale: 5),
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
              childCount: 19,
                  (BuildContext context, int index) {
                final item = buildings[index];
                final divisions = buildingsWithDivisions[index].values.first;
                return ListButtonSimple(tobeBold: true,
                    text: item.values.first,
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDetailScreenWithList(text: item.values.first, divisions: divisions,)));
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