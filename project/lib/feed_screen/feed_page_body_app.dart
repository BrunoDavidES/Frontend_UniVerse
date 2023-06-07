import 'package:UniVerse/components/news_card.dart';
import 'package:UniVerse/utils/news/article_data.dart';
import 'package:flutter/material.dart';
import 'package:UniVerse/consts/color_consts.dart';

import '../components/grid_item.dart';
import '../events_screen/events_body_app.dart';
import '../news_screen/news_body_app.dart';

class FeedPageBodyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Scaffold(
          backgroundColor: cDirtyWhiteColor,
         /* appBar: AppBar(
            title: Image.asset("assets/app/feed_title.png", scale:6),
            automaticallyImplyLeading: false,
            backgroundColor: cDirtyWhiteColor,
            titleSpacing: 15,
            elevation: 0,
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cPrimaryColor, width: 2)
              ),
              labelColor: cPrimaryColor,
              unselectedLabelColor: cHeavyGrey,
              tabs: [
                Tab(text: "Notícias",),
                Tab(text: "Eventos")
              ],
            ),
          ),*/
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  title: Image.asset("assets/app/feed_title.png", scale:6),
                  automaticallyImplyLeading: false,
                  backgroundColor: cDirtyWhiteColor,
                  titleSpacing: 15,
                  elevation: 0,
                  floating: true,
                  //pinned: true,
                  snap: true,
                  actions: [Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBar(
                      isScrollable: true,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: cDirtyWhiteColor,
                          border: Border.all(color: cPrimaryColor, width: 2)
                      ),
                      labelColor: cPrimaryColor,
                      unselectedLabelColor: cHeavyGrey,
                      tabs: [
                        Tab(text:"Notícias"),
                        Tab(text: "Eventos")
                      ],
                    ),
                  ),
    ],
                )
              ];
            },
            body: TabBarView(
              children: [
                NewsFeed(),
                EventsFeed()
              ],
            ),
          ),
          /*Container(
            color: cDirtyWhiteColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: cDirtyWhite
                    ),
                    child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: cPrimaryColor, width: 2)
                      ),
                      labelColor: cPrimaryColor,
                      unselectedLabelColor: cHeavyGrey,
                      tabs: [
                        Tab(text: "Notícias",),
                        Tab(text: "Eventos")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),*/
        ),
    );
    //);



    return NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool isScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              title: Image.asset("assets/app/find_title.png", scale:5),
              backgroundColor: cDirtyWhiteColor,
              titleSpacing: 15,
            )
          ];
        },
        body: Text("A")
    );

  }
}
