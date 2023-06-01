import 'package:flutter/material.dart';

import '../components/news_card.dart';
import '../consts/color_consts.dart';
import '../utils/news/article_data.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cDirtyWhiteColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: Article.news.map((e) => NewsCard(e)).toList(),
            //SizedBox(height: 10,)
          ),
        ),
      ),
    );
  }
}