
import 'package:UniVerse/consts/color_consts.dart';
import 'package:flutter/material.dart';

import '../../components/default_button_simple.dart';
import '../../components/list_button_simple.dart';
import '../../utils/search/info.dart';
import '../info_detail_screen.dart';

class DepartmentsBodyApp extends StatelessWidget {

  const DepartmentsBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDirtyWhiteColor,
      body: CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: cDirtyWhiteColor,
          title: Image.asset("assets/titles/departments.png", scale: 5),
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
              childCount: 13,
                  (BuildContext context, int index) {
                final item = departments[index];
                return ListButtonSimple(tobeBold: true,
                    text: item.values.first[0],
                    press: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => InfoDetailScreen(text: item.values.first[0],id: item.keys.first, link: item.values.first[1],)));
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