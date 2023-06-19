import 'package:flutter/material.dart';
import 'package:UniVerse/bars/web_bar.dart';
import '../consts/color_consts.dart';
import '../main_screen/components/about_bottom.dart';

class NewsWebPage extends StatelessWidget {
  NewsWebPage({super.key});
  @override
  ScrollController yourScrollController = ScrollController();
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar(
        thumbVisibility: true, //always show scrollbar
        thickness: 8, //width of scrollbar
        interactive: true,
        radius: const Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
        controller: yourScrollController,
        child: SingleChildScrollView(
          controller: yourScrollController,
          child: Container(
            color: cDirtyWhite,
            child: Stack(
              children: <Widget> [
                Padding(
                  padding: EdgeInsets.only(top: size.height/5),
                  child: Column(
                    children: [
                      Container(                //Zona do Feed
                        height: size.height * 1.4,
                        width: size.width/2,
                        color: cDirtyWhite,
                        child: ListView.builder(
                          itemCount: _articles.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = _articles[index];
                            return Container(
                              height: 200,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xFFE0E0E0)),
                                  borderRadius: BorderRadius.circular(8.0)),
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 8),
                                          Text("${item.author} · ${item.postedOn}",
                                              style: Theme.of(context).textTheme.caption),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icons.bookmark_border_rounded,
                                              Icons.share,
                                              Icons.more_vert
                                            ].map((e) {
                                              return InkWell(
                                                onTap: () {},
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Icon(e, size: 16),
                                                ),
                                              );
                                            }).toList(),
                                          )
                                        ],
                                      )
                                  ),
                                  Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(8.0),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(item.imageUrl),
                                          )
                                      )
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      BottomAbout(size: size)
                    ],
                  ),
                ),
                Container(
                  color: cDirtyWhite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomWebBar(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Article {
  final String title;
  final String imageUrl;
  final String author;
  final String postedOn;

  Article(
      {required this.title,
        required this.imageUrl,
        required this.author,
        required this.postedOn});
}

final List<Article> _articles = [
  Article(
    title: "Instagram quietly limits ‘daily time limit’ option",
    author: "MacRumors",
    imageUrl: "https://picsum.photos/id/1000/960/540",
    postedOn: "Yesterday",
  ),
  Article(
      title: "Google Search dark theme goes fully black for some on the web",
      imageUrl: "https://picsum.photos/id/1010/960/540",
      author: "9to5Google",
      postedOn: "4 hours ago"),
  Article(
    title: "Check your iPhone now: warning signs someone is spying on you",
    author: "New York Times",
    imageUrl: "https://picsum.photos/id/1001/960/540",
    postedOn: "2 days ago",
  ),
  Article(
    title:
    "Amazon’s incredibly popular Lost Ark MMO is ‘at capacity’ in central Europe",
    author: "MacRumors",
    imageUrl: "https://picsum.photos/id/1002/960/540",
    postedOn: "22 hours ago",
  ),
  Article(
    title:
    "Panasonic's 25-megapixel GH6 is the highest resolution Micro Four Thirds camera yet",
    author: "Polygon",
    imageUrl: "https://picsum.photos/id/1020/960/540",
    postedOn: "2 hours ago",
  ),
];