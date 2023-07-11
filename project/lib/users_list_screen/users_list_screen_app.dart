import 'package:UniVerse/users_list_screen/users_card.dart';
import 'package:UniVerse/utils/user/user_data.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/news/article_data.dart';

class UsersListScreenApp extends StatefulWidget {

  const UsersListScreenApp({super.key});

  @override
  State<StatefulWidget> createState() => ListState();
  }

  class ListState extends State<UsersListScreenApp> {
  final scrollController = ScrollController();
  bool isLoadingMore = false;
  bool hasMore = true;

    @override
    void initState() {
      scrollController.addListener(scrollListener);
      UniverseUser.queryPublicUsers("8", UniverseUser.cursor);
      super.initState();
    }

    Future<void> scrollListener() async {
      if(isLoadingMore) return;
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent) {
        setState(() {
          isLoadingMore = true;
        });
        await UniverseUser.queryPublicUsers("8", UniverseUser.cursor);
        setState(() {
          isLoadingMore = false;
          if(UniverseUser.usersList.length == UniverseUser.numUsers)
            hasMore = false;
        });
      }
    }

    @override
    void dispose() {
      scrollController.removeListener(scrollListener);
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: cDirtyWhiteColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: cDirtyWhiteColor,
              title: Image.asset("assets/titles/people.png", scale: 6),
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
                    image: AssetImage("assets/images/photo_3.jpg",),
                    colorBlendMode: BlendMode.lighten,
                    fit: BoxFit.fill
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: UniverseUser.usersList.length+1,
                      (BuildContext context, int index) {
                        if (index < UniverseUser.usersList.length) {
                          return UserCard(UniverseUser.usersList[index]);
                          //return NewsCard(UniverseUser.usersList[index]);
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 10, right: 10, bottom: 80),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                if(isLoadingMore)
                                  LinearProgressIndicator(
                                    color: cPrimaryOverLightColor,
                                    minHeight: 10,
                                    backgroundColor: cPrimaryLightColor,),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    hasMore
                                        ? "A CARREGAR UTILIZADORES"
                                        : "VISTE TODOS OS UTILIZADORES!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: cPrimaryLightColor
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      }
              )
            ),
          ],
        )
              );
  }
      }