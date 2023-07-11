import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../components/500.dart';
import '../../components/news_card.dart';
import '../../components/simple_dialog_box.dart';
import '../../consts/color_consts.dart';
import '../../utils/connectivity.dart';
import '../../utils/news/article_data.dart';
import '../../utils/news/article_data_aux.dart';

class NewsFeed extends StatefulWidget {


  const NewsFeed({super.key});

  @override
  State<StatefulWidget> createState() => NewsState();
  }

class NewsState extends State<NewsFeed> {
  late Future<int> fetchDone;
  late ScrollController controller;
  late int offset;
  late bool hasMore;

  @override
  void initState() {
    super.initState();
    offset = 0;
    hasMore = true;
    fetchDone = fetchNews();
    controller = ScrollController()..addListener(handleScrolling);
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }

  Future<int> fetchNews() async {
    final limit = 3;

    try {
      final statusCode = await ArticleAux.fetchNews(limit, offset.toString(), {});

      if (statusCode == 200) {
        setState(() {
          hasMore = ArticleAux.news.length < ArticleAux.numNews;
        });
      }

      return statusCode;
    } catch (e) {
      print('Error fetching news: $e');
      return 500;
    }
  }

  void handleScrolling() {
    if (controller.offset == controller.position.maxScrollExtent && hasMore) {
      setState(() {
        offset += 3;
      });
      fetchNews();
    }
  }

  Future<void> refresh() async {
    setState(() {
      hasMore = true;
      offset = 0;
      ArticleAux.news.clear();
    });
    await fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cDirtyWhiteColor,
      child: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<int>(
              future: fetchDone,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(cPrimaryOverLightColor),
                    backgroundColor: cPrimaryLightColor,
                  );
                } else if (snapshot.hasData) {
                  if (snapshot.data == 500) {
                    return Error500();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: ArticleAux.news.map((e) => NewsCard(e as Article)).toList(),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: cPrimaryLightColor,
                    ),
                  );
                }
                return Container(); // Empty container if none of the above conditions are met
              },
            ),
          ),
        ),
      ),
    );
  }
}
