import 'package:UniVerse/components/grid_item.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/menu_card.dart';

class PersonalPageBodyApp extends StatelessWidget {
  const PersonalPageBodyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Image.asset("assets/app/find_title.png", scale: 5),
              backgroundColor: cDirtyWhiteColor,
              titleSpacing: 15,
            )
          ];
        },
        body: SizedBox(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(15),
            itemCount:10,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 15,);
            },
            itemBuilder: (context, index) {
              return MenuCard(text: 'Test', icon: Icons.account_circle_outlined);
            }
          ),
        ),
    );
  }
}



